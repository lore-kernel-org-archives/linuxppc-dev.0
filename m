Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 330561A08F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 16:43:13 +1100 (AEDT)
Received: by mail-yh0-f53.google.com with SMTP id i57so2419615yha.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:43:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <544DE8F9.5070100@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-10-git-send-email-kernelfans@gmail.com>
 <544DE8F9.5070100@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:43:10 +0800
Message-ID: <CAFgQCTszjH1X2qpugE1-B5jXPv7kG3dVrnGa5xBREf2UaRRt-Q@mail.gmail.com>
Subject: Re: [RFC 09/11] powerpc: kvm: handle time base on secondary hwthread
From: Liu ping fan <kernelfans@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 2:40 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
>> (This is a place holder patch.)
>> We need to store the time base for host on secondary hwthread.
>> Later when switching back, we need to reprogram it with elapse
>> time.
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index 89ea16c..a817ba6 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -371,6 +371,8 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
>>
>>       /* fixme: store other register such as msr */
>>
>> +     /* fixme: store the tb, and set it as MAX, so we cease the tick on secondary */
>
> This can lead to serious consequences. First of all, even if we set the
> decrementer(not tb) to MAX, it is bound to fire after 4s. That is the
> maximum time till which you can keep off the decrementer from firing.
>
> In the hotplug path, the offline cpus nap and their decrementers are
> programmed to fire at MAX too. But the difference is that we clear the
> LPCR_PECE1 wakeup bit which prevents cpus from waking up on a
> decrementer interrupt.
>
> We cannot afford to do this here though because there are other tasks on
> the secondary threads' runqueue. They need to be scheduled in.
> There are also timers besides the tick_sched one, which can be queued on
> these secondary threads. These patches have not taken care to migrate
> timers or tasks before entering guest as far as I observed. Hence we
> cannot just turn off time base like this and expect to handle the above
> mentioned events the next time the primary thread decides to exit to the
> host.
>
Yes, that is the nut in this series. My plan is to compensate the
hrtimer when the secondary exit.
But as to the scheduler on secondary, if it is ceased, what is side-effect?

Thx,
Fan

> Regards
> Preeti U Murthy
>> +
>>       /* prevent us to enter kernel */
>>       li      r0, 1
>>       stb     r0, HSTATE_HWTHREAD_REQ(r13)
>> @@ -382,6 +384,10 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
>>
>>  /* enter with vmode */
>>  kvmppc_secondary_stopper_exit:
>> +     /* fixme: restore the tb, with the orig val plus time elapse
>> +         * so we can fire the hrtimer as soon as possible
>> +         */
>> +
>>       /* fixme, restore the stack which we store on lpaca */
>>
>>       ld      r0, 112+PPC_LR_STKOFF(r1)
>>
>

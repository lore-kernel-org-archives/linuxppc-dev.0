Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydjsx3k8KzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 03:16:36 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAHGD2Eq038446
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 11:16:33 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9ykw2qw3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 11:16:32 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 17 Nov 2017 11:16:31 -0500
Subject: Re: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, alexander.h.duyck@intel.com
Cc: Michael Ellerman <michaele@au1.ibm.com>, dipankar@linux.vnet.ibm.com,
 stable@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, brking@pobox.com
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
 <20171116113358.00001d5a@intel.com>
 <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
 <87375dvnkv.fsf@concordia.ellerman.id.au>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 10:16:28 -0600
MIME-Version: 1.0
In-Reply-To: <87375dvnkv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <678bfe68-286a-0ac8-23c3-1c40c9d5c4c3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2017 04:57 PM, Michael Ellerman wrote:
> Brian King <brking@linux.vnet.ibm.com> writes:
> 
>> On 11/16/2017 01:33 PM, Jesse Brandeburg wrote:
>>> On Thu, 16 Nov 2017 09:37:48 -0600
>>> Brian King <brking@linux.vnet.ibm.com> wrote:
>>>
>>>> Resending as the first attempt is not showing up in the list archive.
>>>>
>>>> This patch converts several network drivers to use smp_rmb
>>>> rather than read_barrier_depends. The initial issue was
>>>> discovered with ixgbe on a Power machine which resulted
>>>> in skb list corruption due to fetching a stale skb pointer.
>>>> More details can be found in the ixgbe patch description.
>>>
>>> Thanks for the fix Brian, I bet it was a tough debug.
>>>
>>> The only users in the entire kernel of read_barrier_depends() (not
>>> smp_read_barrier_depends) are the Intel network drivers.
>>>
>>> Wouldn't it be better for power to just fix read_barrier_depends to do
>>> the right thing on power? The question I'm not sure of the answer to is:
>>> Is it really the wrong barrier to be using or is the implementation in
>>> the kernel powerpc wrong?
>>>
>>> So I think the right thing might actually to be to:
>>> Fix arch powerpc read_barrier_depends to not be a noop, as the
>>> semantics of the read_barrier_depends seems to be sufficient to solve
>>> this problem, but it seems not to work for powerpc?
>>
>> Jesse,
>>
>> Thanks for the quick response.
>>
>> Cc'ing linuxppc-dev as well. 
>>
>> I did think about changing the powerpc definition of read_barrier_depends,
>> but after reading up on that barrier, decided it was not the correct barrier
>> to be used in this context. Here is some good historical background on
>> read_barrier_depends that I found, along with an example.
>>
>> https://lwn.net/Articles/5159/
>>
>> Since there is no data-dependency in the code in question here, I think
>> the smp_rmb is the proper barrier to use.
> 
> Yes I agree.
> 
> The read_barrier_depends() is correct to order the load of eop_desc and
> then the dependent load of eop_desc->wb.status, but it's only required
> or does anything on Alpha.
> 
>> For background, the code in question looks like this:
>>
>> CPU 1                                   CPU2
>> ============================            ============================
>> 1: ixgbe_xmit_frame_ring                ixgbe_clean_tx_irq
>> 2:  first->skb = skb                     eop_desc = tx_buffer->next_to_watch
>>                                          if (!eop_desc)
>>                                              break;
>> 3:  ixgbe_tx_map                         read_barrier_depends()
>>                                          if (!(eop_desc->wb.status) ... )
>>                                              break;
>> 4:   wmb                                 
>> 5:   first->next_to_watch = tx_desc      napi_consume_skb(tx_buffer->skb ..);
>> 6:   writel(i, tx_ring->tail);
>>
>> What we see on powerpc is that tx_buffer->skb on CPU2 is getting loaded
>> prior to tx_buffer->next_to_watch. Changing the read_barrier_depends
>> to a smp_rmb solves this and prevents us from dereferencing old pointer.
> 
> Right. Given that read_barrier_depends() is a nop, there's nothing there
> to order the load of tx_buffer->skb vs anything else.
> 
> If it's actually the load of tx_buffer->skb that's the issue then the
> smp_rmb() should really be immediately prior to that, rather than where
> the read_barrier_depends() currently is.

Alex,

How would you like to proceed? read_barrier_depends is a noop on all archs
except alpha and blackfin. On those two archs, read_barrier_depends and
smp_rmb end up resulting in the same code. So, I can either:

1. Remove the setting of tx_buffer->skb to NULL to address your concern and proceed
with the rest of the patch set unchanged.

2. Leave the read_barrier_depends, as it is the right barrier to order the load
of eop_desc with respect to eop_desc->wb.status, and then *add* an smp_rmb in
the same code path to address the speculative load of the skb that I was running into.
This is arguably more pure from the perspective of the use of the different
barriers, but has the downside of additional overhead on alpha and blackfin.

Do you have a preference? 

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 034AA1A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 22:20:23 +1100 (AEDT)
Received: from mail-yk0-x244.google.com (mail-yk0-x244.google.com
 [IPv6:2607:f8b0:4002:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A953140778
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Feb 2016 22:20:22 +1100 (AEDT)
Received: by mail-yk0-x244.google.com with SMTP id z7so2525426yka.1
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Feb 2016 03:20:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJe8K2iVOy9=Ds09_ePct3xR6qCH0U4XoKW-qP_TNEMe8GAmQ@mail.gmail.com>
References: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
 <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
 <1452599615.20985.2.camel@ellerman.id.au>
 <CAOJe8K2iVOy9=Ds09_ePct3xR6qCH0U4XoKW-qP_TNEMe8GAmQ@mail.gmail.com>
Date: Fri, 5 Feb 2016 14:20:17 +0300
Message-ID: <CAOJe8K2Ahh-y95BmpsP+d2P9ysUsyo5CnhPOXymEJzjFwkR=7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc: tracing: don't trace hcalls on offline
 CPUs
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/19/16, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> On 1/12/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On Mon, 2015-12-14 at 23:18 +0300, Denis Kirjanov wrote:
>>
>>> ./drmgr -c cpu -a -r gives the following warning:
>>>
>>> [ 2327.035563]
>>> RCU used illegally from offline CPU!
>>> rcu_scheduler_active = 1, debug_locks = 1
>>> [ 2327.035564] no locks held by swapper/12/0.
>>> [ 2327.035565]
>>> stack backtrace:
>>> [ 2327.035567] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G S
>>> 4.3.0-rc3-00060-g353169a #5
>>> [ 2327.035568] Call Trace:
>>> [ 2327.035573] [c0000001d62578e0] [c0000000008977fc]
>>> .dump_stack+0x98/0xd4
>>> (unreliable)
>>> [ 2327.035577] [c0000001d6257960] [c000000000109bd8]
>>> .lockdep_rcu_suspicious+0x108/0x170
>>> [ 2327.035580] [c0000001d62579f0] [c00000000006a1d0]
>>> .__trace_hcall_exit+0x2b0/0x2c0
>>> [ 2327.035584] [c0000001d6257ab0] [c00000000006a2e8]
>>> plpar_hcall_norets_trace+0x70/0x8c
>>> [ 2327.035588] [c0000001d6257b20] [c000000000067a14]
>>> .icp_hv_set_cpu_priority+0x54/0xc0
>>> [ 2327.035592] [c0000001d6257ba0] [c000000000066c5c]
>>> .xics_teardown_cpu+0x5c/0xa0
>>> [ 2327.035595] [c0000001d6257c20] [c0000000000747ac]
>>> .pseries_mach_cpu_die+0x6c/0x320
>>> [ 2327.035598] [c0000001d6257cd0] [c0000000000439cc] .cpu_die+0x3c/0x60
>>> [ 2327.035602] [c0000001d6257d40] [c0000000000183d8]
>>> .arch_cpu_idle_dead+0x28/0x40
>>> [ 2327.035606] [c0000001d6257db0] [c0000000000ff1dc]
>>> .cpu_startup_entry+0x4fc/0x560
>>> [ 2327.035610] [c0000001d6257ed0] [c000000000043728]
>>> .start_secondary+0x328/0x360
>>> [ 2327.035614] [c0000001d6257f90] [c000000000008a6c]
>>> start_secondary_prolog+0x10/0x14
>>> [ 2327.035620] cpu 12 (hwid 12) Ready to die...
>>> [ 2327.144463] cpu 13 (hwid 13) Ready to die...
>>> [ 2327.294180] cpu 14 (hwid 14) Ready to die...
>>> [ 2327.403599] cpu 15 (hwid 15) Ready to die...
>>>
>>> Make the hypervisor tracepoints conditional
>>> by using TRACE_EVENT_FN_COND
>>>
>>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>
> Hi Steven,
>
> please apply with Michael's acked-by tag.

ping

>
> Thanks!
>>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> cheers
>>
>>
>

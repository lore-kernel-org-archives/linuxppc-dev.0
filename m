Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 893B31A0B84
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 18:39:37 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so85765506ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2015 23:39:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563C4FC9.3070004@linux.vnet.ibm.com>
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
 <CAOJe8K1wEQWiOYU+2xXOQ8XK61+1XFi+GxWQ2SUW=Dx5-risMQ@mail.gmail.com>
 <563C4FC9.3070004@linux.vnet.ibm.com>
Date: Fri, 6 Nov 2015 10:39:35 +0300
Message-ID: <CAOJe8K0z6o=KhU-0htaGrk3UoyZMd9=CzeTFDnK7Nuf=oRfCKg@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] perf/powerpc:Add ability to sample intr machine
 state in powerpc
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, acme@redhat.com, hemant@linux.vnet.ibm.com,
 dsahern@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, jolsa@redhat.com, khandual@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/6/15, Anju T <anju@linux.vnet.ibm.com> wrote:
> Hi Denis,
>
> On Wednesday 04 November 2015 02:26 PM, Denis Kirjanov wrote:
>> On 11/3/15, Anju T <anju@linux.vnet.ibm.com> wrote:
>>> This short patch series adds the ability to sample the interrupted
>>> machine state for each hardware sample.
>>>
>>> To test this patchset,
>>> Eg:
>>>
>>> $perf record -I ls   // record machine state at interrupt
>>> $perf script -D      //read the perf.data file
>> Uncovered the following warning with the series applied. Looks like
>> that it's not
>> directly related to your patches but anyway...
>
> May I know the config you used while testing?
> Did this warning appeared on boot time?

Hi Anju,

This happens when perf record is invoked.
I think you have to enable DEBUG_LOCKDEP

Thanks
>
> Thanks
>
> Anju
>
>>
>> [  507.655197] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
>> [  507.655220] ------------[ cut here ]------------
>> [  507.655226] WARNING: at kernel/locking/lockdep.c:3523
>> [  507.655230] Modules linked in: ipv6 binfmt_misc ehea
>> [  507.655242] CPU: 12 PID: 3746 Comm: ls Tainted: G S
>> 4.3.0-rc3-00103-g3b0e21e-dirty #11
>> [  507.655249] task: c0000005b607b290 ti: c0000005b62e8000 task.ti:
>> c0000005b62e8000
>> [  507.655255] NIP: c00000000010c944 LR: c00000000010c940 CTR:
>> c000000000659380
>> [  507.655261] REGS: c0000005b62eb5c0 TRAP: 0700   Tainted: G S
>>         (4.3.0-rc3-00103-g3b0e21e-dirty)
>> [  507.655266] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 22088422
>>   XER: 0000000e
>> [  507.655284] CFAR: c0000000008977c4 SOFTE: 0
>> GPR00: c00000000010c940 c0000005b62eb840 c00000000102e600
>> 000000000000002f
>> GPR04: 0000000000000001 c0000000001208d8 0000000000000000
>> 0000000000000001
>> GPR08: c000000000eee600 c0000005b607b290 0000000000000000
>> 0000000000003fef
>> GPR12: 0000000042088428 c00000000e956600 00000000001fffff
>> 00003fffd546c4b0
>> GPR16: 00000000001fffff 0000000000000013 c000000000b198a8
>> 0000000000000000
>> GPR20: c0000005acbb2f80 c0000005b5c5dd00 00003fffd546c500
>> 0000000000000001
>> GPR24: c00000000024af54 0000000000000000 0000000000000001
>> 0000000000000001
>> GPR28: 0000000000000000 0000000000000000 c0000005acbb2ea0
>> c000000001e0cf78
>> [  507.655376] NIP [c00000000010c944] .check_flags.part.36+0xd4/0x240
>> [  507.655382] LR [c00000000010c940] .check_flags.part.36+0xd0/0x240
>> [  507.655387] Call Trace:
>> [  507.655391] [c0000005b62eb840] [c00000000010c940]
>> .check_flags.part.36+0xd0/0x240 (unreliable)
>> [  507.655400] [c0000005b62eb8c0] [c0000000001112b8]
>> .lock_acquire+0x208/0x2a0
>> [  507.655407] [c0000005b62eb990] [c00000000024af80]
>> .__might_fault+0xb0/0xf0
>> [  507.655415] [c0000005b62eba10] [c0000000004d5d38]
>> .strnlen_user+0x1d8/0x200
>> [  507.655422] [c0000005b62ebad0] [c00000000032fa0c]
>> .load_elf_binary+0x103c/0x1650
>> [  507.655430] [c0000005b62ebc10] [c0000000002bac54]
>> .search_binary_handler+0xc4/0x260
>> [  507.655437] [c0000005b62ebcb0] [c0000000002bcd54]
>> .do_execveat_common.isra.22+0x7d4/0xb40
>> [  507.655444] [c0000005b62ebda0] [c0000000002bd4a8]
>> .SyS_execve+0x38/0x50
>> [  507.655451] [c0000005b62ebe30] [c00000000000916c]
>> system_call+0x38/0xd0
>> [  507.655456] Instruction dump:
>> [  507.655461] 419e0034 3d4200e5 392a3280 81290000 2f890000 40fe0020
>> 3c62ffad 3c82ffad
>> [  507.655475] 3863c038 38841f88 4878adfd 60000000 <0fe00000> 3c62ffad
>> 38632010 4878ade9
>> [  507.655490] ---[ end trace 47284e8c92efaa7e ]---
>> [  507.655494] possible reason: unannotated irqs-on.
>> [  507.655498] irq event stamp: 2324
>> [  507.655501] hardirqs last  enabled at (2323): [<c00000000088ed24>]
>> ._raw_spin_unlock_irqrestore+0x54/0xd0
>> [  507.655510] hardirqs last disabled at (2324): [<c000000000009924>]
>> restore_irq_off+0x24/0x28
>> [  507.655518] softirqs last  enabled at (2184): [<c00000000009cb90>]
>> .__do_softirq+0x500/0x670
>> [  507.655526] softirqs last disabled at (2169): [<c00000000009d198>]
>> .irq_exit+0xd8/0x120
>>
>>> Sample output obtained for this patchset/ output looks like as follows:
>>>
>>> 331557004666 0x1988 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 4807/4807:
>>> 0xc0000000001ddf60 period: 1 addr: 0
>>> ... intr regs: mask 0x7ffffffffff ABI 64-bit
>>> .... gpr0  0xc0000000001e6a74
>>> .... gpr1  0xc0000000ff33b9a0
>>> .... gpr2  0xc000000001523000
>>> .... gpr3  0xc000000ffa9deb60
>>> .... gpr4  0xc0000000ff971e00
>>> .... gpr5  0x4d32564532
>>> .... gpr6  0x1e000000
>>> .... gpr7  0x0
>>> .... gpr8  0x0
>>> .... gpr9  0x0
>>> .... gpr10 0x1
>>> .... gpr11 0x0
>>> .... gpr12 0x24022822
>>> .... gpr13 0xc00000000feeaf80
>>> .... gpr14 0x0
>>> .... gpr15 0xc0000000fbc21000
>>> .... gpr16 0x0
>>> .... gpr17 0xc000000ffa9c5000
>>> .... gpr18 0xc0000000ff33b8a0
>>> .... gpr19 0xc000000001523000
>>> .... gpr20 0xc0000000000a097c
>>> .... gpr21 0xc000000fcac65600
>>> .... gpr22 0xc0000000001e55a8
>>> .... gpr23 0xc000000001523000
>>> .... gpr24 0xc0000000ff33b850
>>> .... gpr25 0xc000000fcac65600
>>> .... gpr26 0xc000001e4b378210
>>> .... gpr27 0xfffffffffffffead
>>> .... gpr28 0x100000000
>>> .... gpr29 0xc000000fcac65600
>>> .... gpr30 0x1
>>> .... gpr31 0x0
>>> .... nip   0xc0000000001ddf68
>>> .... msr   0x9000000000009032
>>> .... orig_r3 0xc0000000001e5fcc
>>> .... ctr   0xc00000000009e1b0
>>> .... link  0xc0000000001e6a74
>>> .... xer   0x0
>>> .... ccr   0x84022882
>>> .... softe 0x0
>>> .... trap  0xf01
>>> .... dar   0x0
>>> .... dsisr 0xf00040060000004
>>>   ... thread: :4807:4807
>>>   ...... dso:
>>> /root/.debug/.build-id/1c/011201a1082e91b8449e6dd528f224d7a16535
>>>             :4807  4807   331.557004:          1 cycles:
>>> c0000000001ddf60
>>> .perf_ctx_unlock (/boot/vmlinux)
>>>
>>> 0x1b10 [0x188]: event: 9
>>>
>>>
>>> Changes from V2:
>>>
>>> - tools/perf/config/Makefile is moved to the patch tools/perf.
>>> - The patchset is reordered.
>>> - perf_regs_load() function is used for the dwarf unwind test.Since it
>>> is
>>> not required here,
>>>    it is removed from tools/perf/arch/powerpc/include/perf_regs.h 	
>>> - PERF_REGS_POWERPC_RESULT is removed.
>>>
>>>
>>>
>>>
>>>
>>> Anju T (3):
>>>    perf/powerpc:add ability to sample intr machine state in power
>>>    perf/powerpc :add support for sampling intr machine state
>>>    tools/perf:Map the ID values with register names
>>>
>>>   arch/powerpc/Kconfig                        |   1 +
>>>   arch/powerpc/include/uapi/asm/perf_regs.h   |  54 +++++++++++++
>>>   arch/powerpc/perf/Makefile                  |   2 +
>>>   arch/powerpc/perf/perf_regs.c               |  92
>>> ++++++++++++++++++++++
>>>   tools/perf/arch/powerpc/include/perf_regs.h | 114
>>> ++++++++++++++++++++++++++++
>>>   tools/perf/config/Makefile                  |   5 ++
>>>   6 files changed, 268 insertions(+)
>>>   create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
>>>   create mode 100644 arch/powerpc/perf/perf_regs.c
>>>   create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
>>>
>>> --
>>> 2.1.0
>>>
>>> _______________________________________________
>>>
>
>

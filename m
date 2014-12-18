Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 582531A0B75
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 02:02:54 +1100 (AEDT)
Message-ID: <5492EC9A.7060407@suse.de>
Date: Thu, 18 Dec 2014 16:02:50 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable
 in current_thread_info
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>	<5490D981.7040905@suse.de>	<1418879514.13333.2.camel@ellerman.id.au>
 <20141218172546.432de7f2@kryten>
In-Reply-To: <20141218172546.432de7f2@kryten>
Content-Type: text/plain; charset=windows-1252
Cc: Alan Modra <amodra@gmail.com>, ulrich.weigand@de.ibm.com, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18.12.14 07:25, Anton Blanchard wrote:
> On Thu, 18 Dec 2014 16:11:54 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
>> On Wed, 2014-12-17 at 02:16 +0100, Alexander Graf wrote:
>>> On 31.10.14 04:47, Anton Blanchard wrote:
>>>> LLVM doesn't support local named register variables and is
>>>> unlikely to. current_thread_info is using one, fix it by moving
>>>> it out and calling it __current_r1().
>>>>
>>>> I gave it a bit of an obscure name because we don't want anyone
>>>> else using it - they should use current_stack_pointer(). This
>>>> specific case is performance critical and we can't afford to call
>>>> a function to get it. Furthermore it isn't important to know
>>>> exactly where in the stack we are since we mask the lower bits.
>>>>
>>>> Signed-off-by: Anton Blanchard <anton@samba.org>
>>>
>>> Git bisect managed to point me to this commit as the offender for
>>> OOPSes on e5500 and e6500 (and maybe the G4 as well, not sure).
>>>
>>> Doing a git revert of this commit on top of linus/master makes
>>> things work fine for me again.
>>>
>>>
>>> Alex
>>>
>>> Oops: Kernel access of bad area, sig: 11 [#2]
>>> SMP NR_CPUS=16 CoreNet Generic
>>> Modules linked in:
>>> CPU: 1 PID: 339 Comm: kworker/1:1 Tainted: G      D
>>> 3.18.0-09423-g988adfd #1
>>> Workqueue: rpciod .rpc_async_schedule
>>> task: c0000001f6397500 ti: c0000001f6638000 task.ti:
>>> c0000001f6638000 NIP: c0000000004817a4 LR: c0000000004817a4 CTR:
>>> 0000000000000000 REGS: c0000001f663b0e0 TRAP: 0300   Tainted:
>>> G      D (3.18.0-09423-g988adfd)
>>> MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad2e42  XER: 00000000
>>> DEAR: 202031303438355f ESR: 0000000000000000 SOFTE: 1
>>       = r9 + 40
>>
>>> GPR00: c0000000004817a4 c0000001f663b360 c000000000988028
>>> 000000007f24333d GPR04: 5ff5738c1f2ebfb1 0000000000000000
>>> 0000000000000000 00000000000008f8 GPR08: c000000000480ae8
>>> 2020313034383537 36204b4220617320 6469726563740a31 GPR12:
>>> 3937302d30312d30 c00000000fff8780 c00000000007f988 c0000001f64c1600
>>
>> GPRs 9-12 say: " 1048576 KB as direct\n1970-01-0"
>>
>> Which is rarely a good sign :)
>>
>> Looks like it might be part of your dmesg from setup_page_sizes().
>>
>>> GPR16: 0000000000000000 0000000000000000 0000000000000000
>>> 00000000000005dc GPR20: c0000000009b8028 c00000007e034200
>>> 0000000000000548 c000000000000000 GPR24: c0000001f663b4b0
>>> 00000000b225831e 0000000000000000 0000000000000080 GPR28:
>>> 0000000000000548 00000000000008f8 0000000000000548 0000000000000094
>>> NIP [c0000000004817a4] .__skb_checksum+0x194/0x378 LR
>>> [c0000000004817a4] .__skb_checksum+0x194/0x378 Call Trace:
>>> [c0000001f663b360] [c0000000004817a4] .__skb_checksum+0x194/0x378
>>> (unreliable)
>>> [c0000001f663b440] [c0000000004819b4] .skb_checksum+0x2c/0x3c
>>> [c0000001f663b4c0] [c0000000004fd0a8] .udp4_hwcsum+0xa8/0x16c
>>> [c0000001f663b560] [c0000000004fd440] .udp_send_skb+0x2d4/0x370
>>> [c0000001f663b600]
>>> [c0000000004fd51c] .udp_push_pending_frames+0x40/0x94
>>> [c0000001f663b680] [c0000000004fec08] .udp_sendpage+0x150/0x1b4
>>> [c0000001f663b770] [c00000000050ae54] .inet_sendpage+0xa0/0x120
>>> [c0000001f663b810] [c00000000059c8cc] .xs_sendpages+0x2d0/0x30c
>>> [c0000001f663b8d0]
>>> [c00000000059cae4] .xs_udp_send_request+0x58/0x120
>>> [c0000001f663b970] [c000000000598f04] .xprt_transmit+0x80/0x36c
>>> [c0000001f663ba20] [c0000000005942d8] .call_transmit+0x19c/0x254
>>> [c0000001f663bab0] [c00000000059ff64] .__rpc_execute+0xbc/0x3c0
>>> [c0000001f663bb90] [c0000000000797f8] .process_one_work+0x1c0/0x474
>>> [c0000001f663bc40] [c00000000007a518] .worker_thread+0x17c/0x54c
>>> [c0000001f663bd30] [c00000000007fa8c] .kthread+0x104/0x124
>>> [c0000001f663be30]
>>> [c000000000000884] .ret_from_kernel_thread+0x58/0xd4 Instruction
>>> dump: 7d1f3a14 7c6a1850 e9580000 7fbd4050 786334e4 e90a0000
>>> 7c63ba14 f8490028 7c63ea14 7d0903a6 e84a0008 4e800421 <e8490028>
>>> 7c641b78 78270464 e9580008
>>
>> Which is:
>>
>> add      r8, r31, r7
>> subf     r3, r10, r3
>> ld      r10, 0(r24)
>> subf    r29, r29, r8
>> rldicr   r3, r3, 6, 51
>> ld       r8, 0(r10)
>> add      r3, r3, r23
>> std      r2, 40(r9)
>> add      r3, r3, r29
>> mtctr    r8
>> ld       r2, 8(r10)
>> bctrl
>> ld       r2, 40(r9)	<---
>> mr       r4, r3
>> rldicr   r7, r1, 0, 49
>> ld      r10, 8(r24)
>>
>>
>> Which looks a bit odd. I'd expect us to be saving/restoring r2 to the
>> stack, though maybe r9 was pointing at the stack?
> 
> Nice catch! This looks like a compiler bug.
> 
>> Looking at your vmlinux.broken I don't see the same code gen.
> 
> For whatever reason we ended up with r10 this time:
> 
> 7c 2a 0b 78     mr      r10,r1
> ...
> f8 4a 00 28     std     r2,40(r10)
> 7c 63 ba 14     add     r3,r3,r23
> 7c e9 03 a6     mtctr   r7
> 7c 63 ea 14     add     r3,r3,r29
> 38 a0 00 00     li      r5,0
> e8 48 00 08     ld      r2,8(r8)
> 4e 80 04 21     bctrl
> e8 4a 00 28     ld      r2,40(r10)
> 
> The indirect function call is allowed to clobber r10, gcc is doing
> something very wrong here.

Yeah, I couldn't see why the patch really would break anything either,
but it does for me with this (not quite old) version of gcc.

I also don't see the breakage on LE machines that compile with a newer
version of gcc (4.8.3).


Alex

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7VwX0G0fzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 11:33:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [linux-next][DLPAR CPU][Oops] Kernel crash with CPU hotunplug
In-Reply-To: <1507185185.3792.12.camel@abdul.in.ibm.com>
References: <1507185185.3792.12.camel@abdul.in.ibm.com>
Date: Fri, 06 Oct 2017 11:32:57 +1100
Message-ID: <87lgkpyv2e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> linux-next kernel panic while DLPAR CPU add/remove operation in a loop.
>
> Test: CPU hot-unplug
> Machine Type: Power8 PowerVM LPAR
> kernel: 4.14.0-rc2-next-20170928
> gcc : 5.2.1
>
> trace logs
> ----------
> cpu 10 (hwid 10) Ready to die...
> cpu 11 (hwid 11) Ready to die...
> cpu 12 (hwid 12) Ready to die...
> cpu 13 (hwid 13) Ready to die...
> cpu 14 (hwid 14) Ready to die...
> cpu 15 (hwid 15) Ready to die...
> Unable to handle kernel paging request for data at address 0xdead4ead00000030

That's SPINLOCK_MAGIC plus 0x30.

> Faulting instruction address: 0xc000000001af38e4
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in: rpadlpar_io rpaphp bridge stp llc xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack nfnetlink iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_filter vmx_crypto pseries_rng rng_core binfmt_misc nfsd ip_tables x_tables autofs4
> CPU: 7 PID: 10657 Comm: systemd-udevd Not tainted 4.14.0-rc2-next-20170928-autotest #1
> task: c000000271b7cc00 task.stack: c00000026d504000
> NIP:  c000000001af38e4 LR: c000000001af3b48 CTR: c000000001af4270
> REGS: c00000026d5079e0 TRAP: 0380   Not tainted  (4.14.0-rc2-next-20170928-autotest)
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008882  XER: 20000000  
> CFAR: c000000001af3b44 SOFTE: 1 
> GPR00: c000000001af3b48 c00000026d507c60 c000000003572500 c00000026c0d4a80 
> GPR04: c00000026c0d4a80 c00000026b56b310 c0000000037d2500 dead4ead00000030 
> GPR08: 00000000000016f0 fffffffffffffff0 dead4ead00000000 c000000270b24420 
> GPR12: c000000001af4270 c00000000fdc1f80 00000000000029a3 000000000aba9500 
> GPR16: 000001000e4134f0 000000000aba9500 000000000000000f 0000000000000001 
> GPR20: 0000000120ff68d8 0000000120ff68d0 0000000120ff6a48 0000000120ff33f0 
> GPR24: 0000000120ff6550 c00000026b56b310 c00000027286d9b8 c0000000037d4d88 
> GPR28: c0000002727b17a0 c00000026c0d4a80 c00000027286da38 c00000026c0d4a80 
> NIP [c000000001af38e4] free_pipe_info+0x64/0x200
> LR [c000000001af3b48] put_pipe_info+0xc8/0x140
> Call Trace:
> [c00000026d507c60] [c00000027286da38] 0xc00000027286da38 (unreliable)
> [c00000026d507ca0] [c000000001af3b48] put_pipe_info+0xc8/0x140
> [c00000026d507ce0] [c000000001af43fc] pipe_release+0x18c/0x1e0
> [c00000026d507d20] [c000000001ae0efc] __fput+0x12c/0x4f0
> [c00000026d507d80] [c000000001ae12ec] ____fput+0x2c/0x50
> [c00000026d507da0] [c00000000178eb3c] task_work_run+0x17c/0x200
> [c00000026d507e00] [c00000000160adb8] do_notify_resume+0x1f8/0x220
> [c00000026d507e30] [c0000000015ebec4] ret_from_except_lite+0x70/0x74
> Instruction dump:
> 81230070 e94300b0 39080001 7d2900d0 38ea0030 f9066d98 7c0004ac 3d020026 
> e9086da0 3cc20026 39080001 f9066da0 <7d0038a8> 7d094214 7d0039ad 40c2fff4 

Which is:
  lwz     r9,112(r3)
  ld      r10,176(r3)		# r3 = struct pipe_inode_info *pipe, r10 = &pipe->user
  addi    r8,r8,1
  neg     r9,r9
  addi    r7,r10,48		# r7 = &(pipe->user->pipe_bufs)
  std     r8,28056(r6)
  hwsync
  addis   r8,r2,38
  ld      r8,28064(r8)
  addis   r6,r2,38
  addi    r8,r8,1
  std     r8,28064(r6)
  ldarx   r8,0,r7	<- fault
  add     r8,r9,r8
  stdcx.  r8,0,r7

Which is the atomic_long_add_return() in account_pipe_buffers().

>From the regs we can see:
  r3  = c00000026c0d4a80 
  r7  = dead4ead00000030 
  r10 = dead4ead00000000 

So pipe->user instead of being a pointer to a user_struct was actually
part of a spinlock.

There isn't a spinlock in struct pipe_inode_info, so probably pipe is
not actually a pointer to a struct pipe_inode_info at all.


There's not much more to go on, so memory corruption is my best guess.
Can you run with SLUB debugging on?

cheers

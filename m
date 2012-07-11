Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 386C32C0200
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2012 00:24:35 +1000 (EST)
In-Reply-To: <OF7810EBD9.B191A242-ONC1257A13.0031E9E3-C1257A13.00320D10@LocalDomain>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>	
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com> <1338589800.16119.58.camel@pasglop>	
 <4FC9456B.8090400@freescale.com> <1338593099.16119.60.camel@pasglop>
 <OFF2E739FE.A96EBAF2-ONC1257A11.00655546-C1257A11.0065978F@transmode.se>
 <1338672076.7150.2.camel@pasglop>
 <OF7810EBD9.B191A242-ONC1257A13.0031E9E3-C1257A13.00320D10@LocalDomain>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
Message-ID: <OF96FD460E.639EB713-ONC1257A38.004ECE07-C1257A38.004F2536@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 11 Jul 2012 16:24:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, support@abatron.ch,
 Bob Cochran <ppc@mindchasers.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 2012/06/04 11:06:41:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/06/02 23:21:16:
> >
> > On Sat, 2012-06-02 at 20:29 +0200, Joakim Tjernlund wrote:
> > >
> > > hmm, where does this go w.r.t the patch? Got the feeling that the
> > > best thing is to just turn MSR:DE on and be done with it?
> >
> > Not unconditionally, we need to have a close look, that might be ok
> > specifically for BookE 32-bit, it's certainly not ok for BookE 64-bit at
> > this point.
> >
> > For now, I'm ok with a debug CONFIG_* option.
> >
> > Also do we know if MSR:DE has any performance impact on any CPU ? I know
> > having DACs enabled has a major impact on some for example.
>
> I just sent a new patch, named
>   [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
> which will only add MSR_DE for booke under CONFIG_BDI_SWITCH

Now I tried running gdb in user space and then I get this(with the MSR_DE patch):
root@P2020RDB ~ # ./gdb busybox
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "powerpc-softfloat-linux-gnu"...
(no debugging symbols found)
(gdb) run
Starting program: /root/busybox
(no debugging syOops: Exception in kernel mode, sig: 5 [#1]
PREEMPT P1010 RDB
Modules linked in:
NIP: c00067dc LR: c02d1994 CTR: c004a97c
REGS: dfef9f10 TRAP: 2002   Not tainted  (3.4.0+)
MSR: 00021000 <CE,ME>  CR: 42002424  XER: 00000000
TASK = df9a0b10[429] 'gdb' THREAD: dfb9a000
GPR00: cc00cc00 dfb9bd70 df9a0b10 df9a0b10 df949ad0 c0396000 00000000 df949b0c
GPR08: 00000000 40000000 00002786 c03b0000 2b833af6 10493068 10490000 105a62a0
GPR16: 00000000 10490000 10490000 10490000 10490000 10490000 10490000 dfb2ce40
GPR24: df949ad0 c02e0000 c02e0000 c03b20a4 00000004 dfb9a000 c0399ce0 df9a0b10
NIP [c00067dc] __switch_to+0x74/0xc4
LR [c02d1994] __schedule+0x1a0/0x3c0
Call Trace:
[dfb9bd70] [dfb9a000] 0xdfb9a000 (unreliable)
[dfb9bd80] [c02d1994] __schedule+0x1a0/0x3c0
[dfb9bdc0] [c02d1cb8] preempt_schedule+0x54/0x74
[dfb9bdd0] [c0047fe0] try_to_wake_up+0x140/0x144
[dfb9bdf0] [c002b0bc] ptrace_resume+0x70/0xbc
[dfb9be00] [c002c044] ptrace_request+0x1e8/0x5f0
[dfb9bec0] [c00032c4] arch_ptrace+0x30/0x8f8
[dfb9bf10] [c002ba90] sys_ptrace+0xb4/0x3cc
[dfb9bf40] [c000cf4c] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfd607a4
    LR = 0x101a4900
Instruction dump:
41820040 80040234 7c184ba6 80040238 7c194ba6 8004023c 7c1c4ba6 80040240
7c1d4ba6 80040224 7c144ba6 80040228 <7c154ba6> 8004022c 7c164ba6 7c431378
---[ end trace 584ab4ed4087571b ]---

note: gdb[429] exited with preempt_count 268435458
mbols found)
(nBUG: scheduling while atomic: busybox/430/0x10000004
o debugging symbModules linked in:ols found)

When I remove the patch it works. I got no idea were it goes wrong,
any ideas?

 Jocke

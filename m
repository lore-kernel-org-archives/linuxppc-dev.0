Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Wed, 14 Jul 2004 13:33:47 +0800
From: "hu" <hl76@263.net>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Oops:kernel access of bad areasig:11
Mime-Version: 1.0
Content-Type: text/plain
Message-Id: <20040714053136.86F102F86F@smtp.263.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


1)environment
Linux kernel 2.4.4-rthal5
ppcboot 1.1.5
MPC823 board

2)I'm running a device driver which read data from touchpanel which use SIU_IRQ2, but I often get message like that:
Oops: kernel access of bad area, sig: 11
NIP: C000C4E8 XER: C000206F LR: C000C4E0 SP: C07FBEF0 REGS: c07fbe40 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004,DISR: 0000013C
last math 00000000   last altivec 00000000
GPR00: 00000002 C07FBEF0 C07FA000 C07FBF08 00009032 C0C09E58 C0C08000 00000020
GPR08: C01A9138 C0195364 C0C08000 C07FBF30 2F7B6A70 1007C2B8 40024400 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00003400 00580000 00002C7E
GPR24: 00000000 0001C200 00000001 C07FBEF8 00000000 C07FBF00 00664BDA C07FBEF0

Call backtrace:
  C000C468 C002B440 C0004DA8

3) I look through past document in linux-embedded, and I check /arch/ppc/kernel/m8xx_setup.c, it exists:
fp = binfo->bi_intfreq * 1000000 / 16;
and /arch/ppc/8xx_io/commproc.c, it exits:
#define BRG_INT_CLK	(((bd_t *)__res)->bi_intfreq * 1000000 )

------------------------------
John Hu
E-mail: hl76@263.net
------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

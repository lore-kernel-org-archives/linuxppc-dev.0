Reply-To: <charles@utstar.com>
From: "Charles Lee" <charles@utstar.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: re: preventing floating point exception terminating applications.
Date: Mon, 16 Aug 2004 15:54:07 -0400
Message-ID: <CKECJADCIGJOKLCDNALCMEDGCJAA.charles@utstar.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello!

I am using Linux Kernel 2.4.7 package for PPC from TimeSys.  I am
experiencing the SIGFPE which cause some application processes terminating
after runnning for several hours
(I has 16 ping processes running, after 5 hours later, 4 to 5 ping processes
has terminated due to "Floating point exception).

I has capture several Program Exceptions due to floating point exception as
follows:
(Where MSR[FE0] & MSR[FE1] are set and the trap is 0x0700 ---program
exception due the floating point)
============================================================================
===========================
<#1>Entance: Exception signal  err=8
Created: 2004/08/12 18:21:02
System had run:    0 days 05:03:40
NIP: 10077590 XER: 20000000 LR: 1003210C SP: 7FFFF6B0 REGS: c408bf50 TRAP:
0700
MSR: 0011f932 EE: 1 PR: 1 FP: 1 ME: 1 IR/DR: 11
curr TASK=c408a000[29948] 'check_alive' Syscall:173 Thread Sleep On:0
Locked Mutex:0  how many Locks:0
MSR=00009032   HID0=8000c088  HID1=70000000
sc_siumcr=01400000, sc_sypcr=ffffff83, sc_swsr=af31,  sc_bcr=00000000
sc_ppc_acr=03  sc_ppc_alrh=30126457  sc_ppc_alrl=89abcdef   sc_lcl_acr=03
sc_lcl_alrh=01263457  sc_lcl_alrl=89abcdef  sc_tescr1=00000000
sc_tescr2=00000000
sc_ltescr1=00000000  sc_ltescr2=00000000  sc_pdtea=00227250
sc_pdtem=00000020
sc_ldtea=00	sc_ldtem=00
ic_sicr=0000  ic_sivec=00000000  ic_sipnrh=00000002  ic_sipnrl=00000000
ic_siprr=06305770  ic_scprrh=05309770  ic_scprrl=05309770  ic_simrh=0000f900
ic_simrl=80405000  ic_siexr=00005900


<#2> Entance: Exception signal 8
Created: 2004/08/12 18:21:02
System had run:    0 days 05:03:40
NIP: 0FF5CB84 XER: 00000000 LR: 0FF542C8 SP: 7FFFEAB0 REGS: c443bf50 TRAP:
0700
MSR: 0011f932 EE: 1 PR: 1 FP: 1 ME: 1 IR/DR: 11
curr TASK=c443a000[3206] 'ping' Syscall:167 Thread Sleep On:0
Locked Mutex:0  how many Locks:0

<#3> Entance: Exception signal 8
Created: 2004/08/12 18:21:03
System had run:    0 days 05:03:41
NIP: 0FF5CB84 XER: 00000000 LR: 0FF542C8 SP: 7FFFEAB0 REGS: c43bdf50 TRAP:
0700
MSR: 0011f932 EE: 1 PR: 1 FP: 1 ME: 1 IR/DR: 11
curr TASK=c43bc000[3273] 'ping' Syscall:167 Thread Sleep On:0
Locked Mutex:0  how many Locks:0
MSR=00009032   HID0=8000c088  HID1=70000000
sc_siumcr=01400000, sc_sypcr=ffffff83, sc_swsr=af31,  sc_bcr=00000000
sc_ppc_acr=03  sc_ppc_alrh=30126457  sc_ppc_alrl=89abcdef   sc_lcl_acr=03
sc_lcl_alrh=01263457  sc_lcl_alrl=89abcdef  sc_tescr1=800a0000
sc_tescr2=00000000
sc_ltescr1=00000000  sc_ltescr2=00000000  sc_pdtea=00227250
sc_pdtem=00000020
sc_ldtea=00	sc_ldtem=00
ic_sicr=0000  ic_sivec=00000000  ic_sipnrh=00000002  ic_sipnrl=00000000
ic_siprr=06305770  ic_scprrh=05309770  ic_scprrl=05309770  ic_simrh=0000e900
ic_simrl=80405000  ic_siexr=00005900
============================================================================
===========

*******I am urgent for any expert us the recommendatons to resovle this
problem********
[1] If we don't any floating point calculation in our Linux system,  Can we
set MSR[FE0] & MSR[FE1]= = 0,
will this cause any problem ?
Will I still have exceptional trap generated?
Will I still have problem that my application terminated due the floating
point exceptions?


[2] If set MSR[FE0]=1 & MSR[FE1]=0 in the MPC8270(imprecise recoverable
mode),  Would this help in the 2.4.7 kernel?
because I saw the 2.4.7 kernel already does "isync" and "lazy FPU switching"
in the "load_up_fpu", which called from "FPUnavailable" in
<arch/ppc/kernel/head.S>.

My goal is that:  I don't want to kernel crash & reset,  and I don't want
the application terminated due to the floating point program exception.

Would some-one please,  thank you very much,


Charles


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

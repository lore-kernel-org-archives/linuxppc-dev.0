Date: Tue, 24 Aug 2004 22:56:33 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Oliver King-Smith <oliver.king-smith@nuvation.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem trying to address custom hardware
Message-ID: <20040825055633.GA28450@gate.ebshome.net>
References: <FC3C0DD86B79DF4FA423AF0379A547610155436D@mailguy2.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A547610155436D@mailguy2.nuvation.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 24, 2004 at 04:10:15PM -0700, Oliver King-Smith wrote:

[snip]

>  pCPLD->register1 = 1; // !!! CRASH !!!
> ...
>
> And I get a crash again. šThe value for pCPLD is in the 0xC3xxxxxx range.
> <1> init_module in cpld_module.c on line 22
> <4>CPLD located at virtual address c3019000 and held at c3017390
> <4>Data machine check in kernel mode.
> <4>Oops: machine check, sig: 7
> <4>NIP: C0014990 XER: 00000000 LR: C3017120 SP: C19ADDE0 REGS: c19add30
> TRAP: 0200ššš Tainted: P
> <4>MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> <4>TASK = c19ac000[80] 'insmod' Last syscall: 128
> <4>last math 00000000 last altivec 00000000
> <4>PLB0: bear= 0x40000000 acr=šš 0x00000000 besr=š 0x00c00000
> <4>PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000
> <4>
> <4>GPR00: 01000000 C19ADDE0 C19AC000 C301724C 00000000 00000001
> 00000020 C01F0000
> <4>GPR08: 000035BF C3019000 00000000 C19ADDEC 80042082 1003A0CC
> 00000000 00000000
> <4>GPR16: 00000000 00000001 00000000 00000000 00009032 019ADF40
> C19ADEA8 C1C25D00
> <4>GPR24: 0000000B C19ADF0C 1003BA38 C3010000 C3010000 C19ADDE8
> C3010000 C3010000
> <4>Call backtrace:
> <4>C0014AF0 C3017120 C0015D78 C000475C 1003BA38 10003A34 10004F2C
> <4>10008CA8 10008EC8 0FECAC30 00000000
> š
> If anyone could tell me what I am doing wrong, I would greatly
> appreciate it.
>

Did you setup External Bus Controller registers (EBC0_BnCR and
EBC0_BnAP, where n is equal to the chip select line connected to PLD)?

I suspect you didn't that's why you got Machine Check error.

In fact, take a look at PLB0 registers from the crash log above:
PLB0_BEAR contains phys addr of the invalid access - 0x4000'0000,
PLB0_BESR contains error status - 0x00c0'0000, which means "master 2
(DCU) PLB timeout".

Please read "Chapter 16" in 405EP user manual for more info about
External Bus controller.

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

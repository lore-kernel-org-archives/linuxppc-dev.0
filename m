Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: "linuxppc-embedded" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: help: why show "Oops: kernel access of bad area, sig: 11"
Date: Tue, 20 May 2003 21:51:02 -0400
References: <Law14-OE57bZ2ntWEqp00015e5b@hotmail.com>
In-Reply-To: <Law14-OE57bZ2ntWEqp00015e5b@hotmail.com>
MIME-Version: 1.0
Message-Id: <200305202151.02291.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 19, 2003 04:33 am, guo_zhenglin wrote:
>     Oops: kernel access of bad area, sig: 11
>     NIP: C0076F0C XER: 80009E6C LR: C007B620 SP: C017DE80 REGS:
> c017ddd0 TRAP: 0300d
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 000003F9, DSISR: 00018469
> TASK = c017c000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C017DE80 C017C000 C017DE88 00000001 00000000 C0D203B8
> 000003F8
> GPR08: 00000000 000003F8 00000000 00000000 0000000D FFFFFFFF C007AC70
> C007A4C4
> GPR16: C0079010 C0079CDC C007A5E0 C00770A8 C007701C C007A154 C00790E0
> C0079058
> GPR24: C0079D64 C0078F90 C0078F78 C00F28F8 C00F28F8 C011A76C C011A830
> C017DE88
> Call backtrace:
> C0011AE4 C0101028 C00FA5FC C00FA644 C00022CC C0006BE4
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..

When you get an "access of bad area" oops have a look at the DEAR
register (I think you misspelled it as DAR above).

0x3f9 is the base address of COM1 on an x86 machine
(http://www.sput.nl/hardware/io.html). My guess is you've got something
wrong with your UART code. I believe this is where your (current)
problem lies.

Just a guess.
	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

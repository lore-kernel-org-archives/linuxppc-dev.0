Date: Mon, 21 Aug 2000 16:51:29 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo <gongzhuo@163.net>
cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How to caculate the MIPS of my MVME2600?
In-Reply-To: <011401c00b48$c699e860$4607a8c0@LocalHost>
Message-ID: <Pine.HPX.4.10.10008211630400.15550-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,


> PPC1-Bug>bf 4000:4000 7c000378 ;w
> Effective address: 00004000
> Effective count  : &65536
> PPC1-Bug>as 4000
> 00004000 3D80FEF8  ADDIS       R12,R0,$FEF8?
> 00004004 81AC0100  LWZ         R13,$100(R12) ($00000100)
> 00004008 7C7602A6  MFSPR       R3,22
> 0000400C 7C000378  OR          R0,R0,R0? .
> PPC1-Bug>as 8000
> 00008000 7C9602A6  MFSPR       R4,22
> 00008004 81CC0100  LWZ         R14,$100(R12) ($00000100)
> 00008008 7C000378  OR          R0,R0,R0? .
> PPC1-Bug>br 8008
> BREAKPOINTS
> 00008008
> PPC1-Bug>g 4000
> Effective address: 00004000
> At Breakpoint
> IP     =00008008 MSR    =00003040 CR     =00000000 FPSCR  =00000000
> R0     =00000000 R1     =03F78000 R2     =00000000 R3     =3F0A7D37
> R4     =3F0A64CE R5     =00000000 R6     =00000000 R7     =00000000
> R8     =00000000 R9     =00000000 R10    =00000000 R11    =00000000
> R12    =FEF80000 R13    =0BF88E8D R14    =0BF89008 R15    =00000000
> R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
> R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
> R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
> R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
> SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
> 00008008 7C000378  OR          R0,R0,R0
> PPC1-Bug>
>
>
> The result:
> r4 -r3 = 0x1869 , r14 - r13 = 0x17B (379us) . There are 0x1000 asm
> instruction from 0x4000 to 0x8000 (4096), than the MIPS = 4096/379 = 10MIPS
> . It's impossilbe because the MPU is 200Mhz and bus is 67Mhz. The MIPS
> should be higher than 200MIPS.
>
>   I have made some mistakes? What are they?

That the instrucctions are fetched while you are executing them and that
you measure memory bandwidth. 16kB loaded in 380 microseconds into the
I-cache sound slow but is possible given the latency of RAM accesses on
2600 and the fact that you execute unmapped, execute the code twice
without entering PPPCBUG (add a loop) and measure the execution time
again...


BTW nops on the 603e execute at the speed of 1 per clock, so it will be
about 4096 clocks (21 us). If you replace them with pairs of:

	addi	r5,r5,0
	addi	r6,r6,0

it should go twice as fast (dual issue).

Oh, and don't believe the microsecond counter that precisely, the
decrementer is much more reliable (really!). It runs always close to 16.65
MHz, while the microsecond counter has roundoff error since the bus
period is 15nS (theoretical frequency ~ 66.667 Mhz). From a collection of
MVME2600 and 2400, I always get decrementer frequencies between 16.654 and
16.667 MHz and frequency errors given by NTP range between + and -10 ppm
except when there is a frequency measurement problem at boot.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

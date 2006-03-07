Return-Path: <rmcguire@uwbt.com>
Received: from mail19e.g19.rapidsite.net (unknown [204.202.242.20])
	by ozlabs.org (Postfix) with SMTP id A553F67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 16:52:18 +1100 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: "'David Hawkins'" <dwh@ovro.caltech.edu>
Subject: RE: GNU and Freescale MPC83xx / e300 core support?
Date: Mon, 6 Mar 2006 21:52:08 -0800
Message-ID: <000901c641ab$466428a0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <440CEF66.4090109@ovro.caltech.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All, 

Our meetings with Freescale were aimed specifically at the differences
between the MPC8280 and the MPC8360E. The most obvious core difference is
the Floating Point unit; the MPC8280, 603e or G2LE core had no floating
point ability at all.

I am not sure if its core support or not, but I know the MPC83xx line up has
drastically altered the bus architecture inside the chips. There are more
DMA engines now, and things like the DDR SDRAM bus and 60x / local Bus are
separated to run in parallel. Previously, in the 8260/8280 they were
mutually exclusive for bus cycles. Internally the shared bus now operates at
the DDR frequency, shortly to be DDR2 frequency for later masks. We should
see a very large performance improvement for memory intensive applications.
Same applies to the PCI 2.2 bus; it was also given separate pins and DMA
engines. According to the Freescale FAE the chip can handle simultaneous bus
cycles on all three busses at once. I do not have enough internal knowledge
on the compilers to know if this is a specific optimization, but it would
definitely hinder performance if we couldn't take advantage of it.

Freescale claims their newest revision of Metrowerks is optimized for these
newer cores, I guess one could get compile with a version of that and
disassemble it.

Aside:
I know the CPM of the older 82xx lineup has been removed, and so has the
optimization for its access to the 32 bit local bus. The QUICC engines have
replaced it and now have equal priority to all busses, though this probably
has little to do with the compiler.

Of random, if anyone is using the 'E' revisions of the 83xx lineup,
Freescale is claiming that the encryption engine is almost 10x faster than
their previous lineup of sister encryption chips that would normally partner
with the MPC8260 and MPC8280 chips.

I have another meeting tomorrow with Freescale, I can get more specifics.

-Russ

-----Original Message-----
From: David Hawkins [mailto:dwh@ovro.caltech.edu] 
Sent: Monday, March 06, 2006 6:27 PM
To: Russell McGuire
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: GNU and Freescale MPC83xx / e300 core support?

Russell McGuire wrote:
> I was recently involved in a meeting with a Freescale FAE, which informed
us
> that the current revisions of the GNU C/C++ compilers do not yet possess
any
> optimizations for the MPC83xx cores, more precisely no optimizations for
the
> e300 cores inside the MPC83xx line up.
> 
> They did say it was 100% backwards compatible with the existing 603e / 6xx
> core support, so all the code should work just fine.
> 
> I was curious if anyone out there was aware of any efforts to produce /
> patch any of the GNU compilers to have optimizations for these newer
> MPC83xx's with the e300 cores? 
> 

Hi Russ,

Out of interest, what are the main differences that optimization
would help with?

I'm going to take a look at the 8349E, but I'm waiting on the
Freescale MDS board.

I haven't read the user manual in great detail, other than to
check out the potential bus performance, but I thought
the main change in the G2 vs e300 core was the cache size.
Did they add new instructions, or change the number-of-cycles
required for existing instructions?

The Freescale document:

   Freescale PowerPCT Architecture Primer, POWRPCARCPRMRM,
   Rev. 0.1, 6/2005

   Has the following on page 12 of the PDF:

   e300 Cores and Platform
   The ongoing presence of the e300 testifies to the longevity
   of both the PowerPC architecture and the microarchitecture.
   The e300 was introduced in 1994 as the MPC603, running at
   100 MHz, and continues to be proliferated more than a decade
   later reaching speeds exceeding 600 MHz. The e300 PowerPC
   core and platform address the low- to mid-range performance
   needs of the market. The e300 core is an enhanced version
   of the popular PowerPC 603e core used in previous-generation
   PowerQUICC II devices that scale from 266 to 667 MHz in
   130 nm process technology. Enhancements include twice as
   much L1 cache as the 603e (32-Kbyte data and instruction
   caches) with integrated parity checking and other
   performance-oriented features. The e300 core is fully
   software-compatible with existing 603e core-based products
   and provides the processing foundation for the company's new
   MPC8349E PowerQUICC IIT Pro communications processor family.

So I guess the question is what are the

  'other performance-oriented features'

this statement is referring to?

The e300 core reference manual comments:

     The e300c1core integrates five execution units: an integer
     unit (IU), a floating-point unit (FPU), a branch processing
     unit (BPU), a load/store unit (LSU), and a system register
     unit (SRU). The ability to execute five instructions in
     parallel and the use of simple instructions with rapid
     execution times yield high efficiency and throughput
     for e300-core-based systems. Most integer instructions
     execute in one clock cycle. On the e300c1 core, the FPU is
     pipelined so a single-precision multiply-add instruction
     can be issued and completed every clock cycle.

So I guess an important optimization would be to keep each
execution unit busy. I haven't looked at an older 603e manual,
do they have fewer units?

Cheers
Dave

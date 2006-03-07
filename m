Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7FA4967B17
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 13:27:15 +1100 (EST)
Message-ID: <440CEF66.4090109@ovro.caltech.edu>
Date: Mon, 06 Mar 2006 18:26:46 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Russell McGuire <rmcguire@uwbt.com>
Subject: Re: GNU and Freescale MPC83xx / e300 core support?
References: <000301c6418a$86b32ee0$6405a8c0@absolut>
In-Reply-To: <000301c6418a$86b32ee0$6405a8c0@absolut>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Russell McGuire wrote:
> I was recently involved in a meeting with a Freescale FAE, which informed us
> that the current revisions of the GNU C/C++ compilers do not yet possess any
> optimizations for the MPC83xx cores, more precisely no optimizations for the
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

   Freescale PowerPC™ Architecture Primer, POWRPCARCPRMRM,
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
   MPC8349E PowerQUICC II™ Pro communications processor family.

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

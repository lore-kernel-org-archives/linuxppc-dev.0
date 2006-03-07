Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AA61679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 17:07:16 +1100 (EST)
In-Reply-To: <000901c641ab$466428a0$6405a8c0@absolut>
References: <000901c641ab$466428a0$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <98F6E546-9476-4CA2-8C83-D889FC1F37C7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GNU and Freescale MPC83xx / e300 core support?
Date: Tue, 7 Mar 2006 00:07:25 -0600
To: "Russell McGuire" <rmcguire@uwbt.com>
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


On Mar 6, 2006, at 11:52 PM, Russell McGuire wrote:

> All,
>
> Our meetings with Freescale were aimed specifically at the differences
> between the MPC8280 and the MPC8360E. The most obvious core  
> difference is
> the Floating Point unit; the MPC8280, 603e or G2LE core had no  
> floating
> point ability at all.

I'm not sure what the FAE is telling you but its wrong.  All current  
PQ2 processors have FP in the 603 core.

Will e300 had an instruction or two, they are very minor things with  
respect to the compiler.  Its possible that the scheduler could be  
tuned for e300 above and beyond what exists for the 603.

> I am not sure if its core support or not, but I know the MPC83xx  
> line up has
> drastically altered the bus architecture inside the chips. There  
> are more
> DMA engines now, and things like the DDR SDRAM bus and 60x / local  
> Bus are
> separated to run in parallel. Previously, in the 8260/8280 they were
> mutually exclusive for bus cycles. Internally the shared bus now  
> operates at
> the DDR frequency, shortly to be DDR2 frequency for later masks. We  
> should
> see a very large performance improvement for memory intensive  
> applications.
> Same applies to the PCI 2.2 bus; it was also given separate pins  
> and DMA
> engines. According to the Freescale FAE the chip can handle  
> simultaneous bus
> cycles on all three busses at once. I do not have enough internal  
> knowledge
> on the compilers to know if this is a specific optimization, but it  
> would
> definitely hinder performance if we couldn't take advantage of it.
>
> Freescale claims their newest revision of Metrowerks is optimized  
> for these
> newer cores, I guess one could get compile with a version of that and
> disassemble it.

I truly doubt the Metrowerks compiler takes into account anything  
beyond the core differences.  As I said earlier, the scheduler in GCC  
could probably be tuned for e300.  Beyond that there is little to be  
done that is specific for the e300.

- kumar

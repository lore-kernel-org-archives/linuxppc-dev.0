Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id A52D22BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 04:10:19 +1100 (EST)
Date: Fri, 10 Dec 2004 10:09:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Colin Wernham <CWernham@Airspan.com>
Message-ID: <20041210100958.C31319@home.com>
References: <3506EDCDEC47904CBE6FD2E1DEEA89840205BCAA@fs5.airspan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3506EDCDEC47904CBE6FD2E1DEEA89840205BCAA@fs5.airspan.com>;
	from CWernham@Airspan.com on Fri, Dec 10, 2004 at 09:09:39AM -0000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC4XX DMA polarity bug in linuxppc-2.6.9
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 10, 2004 at 09:09:39AM -0000, Colin Wernham wrote:
> I believe that there is a PPC4xx DMA driver bug in the following kernel, 

<snip>

> Cause is (I believe):
> /arch/ppc/syslib/ppc4xx_dma.c:
> On line 469 the old polarity bits in p_dma_ch are ORed in when it should 
> be ORing in the new polarity bits from p_init. p_init is then saved into 
> p_dma_ch. This means that it only gets correctly programmed when the 
> function is called twice:
> 
>     467  /* clear all polarity signals and then "or" in new signal levels */
>     468  polarity &= ~GET_DMA_POLARITY(dmanr);
>     469  polarity |= p_dma_ch->polarity;
> 
> Fix should be:
>     469  polarity |= p_init->polarity;

Yes, that's a real bug.  Can you make a patch according to
Documentation/SubmittingPatches, add your signed off line, and
send to me or this list? This clear bug fix should go in
before 2.6.10.

> Is there anyone else using the PPC4XX DMA?

Yes, I've used this library code for simple memory<->memory DMA
tests to verify that programmed and SG mode work. For more common
setups like peripheral driven DMA from the EBC, I've simply programmed
the DMA engine directly.  This library doesn't seem to simplify anything
for me in those cases (it's just a thin wrapper around registers) so
I find it easier to program the DMA engine regs directly within the
driver that is making use of a channel. I've been keeping it around
since apparently a lot of people make use of it in hopes that
somebody might take the time to improve it.

Since the my apps that would exercise the polarity bits in the
init code don't use this library, I guess that's why I've never
run into this problem. :)

-Matt

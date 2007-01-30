Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA017DDFB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 06:51:22 +1100 (EST)
In-Reply-To: <566482.71958.qm@web58805.mail.re1.yahoo.com>
References: <566482.71958.qm@web58805.mail.re1.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE8AB2BC-2B25-4751-B7D8-78416A5BB8E8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8248 poor performance
Date: Tue, 30 Jan 2007 13:48:36 -0600
To: Paul Eaton <recon_pje@yahoo.com>
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


On Jan 30, 2007, at 1:41 PM, Paul Eaton wrote:

> Thanks Kumar for your suggestion to look into the I-cache and D- 
> cache initialization.
>
> I verified that neither the IBAT or DBAT tables are initialized. It  
> appears this operation is not handled by u-boot but rather the OS  
> is expected to configure the cache parameters. This is a problem  
> for my application given that we don't boot an OS after u-boot  
> completes.
>
> I've attempted to poke in the values that I feel are needed for the  
> BAT registers as well as HID0 with an Abatron, but my card resets  
> when I attempt to run after the values are loaded.

Yeah, setting up BATs this way is bound to cause issues.

If you want, take a look at the 83xx code in u-boot which now uses  
BATs to improve performance (allows for proper caching, etc.).

> Would you happen to know what linux module is used to set up cache  
> parameters on a MPC8248 (8260 class) processor? I'd like to look  
> over how Linux handles it to see if I'm missing something in the  
> initialization sequence.

The caches are setup via setup_common_caches in arch/powerpc/kernel/ 
cpu_setup_6xx.S

> I don't see the sequence documented anywhere in the Freescale  
> documents and the trial and error method with the Abatron is  
> getting old.
>
> Paul

- kumar

>
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jan 26, 2007, at 1:42 PM, Paul Eaton wrote:
>
> > Hi,
> >
> > We have a custom 8248 card that we are testing.
> > The core is running at 400MHz and the system bus is 80Mhz (measured
> > and verified), 32 bit wide memory interface.
> > There is nothing connected to the CPM except 1 RS232 port which is
> > not used in our test loop.
> >
> > We are running a small test C loop (with approx. 60 assembly
> > language instructions) at the end of u-boot as in the Hello World
> > example. The loop runs fine but upon closer analisis I found that
> > each loop takes 6uS. This averages out to 100nS/instruction =
> > 10MIPS = sad performance. I would have expected at least 100MIPS or
> > more.
> >
> > I've checked the HID0 SPR register to verify that the instruction
> > cache is enabled.
> >
> > I've also stepped thru the code to verify that the code stays
> > within the loop (no async branches or irqs). Looking at the adr and
> > data lines with an analyzer the loop appears to do the correct
> > amount of I/O to SDRAM but the amount of time of between SDRAM
> > accesses seem longer than I would expect if caching, pipelining,
> > snooping, etc are enabled.
> >
> > Any ideas on what could be slowing the CPU down are greatly
> > appreciated.
> >
>
> Is the code doing any d-side access? is the d-cache enabled? How are
> the BATs setup for memory locations you are accessing.
>
> - k
>
>
>
>
>
> TV dinner still cooling?
> Check out "Tonight's Picks" on Yahoo! TV.

Return-Path: <KHollan@daktronics.com>
Received: from ns2.daktronics.com (smtp.daktronics.com [63.85.214.24])
	by ozlabs.org (Postfix) with SMTP id 14D22DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 10:01:00 +1100 (EST)
Subject: Re: System Clock runaway on Xilinx platform
From: Kevin Holland <khollan@daktronics.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40802061229w3c6ae051kec18d1d25ad1da4@mail.gmail.com>
References: <15312437.post@talk.nabble.com>
	<fa686aa40802061229w3c6ae051kec18d1d25ad1da4@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 16:39:36 -0600
Message-Id: <1202337576.20550.6.camel@kevin-laptop>
Mime-Version: 1.0
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

I load with the zImage.elf, so my xparameters are set like this:

#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ

I took readings every 5 min over a 15 min period and it seems to be
increasing by approximately 50 sec every 5 mins.

Thanks

Kevin

On Wed, 2008-02-06 at 13:29 -0700, Grant Likely wrote:
> On 2/6/08, khollan <khollan@daktronics.com> wrote:
> >
> > Hi all,
> >
> > Thanks for the help so far!
> > I'm now running linux 2.6.21 on my custom virtex 4 board modeled after the
> > ml410.  The cpu clock is 300MHz and the PLB bus is 175MHz.
> >
> > My question is which clock is the linux system clock that keeps track of the
> > date derived from?  I set my date with rdate -s time.mit.edu at boot and
> > then compare with the date command and rdate -p time.mit.edu and they are
> > off by 20 or so seconds even just after a few minutes, this trend continues
> > and it will be off by a day after a few hours.  I think I just don't have
> > something defined correctly but I can't figure out which.
> 
> The clock is maintained off of the PowerPC time base register (TBL,
> TBU).  On Virtex ppc platforms, the time base frequency is supposed to
> be the same as the CPU clock.  Can you figure out *exactly* how
> quickly the clock is drifting?
> 
> How are you booting your Virtex platform?  u-boot or a zImage.elf?  If
> it's a zImage, the CPU clock frequency is set in
> arch/ppc/boot/simple/embed_config.c (search for CONFIG_XILINX and look
> for the line that sets bd->bi_intfreq).  Make XPAR_CORE_CLOCK_FREQ_HZ
> in xparameters matches you CPU clock speed.
> 
> Side note: you may notice that bd->bi_tbfreq is also used but not set;
> that's because bd->bi_intfreq and bd->tbfreq point to the same memory
> location.  (It's kind of messed up that way, don't worry too much
> about it)
> 
> If you're using u-boot, then u-boot will set the cpu frequency in the
> board info structure.
> 
> Cheers,
> g.
> 

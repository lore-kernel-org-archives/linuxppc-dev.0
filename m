Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 81EEDDDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 07:29:29 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3141307hsb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Feb 2008 12:29:28 -0800 (PST)
Message-ID: <fa686aa40802061229w3c6ae051kec18d1d25ad1da4@mail.gmail.com>
Date: Wed, 6 Feb 2008 13:29:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: khollan <khollan@daktronics.com>
Subject: Re: System Clock runaway on Xilinx platform
In-Reply-To: <15312437.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <15312437.post@talk.nabble.com>
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

On 2/6/08, khollan <khollan@daktronics.com> wrote:
>
> Hi all,
>
> Thanks for the help so far!
> I'm now running linux 2.6.21 on my custom virtex 4 board modeled after the
> ml410.  The cpu clock is 300MHz and the PLB bus is 175MHz.
>
> My question is which clock is the linux system clock that keeps track of the
> date derived from?  I set my date with rdate -s time.mit.edu at boot and
> then compare with the date command and rdate -p time.mit.edu and they are
> off by 20 or so seconds even just after a few minutes, this trend continues
> and it will be off by a day after a few hours.  I think I just don't have
> something defined correctly but I can't figure out which.

The clock is maintained off of the PowerPC time base register (TBL,
TBU).  On Virtex ppc platforms, the time base frequency is supposed to
be the same as the CPU clock.  Can you figure out *exactly* how
quickly the clock is drifting?

How are you booting your Virtex platform?  u-boot or a zImage.elf?  If
it's a zImage, the CPU clock frequency is set in
arch/ppc/boot/simple/embed_config.c (search for CONFIG_XILINX and look
for the line that sets bd->bi_intfreq).  Make XPAR_CORE_CLOCK_FREQ_HZ
in xparameters matches you CPU clock speed.

Side note: you may notice that bd->bi_tbfreq is also used but not set;
that's because bd->bi_intfreq and bd->tbfreq point to the same memory
location.  (It's kind of messed up that way, don't worry too much
about it)

If you're using u-boot, then u-boot will set the cpu frequency in the
board info structure.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

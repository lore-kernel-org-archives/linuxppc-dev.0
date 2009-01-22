Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FCF3DDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 04:05:48 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0MH5S67009120
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 10:05:39 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0MH5RLb017998
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 11:05:27 -0600 (CST)
Date: Thu, 22 Jan 2009 11:05:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: Device Tree setup for 8272-based board
Message-ID: <20090122170526.GB18012@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
	<547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
	<20090120164124.GC8978@ld0162-tx32.am.freescale.net>
	<547eba1b0901202337g624f79b2uaa7f7f2f61990ad1@mail.gmail.com>
	<20090121175225.GB31266@ld0162-tx32.am.freescale.net>
	<547eba1b0901212347v47c9ee4at40e2188c50351952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0901212347v47c9ee4at40e2188c50351952@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2009 at 06:47:01PM +1100, Daniel Ng wrote:
> Thanks Scott. What is the meaning of the Ethernet reg field?:
> 
> reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
> 
> Is it-
> 
> 0x11300-> GFMR1 ie. the GFMR for FCC1?
> 0x20-> GFMR1 Fields are a total of 32 bits?
> 0x8400-> initial value of bits 0-15 of GFMR1?
> 0x100-> initial value of bits 16-31 of GFMR1?
> 0x11390-> GFEMR1?
> 0x1-> length of GFEMR1 is 1 bit in size?? (this doesn't make sense
> because it's a 3-bit field)
> Where would we specify the initial value of GFEMR1?

No, it's 3 pairs of offset/length (reg is *always* a list of
address/size pairs, with the number of cells per address or size
component depending on #address-cells/#size-cells in the parent node). 
Length is in bytes, not bits.

The first is the FCC register block, the second is the parameter RAM, and
the third is GFEMR.

There are no "initial values" in the device tree -- it describes what the
hardware is, not how to program it.  fsl,cpm-command may seem like the
latter, but it describes how a specific device is identified to the CPM
core.

-Scott

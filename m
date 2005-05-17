Return-Path: <Heinz.Wrobel@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id ADEDB679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 16:41:16 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j4H6k1LS029267 for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 23:46:02 -0700 (MST)
Received: from zwg18exm01.ea.freescale.net (zwg18exm01.ea.freescale.net
	[10.170.73.30])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j4H6i2jg025924
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 01:44:03 -0500 (CDT)
Message-ID: <DF02D66C37C26B4C8018BF84F0E37FEC087B51F3@zwg18exm01.ea.freescale.net>
From: Wrobel Heinz-r39252 <Heinz.Wrobel@freescale.com>
To: "Martin, Tim" <tim.martin@viasat.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 17 May 2005 08:41:12 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: MPC860 CP / CPM Misbehaving
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 

> descriptors (BDs) from the CPM with the OV bit set (bit 14 of the RxBD
> status/control field, "Overrun. Set when a receiver overrun 
> occurs during
> reception").

Check the following:

- SDRAM setup. If ORx(BIH)=1 makes the problem go away, your burst setup or the /TA pullup is broken. NB: Neither the SCC nor the SMC do bursts.
- Check pullups as per UM recommendation. I tend to recommend 1k.
- Did you by accident happen to enable any IDMA lines?
- Did you happen to misconfigure RCCR(DRxM)?
- Did you happen to misconfigure the SDCR?

One other thing. If you have an old BDM debugger *and* if the problem occurs *only* with the BDM debugger hooked up, you may want to check for an update or replacement. Old debuggers sometimes used a method to do BDM which could stall the DMAs in the machine and cause this kind of overrun/underrun effect.

Heinz

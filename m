Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 1FB3068847
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 05:19:56 +1100 (EST)
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
References: <1132583152.11785.41.camel@mephisto.spb.rtsoft.ru>
	<20051121174745.GA2654@xyzzy.farnsworth.org>
	<1132763364.31328.21.camel@mephisto.spb.rtsoft.ru>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 10:09:42 -0800
In-Reply-To: <1132763364.31328.21.camel@mephisto.spb.rtsoft.ru> (Ruslan V.
	Sushko's message of "Wed, 23 Nov 2005 19:29:24 +0300")
Message-ID: <52veyaqa6x.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/3] ppc32: Fix  a few issues in Yucca PCIe functionality
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This looks OK, although I would prefer to see this split into a few
patches, for example, first kill off dead code, then add more error
checking, and so on.

Also, one question/comment:

 > @@ -335,44 +337,47 @@ int ppc440spe_init_pcie_rootport(int por
 >  	/*
 >  	 * Check for VC0 active and assert RDY.
 >  	 */
 > +
 > +	attempts = 10;
 >  	switch (port) {
 >  	case 0:
 > -		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
 > -			printk(KERN_WARNING "PCIE0: VC0 not active\n");
 > +		while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
 > +			if (!(attempts--)) {
 > +				printk(KERN_WARNING "PCIE0: VC0 not active\n");
 > +				return -1;
 > +			}
 > +			mdelay(1000);
 > +		}
 >  		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);

what lead you to add 10 tries here?  Did this fix an issue you saw
with a device?

 - R.

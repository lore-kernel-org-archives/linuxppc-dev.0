Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED22BDDFD4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:21:20 +1000 (EST)
Date: Wed, 7 May 2008 13:22:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Boris Shteinbock <bshtein@yahoo.com>
Subject: Re: powerpc port for sbc8260-based board problem
Message-ID: <20080507182209.GA2710@loki.buserror.net>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <733382.15174.qm@web50603.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 07, 2008 at 01:31:52AM -0700, Boris Shteinbock wrote:
>      /* Monitor port/SMC1 */
>      smc1: serial@11a80 {
>        device_type = "serial";
>        compatible = "fsl,mpc8260-smc-uart",
>                     "fsl,cpm2-smc-uart";
>        reg = <0x11a80 0x20 0x1100 0x40>;

The second reg resource depends on where your firmware set up the SMC pram
regs.  With U-boot, it's usually zero.

Note that as of 2.6.26-rc1, this is set up dynamically instead, and the
second resource should be 0x87fc 2.

> Can someone, also, explain, how "fsl, cpm-command" field works,

It's the device-specific portion of the value that gets written to the CPM
command register (page, sub-block, and mcc channel).

> booting-without-of document doesn't provide much information. I feel, that
> just copying this value from ep8248.dts isn't right somehow.

It should be the same.

-Scott

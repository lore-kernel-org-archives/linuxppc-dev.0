Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EE6FDDE1EB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:25:38 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0P8PbvS000087
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 01:25:37 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0P8PYcB027021
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 02:25:36 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 25 Jan 2007 16:25:32 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
In-Reply-To: <2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> No, I think the round handler should try to do the rounding=20
> by hand.  =20
> Since you have the non rounded information provided by HW,=20
> its much simpler to just do the rounding step.

Hi Kumar,

I have some new thoughts about rounding handler.=20
Suppose we set SPEFSCR[FRMC]=3D0b10 (rounding towards +Inf) and
a normal "efsmul" may generate rounding interrupt. At this time,
according
to manual, unrounded (truncated) result is placed in the target
register. Please
note the target register contains a hexadecimal representation of a
floating point number. Since it represents a floating point number
exactly
so we can not round it anymore.

Maybe we still need to emulate the whole "efsmul" instruction by
software.

What do you think? Any idea is appreciated!

B.R.
Ebony

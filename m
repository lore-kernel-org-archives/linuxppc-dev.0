Return-Path: <schwab@suse.de>
Received: from lisa.goe.net (lisa.JS.Jura.Uni-Goettingen.de [134.76.166.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 528A367A9B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 12:17:36 +1100 (EST)
Received: from mutter.goe.net (mail@mutter-lisa0.a11.private [192.168.31.26])
	by lisa.goe.net (8.13.1/8.13.1) with ESMTP id j0Q15iKd004855
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 02:05:44 +0100
Received: from igel.a11.private ([192.168.31.91] helo=igel.home)
	by mutter.goe.net with esmtp (Exim 4.42) id 1Ctbct-0006Rw-VB
	for linuxppc-dev@ozlabs.org; Wed, 26 Jan 2005 02:05:44 +0100
To: linuxppc-dev@ozlabs.org
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 26 Jan 2005 02:05:43 +0100
Message-ID: <m3llahc848.fsf@igel.m5r.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Fix spurious error return in FBIO_RADEON_SET_MIRROR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FBIO_RADEON_SET_MIRROR always returns with -EINVAL even if successful due
to an inappropriate fall-through.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6.10/drivers/video/aty/radeon_base.c.~1~	2004-12-29 20:17:12.00=
0000000 +0100
+++ linux-2.6.10/drivers/video/aty/radeon_base.c	2005-01-26 01:48:17.000000=
000 +0100
@@ -911,7 +911,7 @@ static int radeonfb_ioctl (struct inode=20
=20
 			OUTREG(CRTC_EXT_CNTL, tmp);
=20
-			break;
+			return 0;
 		case FBIO_RADEON_GET_MIRROR:
 			if (!rinfo->is_mobility)
 				return -EINVAL;

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

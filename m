Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AECB7DE027
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 02:00:21 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: powerbook VT garbled between rc7 and rc8
References: <1229078554.3600.8.camel@johannes.berg>
	<je7i65r42j.fsf@sykes.suse.de>
	<1229092999.3600.10.camel@johannes.berg>
Date: Fri, 12 Dec 2008 16:00:14 +0100
In-Reply-To: <1229092999.3600.10.camel@johannes.berg> (Johannes Berg's message
	of "Fri, 12 Dec 2008 15:43:19 +0100")
Message-ID: <jeprjxphfl.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2008-12-12 at 13:05 +0100, Andreas Schwab wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>> > After upgrading to -rc8 yesterday my powerbook started up today with the
>> > screen totally garbled, only occasionally was a word readable.
>> 
>> Try 6c34bc2976b30dc8b56392c020e25bae1f363cab (Revert "radeonfb:
>> accelerate imageblit and other improvements").
>
> That's post -rc8, ok, but -rc7 worked fine here, and the stuff it
> reverts is all pre -rc7, no? Strange. I'll try later.

This appears to be a side effect of setting up info->pixmap in
radeon_set_fbinfo even if accel_cexp is 0.  Alternatively to the cited
patch you can also use something like this:

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index d5b27f9..532e2c5 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -1895,6 +1895,9 @@ static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
 	/* Allocate colormap */
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
+	if (!accel_cexp)
+		goto bail;
+
 	/* Setup pixmap used for acceleration */
 #define PIXMAP_SIZE	(2048 * 4)
 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

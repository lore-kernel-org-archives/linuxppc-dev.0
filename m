Return-Path: <johnstul@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A1CC67A6E
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Feb 2005 07:24:46 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.esmtp.ibm.com [9.14.4.130])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j14K08gB018252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 15:00:09 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j14K00CZ510358
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 15:00:00 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j14K00BC294782
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 13:00:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j14Jxxhm032356
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 12:59:59 -0700
Received: from cog.beaverton.ibm.com (cog.beaverton.ibm.com [9.47.21.16])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j14JxxPh032301
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 12:59:59 -0700
From: john stultz <johnstul@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 04 Feb 2005 11:59:58 -0800
Message-Id: <1107547198.2040.264.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Subject: mac mini alsa hack
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey all,
	This clearly isn't the right fix, but it allows my mac mini to play
audio. It works, but is still somewhat broken, as any time I start
playing audio X hangs for a second or so. Also using alsamixer is very
slow. 

Its likely this patch also breaks whatever else uses "AOAKeylargo".

Anyway, just wanted to start the discussion on what the proper fix would
be.

thanks
-john

===== sound/ppc/pmac.c 1.36 vs edited =====
--- 1.36/sound/ppc/pmac.c	2004-12-20 18:52:47 -08:00
+++ edited/sound/ppc/pmac.c	2005-02-04 01:44:05 -08:00
@@ -964,7 +964,7 @@
 	if (device_is_compatible(sound, "AOAKeylargo")) {
 		/* Seems to support the stock AWACS frequencies, but has
 		   a snapper mixer */
-		chip->model = PMAC_SNAPPER;
+		chip->model = PMAC_SCREAMER;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}

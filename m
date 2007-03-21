Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83076DE191
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:18 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF3Fq9008528
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:15 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF3F1v008527
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:15 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:15 -0600 (CST)
Message-Id: <200703211503.l2LF3F1v008527@sullivan.realtime.net>
Subject: Re: Patch: [PATCH 04/17] bootwrapper: Make compression of the kernel
	image optional.
In-Reply-To: <20070316172759.GD29784@ld0162-tx32.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You missed two .gz in the code, which would result in ineffective caching.
Found by inspection.

-if [ -z "$cacheit" -o ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
+if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then

You also need to add these generated files to clean-files in the Makefile.

milton

Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 182EDDDF78
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:03:49 +1000 (EST)
Date: Fri, 21 Sep 2007 18:03:34 -0500 (CDT)
Subject: [PATCH 2/15] boot: record header bytes in gunzip_start
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-02.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Record the number of header bytes skipped in the total bytes read field.

This is needed for the initramfs parsing code to find the end of the zip file.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Identical to 12169

Index: kernel/arch/powerpc/boot/gunzip_util.c
===================================================================
--- kernel.orig/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:33:34.000000000 -0500
+++ kernel/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:40:59.000000000 -0500
@@ -78,6 +78,7 @@ void gunzip_start(struct gunzip_state *s
 			fatal("inflateInit2 returned %d\n\r", r);
 	}
 
+	state->s.total_in = hdrlen;
 	state->s.next_in = src + hdrlen;
 	state->s.avail_in = srclen - hdrlen;
 }

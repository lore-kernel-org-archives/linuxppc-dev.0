Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 368F867BED
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 00:56:38 +1000 (EST)
Subject: [PATCH] make checkstack work with ARCH=powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 16:57:05 +0200
Message-Id: <1156258625.3825.5.camel@ux156>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds 'powerpc' architecture support to checkstack.pl.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/scripts/checkstack.pl	2006-08-22 15:47:37.000000000 +0200
+++ wireless-dev/scripts/checkstack.pl	2006-08-22 15:47:40.000000000 +0200
@@ -62,6 +62,8 @@ my (@stack, $re, $x, $xs);
 	} elsif ($arch eq 'ppc64') {
 		#XXX
 		$re = qr/.*stdu.*r1,-($x{1,8})\(r1\)/o;
+	} elsif ($arch eq 'powerpc') {
+		$re = qr/.*st[dw]u.*r1,-($x{1,8})\(r1\)/o;
 	} elsif ($arch =~ /^s390x?$/) {
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
 		$re = qr/.*ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})/o;

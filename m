Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53893DE097
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:08:01 +1000 (EST)
Message-ID: <46730D6C.9050606@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 26/33] Powerpc: Add u64 printf to bootwrapper
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for the 'll' (long long) printf qualifier in the powerpc zImage
bootwrapper.  This is useful for bootwrapper debugging on 64 bit platforms.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/stdio.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -190,7 +190,11 @@ int vsprintf(char *buf, const char *fmt,
 
 		/* get the conversion qualifier */
 		qualifier = -1;
-		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
+		if (*fmt == 'l' && *(fmt + 1) == 'l') {
+			qualifier = 'q';
+			fmt += 2;
+		} else if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L'
+			|| *fmt == 'Z') {
 			qualifier = *fmt;
 			++fmt;
 		}
@@ -281,6 +285,10 @@ int vsprintf(char *buf, const char *fmt,
 			num = va_arg(args, unsigned long);
 			if (flags & SIGN)
 				num = (signed long) num;
+		} else if (qualifier == 'q') {
+			num = va_arg(args, unsigned long long);
+			if (flags & SIGN)
+				num = (signed long long) num;
 		} else if (qualifier == 'Z') {
 			num = va_arg(args, size_t);
 		} else if (qualifier == 'h') {

-- 

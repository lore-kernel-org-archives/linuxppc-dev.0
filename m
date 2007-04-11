Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:32:36 -0500 (CDT)
Subject: [PATCH 1/8] boot: more verbose gunzip error message
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-01.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the error message in gunzip_exactly to be more verbose.

Besides the identifier being unrelated to the current function name,
the user had no indication if the corruption was near the beginning
or the end.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/gunzip_util.c
===================================================================
--- kernel.orig/arch/powerpc/boot/gunzip_util.c	2007-04-10 21:29:49.000000000 -0500
+++ kernel/arch/powerpc/boot/gunzip_util.c	2007-04-10 21:30:15.000000000 -0500
@@ -142,7 +142,8 @@ void gunzip_exactly(struct gunzip_state 
 
 	len  = gunzip_partial(state, dst, dstlen);
 	if (len < dstlen)
-		fatal("gunzip_block: ran out of data\n\r");
+		fatal("\n\rgunzip_exactly: ran out of data!"
+				" Wanted %d, got %d.\n\r", dstlen, len);
 }
 
 /**

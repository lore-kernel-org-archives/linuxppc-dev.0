Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:08:05 -0500 (CDT)
Subject: [PATCH 2/15] boot: record header bytes in gunzip_start
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-02.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
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


Record the number of header bytes skipped in the total bytes read field.

This is needed for the initramfs parsing code to find the end of the zip file.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 

Index: work.git/arch/powerpc/boot/gunzip_util.c
===================================================================
--- work.git.orig/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:44:41.000000000 -0500
+++ work.git/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:47:35.000000000 -0500
@@ -78,6 +78,7 @@ void gunzip_start(struct gunzip_state *s
 			fatal("inflateInit2 returned %d\n\r", r);
 	}
 
+	state->s.total_in = hdrlen;
 	state->s.next_in = src + hdrlen;
 	state->s.avail_in = srclen - hdrlen;
 }

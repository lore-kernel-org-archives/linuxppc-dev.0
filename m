Return-Path: <miltonm@sullivan.realtime.net>
Date: Thu, 29 Mar 2007 07:31:41 -0600 (CST)
Subject: Re: [PATCH 4/4] bootwrapper: decompress less, check more
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-3-04-a.miltonm@bga.com>
In-Reply-To: <boot-3-04.miltonm@bga.com>
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

Our kernels put everything in the first load segment, and we read that.
Instead of decompresing to the end of the gzip stream or supplied image
and hoping we get it all, decompress the expected size and complain if
it is not available.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Changed the gunzipping message back to the original to stay within 80
characters per printed line.

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-03-29 06:12:16.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-03-29 08:24:14.000000000 -0500
@@ -145,7 +145,10 @@ static struct addr_range prep_kernel(voi
 	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
 	/* discard up to the actual load data */
 	gunzip_discard(&gzstate, ei.elfoffset - sizeof(elfheader));
-	len = gunzip_finish(&gzstate, addr, ei.memsize);
+	len = gunzip_finish(&gzstate, addr, ei.loadsize);
+	if (len != ei.loadsize)
+		fatal("ran out of data!  only got 0x%x of 0x%lx bytes.\n\r",
+				len, ei.loadsize);
 	printf("done 0x%x bytes\n\r", len);
 
 	flush_cache(addr, ei.loadsize);

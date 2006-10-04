Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Oct 2006 13:41:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: powerpc: Fix clean target for empty.c
Message-ID: <20061004034111.GC20636@localhost.localdomain>
References: <20061004033753.GB20636@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061004033753.GB20636@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, another tiny fix.  Applies after by fix for the dtc make rules.

The files listed in the clean-files variable should not include the
$(obj) prefix.  This patch corrects this for
arch/powerpc/boot/empty.c, which was not previously removed on "make
clean" for this reason.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2006-10-04 13:31:54.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2006-10-04 13:38:31.000000000 +1000
@@ -74,7 +74,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		$(obj)/empty.c *.dtb
+		empty.c *.dtb
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

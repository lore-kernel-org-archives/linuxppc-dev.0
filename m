Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Oct 2006 13:37:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Fix make rules for dtc
Message-ID: <20061004033753.GB20636@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, please apply to the powerpc prep2 branch.  Not sure if it also
need to go in the powerpc master branch.

There are a couple of errors in the make rules for invoking dtc in
arch/powerpc/boot.  First, dtc does not generate gcc -MD style .d
files, so should be invoked via the 'if_changed' macro, rather than
'if_changed_dep'.  Secondly, the clean-files target was missing an
entry to clean the generated .dtb files.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2006-10-04 13:31:46.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2006-10-04 13:31:54.000000000 +1000
@@ -74,7 +74,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		$(obj)/empty.c
+		$(obj)/empty.c *.dtb
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
@@ -93,7 +93,7 @@ $(patsubst %.c,%.o, $(filter %.c, $(src-
 $(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S
 	$(call if_changed_dep,bootas)
 $(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
-	$(call if_changed_dep,dtc)
+	$(call if_changed,dtc)
 
 $(obj)/wrapper.a: $(obj-wlib)
 	$(call cmd,bootar)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id DAB7DDE64C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 04:19:11 +1000 (EST)
Date: Thu, 17 Jul 2008 21:18:54 +0300
From: Adrian Bunk <bunk@kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
Subject: [2.6 patch] powerpc/boot/Makefile: change spaces to tabs
Message-ID: <20080717181854.GB18326@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For C code spaces versus tabs is just a religious issue,
but for Makefiles it actually matters.

This patch fixes he following errors:
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:166: *** missing separator.  Stop.
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/Makefile:171: *** missing separator.  Stop.

Since this was inside an ifdef DTC_GENPARSER it was not a problem unless 
someone wanted to regenerate the shipped generated files.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/powerpc/boot/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -163,12 +163,12 @@ quiet_cmd_flex = FLEX    $@
       cmd_flex = $(FLEX) -o$@ $<; cp $@ $@_shipped
 
 $(obj)/dtc-src/dtc-parser.tab.c: $(src)/dtc-src/dtc-parser.y FORCE
-     $(call if_changed,bison)
+	$(call if_changed,bison)
 
 $(obj)/dtc-src/dtc-parser.tab.h: $(obj)/dtc-src/dtc-parser.tab.c
 
 $(obj)/dtc-src/dtc-lexer.lex.c: $(src)/dtc-src/dtc-lexer.l FORCE
-     $(call if_changed,flex)
+	$(call if_changed,flex)
 endif
 
 #############

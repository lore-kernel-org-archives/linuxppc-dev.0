Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 14:50:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove reference to dead Makefile variables
Message-ID: <20080520045050.GM22279@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previous cleanups have removed the LIBFDT_CLEANFILES and
DTC_CLEANFILES variables from the Makefiles.  However, they're still
referenced by the Makefile.  This patch gets rid of these last
vestiges.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2008-05-20 14:47:38.000000000 +1000
+++ dtc/Makefile	2008-05-20 14:48:06.000000000 +1000
@@ -150,7 +150,6 @@ $(LIBFDT_lib): $(addprefix $(LIBFDT_objd
 libfdt_clean:
 	@$(VECHO) CLEAN "(libfdt)"
 	rm -f $(addprefix $(LIBFDT_objdir)/,$(STD_CLEANFILES))
-	rm -f $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_CLEANFILES))
 
 ifneq ($(DEPTARGETS),)
 -include $(LIBFDT_OBJS:%.o=$(LIBFDT_objdir)/%.d)
@@ -170,7 +169,7 @@ STD_CLEANFILES = *~ *.o *.d *.a *.i *.s 
 
 clean: libfdt_clean tests_clean
 	@$(VECHO) CLEAN
-	rm -f $(STD_CLEANFILES) $(DTC_CLEANFILES)
+	rm -f $(STD_CLEANFILES)
 	rm -f $(VERSION_FILE)
 	rm -f $(BIN)
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 16:04:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make make print a message when linking testcases
Message-ID: <20070831060427.GB29721@localhost.localdomain>
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

Currently, dtc relies on make's implicit rule to build the testcases.
This means that when not making verbosely (V=0, the default) there is
no message at all while relinking the testsuites.  This can be very
confusing when updating libfdt.a (upon which the testcases depend) and
make appears to do nothing.

This patch corrects the situation, borrowing the rule used to link dtc
itself to link all the testcases as well.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-08-31 15:58:40.000000000 +1000
+++ dtc/Makefile	2007-08-31 15:58:59.000000000 +1000
@@ -101,8 +101,6 @@
 	$(LEX) $<
 
 dtc: $(DTC_OBJS)
-	@$(VECHO) LD $@
-	$(LINK.c) -o $@ $^
 
 ftdump:	ftdump.o
 
@@ -168,6 +166,10 @@
 #
 # Generic compile rules
 #
+%: %.o
+	@$(VECHO) LD $@
+	$(LINK.c) -o $@ $^
+
 %.o: %.c
 	@$(VECHO) CC $@
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

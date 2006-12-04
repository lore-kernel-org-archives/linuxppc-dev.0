Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 05D9967BB4
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 16:00:08 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: [LIBFDT] *corrected* Add cscope target to Makefile
Date: Sun,  3 Dec 2006 21:59:59 -0700
Message-Id: <11652083992145-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops!  Ignore the last patch that added cscope support; it would delete
the cscope.out file every time you did a make clean (kind of useless).
This version only removes the cscope.out when 'make distclean' is run

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d464a82..2bbdb54 100644
--- a/Makefile
+++ b/Makefile
@@ -55,6 +55,9 @@ stress:	all
 stressv: all
 	cd tests; ./run_tests.sh -t stress -v
 
+cscope:
+	cscope -b -k *.[ch] tests/*.[ch]
+
 %.o: %.c
 	@$(VECHO) CC $@
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
@@ -76,6 +79,10 @@ clean:
 	rm -f *~ *.o *.so *.a *.d *.i *.s core a.out $(VERSION)
 	$(MAKE) -C tests clean
 
+distclean: clean
+	@$(VECHO) DISTCLEAN
+	rm -f cscope.out
+
 %.d: %.c
 	@$(CC) $(CPPFLAGS) -MM -MT "$*.o $@" $< > $@
 
-- 
1.4.3.rc2.g0503

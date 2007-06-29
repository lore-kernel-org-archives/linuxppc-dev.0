Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E56BBDDE4A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:53:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TErb8l030922
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 10:53:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TErYlj215436
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 08:53:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TErOJa012623
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 08:53:24 -0600
Subject: [PATCH v2] dtc: Add install makefile target
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jdl@freescale.com
Content-Type: text/plain
Date: Fri, 29 Jun 2007 09:53:23 -0500
Message-Id: <1183128803.30145.29.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a minimal install target

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

--- dtc.orig/Makefile
+++ dtc/Makefile
@@ -4,6 +4,10 @@ LDFLAGS = -Llibfdt
 
 BISON = bison
 
+INSTALL = /usr/bin/install
+DESTDIR =
+BINDIR = /usr/bin
+
 #
 # Overall rules
 #
@@ -113,3 +117,8 @@ endif
 #
 TESTS_PREFIX=tests/
 include tests/Makefile.tests
+
+install: dtc ftdump
+	$(INSTALL) -d $(DESTDIR)/$(BINDIR)
+	$(INSTALL) -m 755 dtc $(DESTDIR)/$(BINDIR)
+	$(INSTALL) -m 755 ftdump $(DESTDIR)/$(BINDIR)

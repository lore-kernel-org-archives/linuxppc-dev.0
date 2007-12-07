Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D537FDDDF4
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 05:30:09 +1100 (EST)
Date: Fri, 7 Dec 2007 12:28:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: [DTC][PATCH] Fix cross-compile building
Message-ID: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, stuarth@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stuart Hughes <stuarth@freescale.com>

This patch allows you to build the DTC source without making the
tests directory.  This is necessary when cross compiling as the
dumptest (and other) files cannot be run/used on the host system.
To use this use: 'make TESTS='

Signed-off-by: Stuart Hughes <stuarth@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index bcb143f..9d926b5 100644
--- a/Makefile
+++ b/Makefile
@@ -46,7 +46,9 @@ else
 DEPTARGETS = $(filter-out $(NODEPTARGETS),$(MAKECMDGOALS))
 endif

-all: dtc ftdump libfdt tests
+TESTS = tests
+
+all: dtc ftdump libfdt $(TESTS)

 install: all
 	@$(VECHO) INSTALL
-- 
1.5.3.4

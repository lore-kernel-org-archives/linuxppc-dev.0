Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0EC1B7B71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 03:41:47 +1000 (EST)
Date: Thu, 17 Sep 2009 13:41:45 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] fix ppc64 build failure on fedora
Message-ID: <20090917174144.GA11961@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Kyle McMartin <kyle@infradead.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kyle McMartin <kyle@redhat.com>

For some reason or another (newer gcc?) on Fedora 12 koji builders we're
seeing _restgpr0_$n symbols instead of _restgpr_$n as handled in the
prom_init_check.sh file:
Checking prom_init.o symbol '_restgpr0_14'
Error: External symbol '_restgpr0_14' referenced from prom_init.c
Checking prom_init.o symbol '_restgpr0_17'

Add cases to handle this to the filter portion of the script.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 1ac136b..9f82f49 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -52,12 +52,18 @@ do
 	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
 		OK=1
 	fi
+	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
+		OK=1
+	fi
 	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
 		OK=1
 	fi
 	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
 		OK=1
 	fi
+	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
+		OK=1
+	fi
 	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
 		OK=1
 	fi

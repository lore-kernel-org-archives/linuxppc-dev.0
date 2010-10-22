Return-Path: <kerstin.jonsson@ericsson.com>
Received: from mailgw10.se.ericsson.net (mailgw10.se.ericsson.net
	[193.180.251.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B666AB70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 21:33:29 +1100 (EST)
From: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 1/1] powerpc: Fix initramfs size in PPC32 build
Date: Fri, 22 Oct 2010 12:17:55 +0200
Message-ID: <1287742675-7614-1-git-send-email-kerstin.jonsson@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Kerstin Jonsson <kerstin.jonsson@ericsson.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit ffe8018c3424892c9590048fc36caa6c3e0c8a76 of the -mm tree
fixes the initramfs size calculation for e.g. s390 but breaks it
for 32bit architectures which do not define CONFIG_32BIT.

This patch fix the problem for PPC32 which will elsewise end up
with a __initramfs_size of 0.

Signed-off-by: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 50cc5d9..d536fe4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -4,6 +4,10 @@ config PPC32
 	bool
 	default y if !PPC64
 
+config 32BIT
+	bool
+	default y if PPC32
+
 config 64BIT
 	bool
 	default y if PPC64
-- 
1.7.1

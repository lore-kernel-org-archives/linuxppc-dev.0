Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id ABB402C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 23:05:42 +1100 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Vitaly Bordug <vitb@kernel.crashing.org>,
 Marcelo Tosatti <marcelo@kvack.org>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 Bob Pearson <rpearson@systemfabricworks.com>
Subject: [PATCH] lib/crc32: slice by 4 is more efficient than the default
 slice by 8 on Powerpc 8xx.
Message-Id: <20131118070423.E47181A4D3D@localhost.localdomain>
Date: Mon, 18 Nov 2013 08:04:23 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC_8xx, CRC32_SLICEBY4 is more efficient (almost twice) than CRC32_SLICEBY8,
as shown below:

With CRC32_SLICEBY8:
[    1.109204] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    1.114401] crc32: self tests passed, processed 225944 bytes in 15118910 nsec
[    1.130655] crc32c: CRC_LE_BITS = 64
[    1.134235] crc32c: self tests passed, processed 225944 bytes in 4479879 nsec

With CRC32_SLICEBY4:
[    1.097129] crc32: CRC_LE_BITS = 32, CRC_BE BITS = 32
[    1.101878] crc32: self tests passed, processed 225944 bytes in 8616242 nsec
[    1.116298] crc32c: CRC_LE_BITS = 32
[    1.119607] crc32c: self tests passed, processed 225944 bytes in 3289576 nsec

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Index: a/lib/Kconfig
===================================================================
--- a/lib/Kconfig	(révision 5325)
+++ b/lib/Kconfig	(copie de travail)
@@ -102,6 +102,7 @@
 choice
 	prompt "CRC32 implementation"
 	depends on CRC32
+	default CRC32_SLICEBY4 if PPC_8xx
 	default CRC32_SLICEBY8
 	help
 	  This option allows a kernel builder to override the default choice

Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40flD56kf0zF1S1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 00:21:25 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] powerpc: wii_defconfig: Disable Ethernet driver
 support code
Date: Mon,  7 May 2018 16:20:16 +0200
Message-Id: <20180507142019.32669-2-j.neuschaefer@gmx.net>
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
a different menu. Disable CONFIG_ETHERNET to save some space in support
code for Ethernet drivers.

Note that this patch doesn't disable any Ethernet drivers, because they
are not enabled by default.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
v2:
- Drop the bloat-o-meter output from the commit message
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 0b0f78823a1b..3167b9d7f3e5 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -49,6 +49,7 @@ CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
 CONFIG_B43=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
-- 
2.17.0

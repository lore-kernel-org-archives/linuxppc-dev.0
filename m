Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B5C5BDE631
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:53:35 +1000 (EST)
Date: Tue, 29 Apr 2008 19:53:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] 86xx: mpc8610_hpcd: use ULI526X driver for
	on-board ethernet
Message-ID: <20080429155333.GC28166@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As of current mainline tree, TULIP driver is unusable on MPC8610HPCD
boards. There is a patch[1] floating around (and also included in the
BSP), which tries to heal the situation, though the ethernet is still
unusable. Practically it takes ages to mount NFS filesystem:

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 180k init
nfs: server 10.0.0.2 not responding, still trying
nfs: server 10.0.0.2 OK
nfs: server 10.0.0.2 not responding, still trying
nfs: server 10.0.0.2 not responding, still trying
nfs: server 10.0.0.2 not responding, still trying
nfs: server 10.0.0.2 not responding, still trying
nfs: server 10.0.0.2 OK
nfs: server 10.0.0.2 not responding, still trying

So, instead of trying to add uli526x functionality into TULIP driver
(which is already bloated enough), I fixed existing ULI526X driver
and now it works perfectly well here.

[1] http://www.bitshrine.org/gpp/0024-MPC8610-ETH-Lyra-native-ethernet.txt

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is for powerpc tree.

 arch/powerpc/configs/mpc8610_hpcd_defconfig |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 9270afe..f9e53bd 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -567,14 +567,11 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 CONFIG_NET_TULIP=y
 # CONFIG_DE2104X is not set
-CONFIG_TULIP=y
-# CONFIG_TULIP_MWI is not set
-CONFIG_TULIP_MMIO=y
-# CONFIG_TULIP_NAPI is not set
+# CONFIG_TULIP is not set
 # CONFIG_DE4X5 is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_DM9102 is not set
-# CONFIG_ULI526X is not set
+CONFIG_ULI526X=y
 # CONFIG_HP100 is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
-- 
1.5.5.1

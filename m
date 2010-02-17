Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B631CB7D5B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 01:56:57 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: netdev@vger.kernel.org
Subject: [net-next-2.6 PATCH v2 0/3] Support for MPC512x FEC
Date: Wed, 17 Feb 2010 15:55:27 +0100
Message-Id: <1266418530-2727-1-git-send-email-agust@denx.de>
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches attempt to provide support for the Freescale MPC512x
FEC in the fs_enet driver. The first cleanup patch replaces printk
by dev_xxx. The second and third attemt to support MPC5121 FEC
in the FEC driver.

Changes since previous version:

 - don't attempt to provide runtime selection of
   MPC5121 FEC support in the driver since it doesn't
   make sence. Select MPC5121 FEC support at compile time.
 - fix tx buffer alignment workaround patch to align
   only misaligned buffers.

The patches are based on net-next-2.6 and has been
tested on the:
   - Freescale/STX "MPC5121ADS" board (board rev. 4) with
     a MPC5121e Rev. 2.
   - TQM860L and TQM855 boards.

Anatolij Gustschin (3):
  fs_enet: use dev_xxx instead of printk
  fs_enet: Add support for MPC512x to fs_enet driver
  fs_enet: add FEC TX buffer alignment workaround for MPC5121

 drivers/net/fs_enet/Kconfig        |   10 +++-
 drivers/net/fs_enet/fs_enet-main.c |   90 ++++++++++++++++++++++++++----------
 drivers/net/fs_enet/fs_enet.h      |   49 +++++++++++++++++++-
 drivers/net/fs_enet/mac-fcc.c      |    5 +-
 drivers/net/fs_enet/mac-fec.c      |   58 ++++++++++++++---------
 drivers/net/fs_enet/mac-scc.c      |    9 ++--
 drivers/net/fs_enet/mii-fec.c      |    4 +-
 7 files changed, 166 insertions(+), 59 deletions(-)

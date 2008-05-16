Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A6199DE32D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 02:51:02 +1000 (EST)
Date: Fri, 16 May 2008 20:51:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: [PATCH 4/4] [POWERPC] 86xx: mpc8610_hpcd: add SD/MMC card detect
	polling
Message-ID: <20080516165100.GD24196@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8610HPCD seem to not use interrupts for the SD CD line, so we need
poll it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index be430bc..47078e3 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -63,9 +63,15 @@ static int mmc_get_ro(struct device *dev)
 	return in_8(pixis_sdcsr) & PX_SDCSR_SD_WP;
 }
 
+static int mmc_get_cd(struct device *dev)
+{
+	return !(in_8(pixis_sdcsr) & PX_SDCSR_SD_nCD);
+}
+
 static struct mmc_spi_platform_data mmc_pdata = {
 	.ocr_mask = MMC_VDD_33_34,
 	.get_ro = mmc_get_ro,
+	.get_cd = mmc_get_cd,
 };
 
 static struct spi_board_info spi_boardinfo = {
-- 
1.5.5.1

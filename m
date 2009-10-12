Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id F086CB8019
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 03:49:23 +1100 (EST)
Date: Mon, 12 Oct 2009 20:49:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/8] spi_mpc8xxx: Fix uninitialized variable
Message-ID: <20091012164922.GE4578@oksana.dev.rtsoft.ru>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the following warning:

CC      drivers/spi/spi_mpc8xxx.o
  spi_mpc8xxx.c: In function 'of_mpc8xxx_spi_probe':
  spi_mpc8xxx.c:681: warning: 'ret' may be used uninitialized in this function

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/spi/spi_mpc8xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 0fd0ec4..518671b 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -709,6 +709,7 @@ static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
 		gpio = of_get_gpio_flags(np, i, &flags);
 		if (!gpio_is_valid(gpio)) {
 			dev_err(dev, "invalid gpio #%d: %d\n", i, gpio);
+			ret = gpio;
 			goto err_loop;
 		}
 
-- 
1.6.3.3

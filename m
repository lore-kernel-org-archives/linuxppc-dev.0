Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6scq4rSWzDvJx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:31:07 +1100 (AEDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3t6scj6QPczMrH5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:31:01 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/7] base: soc: Provide a dummy implementation of
 soc_device_match()
Date: Mon, 31 Oct 2016 12:30:52 +0100
Message-Id: <1477913455-5314-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a dummy implementation of soc_device_match(), to allow compiling
drivers that may be used on SoCs both with and without CONFIG_SOC_BUS,
and for compile testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 include/linux/sys_soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index 9f5eb06f9fd87565..bed223b70217fd2d 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -35,6 +35,12 @@ struct soc_device *soc_device_register(
  */
 struct device *soc_device_to_device(struct soc_device *soc);
 
+#ifdef CONFIG_SOC_BUS
 const struct soc_device_attribute *soc_device_match(
 	const struct soc_device_attribute *matches);
+#else
+static inline const struct soc_device_attribute *soc_device_match(
+	const struct soc_device_attribute *matches) { return NULL; }
+#endif
+
 #endif /* __SOC_BUS_H */
-- 
1.9.1

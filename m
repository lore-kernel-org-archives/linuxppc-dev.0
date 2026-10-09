Return-Path: <linuxppc-dev+bounces-29082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151BCCA5FED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 05:37:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1FxL1h9Nz2yjp;
	Fri, 09 Oct 2026 16:37:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791524246;
	cv=none; b=IeS6ALYCv2e287/ZhB+VVZsq/nf5fE6YTQBQ4TQH2sCYe8SN0hhH6UkQB9yY2QcmwgjBWOqBqqW6mtUrOFjprjB4kXUj2PzbTIIbp0wv/i3FTcBLf2E/kR6KaFbFCoU39XMeA9pxUe/uHAIEWJ5Slt8nb5zncJVd+2BDeIP/Db5kCmx6yEHch7nmCqwTW5HNJz9ExBRpYLdWINTW3RM3CrGjn1do6Sbdm7MG+fHj57ZlCK7W0tOHAGD/y/pw1hNBDSoKR84C0uZepkC+v7iQ9/y5J6rlmzBDdEwFz9cdiE9xXLieh7TEwyLVyuFFaWxsa5OtH3fHXA94p4t4aDF8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791524246; c=relaxed/relaxed;
	bh=WdbeveqM7N6Tv16KBvzRhi0QL6R3QI/o2YFgonCJgF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARQtysG6L7tRP1eFXQ8Ieq6uDisQilFpDfmSB5Bngk3RLHj0RajY8wgvPKt9RWxHkdknGaFOtHqL9KRJtYYy8vylIvJLeArUbcbBQQtfpfqeeci6O5kRMnL/W3encsdvg9+2jFz1g0otR1bq88kIiXFIsGjTQYrhz82AnrdkKg0gFiZmEglzPtoM0MOC+701tYfir4U7XSo0FR7JT1KQJtOZW9+oRmCZohasopR+wlmZI0ZFjf2oCII4JwtKVQezG7fzS/uGPFEJr1UbltKKNZPOh1MTjtgt1yWucvNwNS/wXUbQHIj18wY5pt2Yn8AWC4V/dOQJcTrnY2dr/ZZhvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1FxJ3NXWz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 16:37:23 +1100 (AEDT)
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3_jyNfchqKC0dCg--.3528S2;
	Fri, 09 Oct 2026 13:37:18 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: cpm1: tsa: fix wrong clocks released on cleanup
Date: Fri,  9 Oct 2026 13:37:20 +0800
Message-Id: <20261009053720.3146117-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3_jyNfchqKC0dCg--.3528S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4UtrWkXw4kGFWrCw4Durg_yoW8uFWUpr
	Z3KrWFvrZ2qFWqgFnrGw4IqF1rta17ta4xKrsxGa1IkrZxJF1Utr1DCa4xZFn5Cr1UCFsr
	XFyUGFs5G3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUqqNKUUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYPA2rIYxBI6AAAs9

tsa_of_parse_tdms() gets and enables tdm->l1tsync_clk and
tdm->l1tclk_clk in addition to l1rsync_clk and l1rclk_clk, but the
error cleanup path releases l1rsync_clk/l1rclk_clk again in the
l1tsync_clk/l1tclk_clk branches. The tsync/tclk clocks are leaked --
never disabled nor clk_put() -- while rsync/rclk are clk_put() twice,
underflowing their reference counts. tsa_remove() has the same
copy-paste bug.

Release the clock actually held in each cleanup branch.

Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/soc/fsl/qe/tsa.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 4a88e54d25b9..502e2ffe8689 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -865,12 +865,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			clk_put(tsa->tdm[i].l1rclk_clk);
 		}
 		if (tsa->tdm[i].l1tsync_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
-			clk_put(tsa->tdm[i].l1rsync_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tsync_clk);
+			clk_put(tsa->tdm[i].l1tsync_clk);
 		}
 		if (tsa->tdm[i].l1tclk_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rclk_clk);
-			clk_put(tsa->tdm[i].l1rclk_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tclk_clk);
+			clk_put(tsa->tdm[i].l1tclk_clk);
 		}
 	}
 	return ret;
@@ -1039,12 +1039,12 @@ static void tsa_remove(struct platform_device *pdev)
 			clk_put(tsa->tdm[i].l1rclk_clk);
 		}
 		if (tsa->tdm[i].l1tsync_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
-			clk_put(tsa->tdm[i].l1rsync_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tsync_clk);
+			clk_put(tsa->tdm[i].l1tsync_clk);
 		}
 		if (tsa->tdm[i].l1tclk_clk) {
-			clk_disable_unprepare(tsa->tdm[i].l1rclk_clk);
-			clk_put(tsa->tdm[i].l1rclk_clk);
+			clk_disable_unprepare(tsa->tdm[i].l1tclk_clk);
+			clk_put(tsa->tdm[i].l1tclk_clk);
 		}
 	}
 }
-- 
2.25.1



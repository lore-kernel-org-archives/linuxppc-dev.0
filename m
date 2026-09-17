Return-Path: <linuxppc-dev+bounces-27580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA6C982D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:34:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0DJ6NNQz2xbQ;
	Fri, 18 Sep 2026 01:34:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789659264;
	cv=none; b=SvlDNBKh5t64gYADsl6FzzdqVQToKlS3TLa2ElKRVCc7wU0cZ+OFdlMdQ3AZ7uF02P/kuPqR+D/JAMKHmE06Oh0L21W0bi72uXFTtppvT3bZqe57/Es4EqgeXBZ5/Ne040Bbazvgda7tYl/nSAuNlPwZFu8oPpctN02yThEZwnxgujyroctnkqD++5GLtL9iL4TEr0As8jUBPSDkcICgeWrKIcOkrUna9kk4L6ouk4ojZaD34wutMdge4b1iRPgHH76wCQ99CUhOLI4+OB79sHwAuIkFhgqpqzf7bkXXISsz+ewIjg64Rz+Jf+Ubw3E0THsfV5qZhc7fgYyfrRkPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789659264; c=relaxed/relaxed;
	bh=M4PNijSmMS/9kj5rI0Oh5irwWZU2tKZWHxAdBKgy4Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+tEyi6551OS++tGCOr9s4rss9a+JfWLKwTyz6rzNNmiM0vUyBapa0qzQqi07TyexVFdfN0nyU1m+7bKOizEFvDqIugXz/CxG8v0uZVVs/aOJhWWJi/wnk+7pN+HnVIoHyW0pFenxtEgXqIzfpkfHDvz2ZqbAWPcma7lAOCM5BGQVpIq+S6u/YXSFO5IqcYyGSMNCsnaRGoibLGP/QH1oSNzinSQOkoi/2ZqmaB6YjYU4pKEP/iSIxOHrSlr+aJpBqw++7AowoBsLmDzJKeoR91l+sUg0l5Q7meojlPrRkRrSCkcmxsFphCEntrBCC1NbQ1g0H+Vq/KmVx+doMXIEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 416 seconds by postgrey-1.37 at boromir; Fri, 18 Sep 2026 01:34:23 AEST
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm0DH4fHTz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 01:34:23 +1000 (AEST)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0LXBqxq54WDCA--.5805S2;
	Thu, 17 Sep 2026 23:27:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: chleroy@kernel.org,
	herve.codina@bootlin.com,
	leoyang.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	qiang.zhao@nxp.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
Date: Thu, 17 Sep 2026 15:27:19 +0000
Message-Id: <20260917152719.2160395-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:zQCowADnF0LXBqxq54WDCA--.5805S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy7Xr4rJw13WryfCr1rWFg_yoW8GryDp3
	93GrWYvrZaqrsYgFnrGw4IgFyrtay7tas7GrsxKa1I9rZxJ3WUKr1DCa4xuF1kCryUCFsF
	qFyUKr95G3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07UC38nUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qr9nAnhgAAsl

The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
and never puts l1tsync_clk or l1tclk_clk, because the branches that
guard the transmit clocks use the receive clock field names.

Use the matching field in each branch so every clock acquired by
tsa_of_parse_tdms() is released exactly once.

Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/soc/fsl/qe/tsa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 4a88e54d25b9..94691369353e 100644
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
-- 
2.34.1



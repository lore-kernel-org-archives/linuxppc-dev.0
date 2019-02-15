Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE8C10F04
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 02:36:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EF321927
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 02:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy/0ug7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EF321927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440y735ZLbzDq6K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 13:35:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vy/0ug7p"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440xgQ31W6zDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 13:15:30 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 087AD21934;
 Fri, 15 Feb 2019 02:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550196928;
 bh=DU8CL1zyXXLXMsSSamR3mxRVEo3Xi4RUvaqnPzs1Jwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vy/0ug7p0xReUXjmk9vARstkcWXpV3CQMC3E9vLe3uKGuHJ3DWDCVEDfkoNaTc5fd
 fxtbWkRvGwN6/9XPL2c8KCgSK1PttaNIUv8kTXZAq+4+QMgdxvyVbQ61drLZf7Sg3h
 OyYv3c1KMtoEtvASHmiX73qqsrNLtcZZZ20D99IQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 08/20] ASoC: imx-audmux: change snprintf to
 scnprintf for possible overflow
Date: Thu, 14 Feb 2019 21:14:59 -0500
Message-Id: <20190215021511.179333-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021511.179333-1-sashal@kernel.org>
References: <20190215021511.179333-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Greg KH <greg@kroah.com>, Will Deacon <will.deacon@arm.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Silvio Cesare <silvio.cesare@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Willy Tarreau <w@1wt.eu>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Silvio Cesare <silvio.cesare@gmail.com>

[ Upstream commit c407cd008fd039320d147088b52d0fa34ed3ddcb ]

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da341d61..136df38c4536 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
+	ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS output from %s, ",
 				audmux_port_string((ptcr >> 27) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS input, ");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk output from %s",
 				audmux_port_string((ptcr >> 22) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk input");
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"Port is symmetric");
 	} else {
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS output from %s, ",
 					audmux_port_string((ptcr >> 17) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS input, ");
 
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk output from %s",
 					audmux_port_string((ptcr >> 12) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk input");
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret,
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 			"\nData received from %s\n",
 			audmux_port_string((pdcr >> 13) & 0x7));
 
-- 
2.19.1


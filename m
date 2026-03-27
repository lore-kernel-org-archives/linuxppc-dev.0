Return-Path: <linuxppc-dev+bounces-18841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0614D10AB839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:58:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhj1M1DnQz2xld;
	Fri, 27 Mar 2026 11:57:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774570556;
	cv=none; b=iHT0hPSPiAAl0GWZ3gj8dRxQ2y5Mhqccp/F+7Xvfa+XgZNPKk/LxwpAcfEgWsxHaZFOsoA2dtY5xpUBEW6ScZGFX+baZPq4nZrTelTYqNtOlmKFea0rmtYnlURyBcSgsqSA7CtBzTVfmyp8ZC9JpPigIgWbl+nf1L6GyWEiUxl/g1iL3BMrTG2YVrEqPGIwcZYjQ0MdtU01zmD61xS6PpR9Fmz0lA9XhniN0KIwn6zH2R9gr6juVsSeTma8RgabhMyZ/8NhvtaP9RmvSbYWP/3z18e1zTUJ9Zs00u03ypz4wJKi9TO6V0LbGK+Qw3cDJ5bhTeBQIRcIFrW362PM/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774570556; c=relaxed/relaxed;
	bh=jF3VGWtFl5+5o0uq4BkVs4561ebEJfqMmvq/lQMWgIo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gL4XVwk1PVpdyBRtc+fVlxsN7gdokowaruRqFR43fklxs7d9uBAp5ACzHkuoKImcSwcGWAxMN19Q5GaW4IY+2P/dB6lQInbEHVfQJzM+IPHCSIVLAhHzm5k16TAHC1NV9N05bH+uNN1nRZ16e+x2O3M8U+1W+Qc74+nnlHX5JYWhEZF8Q8AIH5Vul+FbkA93B3iCP7VzvVdZ5hEnj/XI5gU3Am+8xhvXE35t8SLuz7nJoAbLr7HOuOS6TinvEBBn5bMYXGYstnckpt1iSox8jrLCa0NH64dWh7du1WYJLM0YtxTxSyFhhG43sDK1giiTEJjssP+0avEmzrn08NM8AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nzpBQwH3; dkim-atps=neutral; spf=pass (client-ip=203.205.221.210; helo=out203-205-221-210.mail.qq.com; envelope-from=1742789905@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nzpBQwH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.210; helo=out203-205-221-210.mail.qq.com; envelope-from=1742789905@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4fhh4n0VHLz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 11:15:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774570549; bh=jF3VGWtFl5+5o0uq4BkVs4561ebEJfqMmvq/lQMWgIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzpBQwH32QyzbCa/dnRSECDHVYxrDsrj2m+iSKxISqwYTMl/UCWhoRGVOV8ermZmB
	 DC8N41s6uI0xW0/cucjkPinOJmr5O/zE09oTrozy5I0EI6e8QhgCRHDPfgI9JQRWVH
	 /DfOb/CCGMwuU9QpS+6NV3OEHBcLFU76FyW4Dq/0=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 31B3D40A; Fri, 27 Mar 2026 08:12:27 +0800
X-QQ-mid: xmsmtpt1774570347t0b1u0f4c
Message-ID: <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
X-QQ-XMAILINFO: NOcEdvLhLw8TC3ZRP/Ms0StBJXSMyXt0mU2UswUKCWUlYxFjktxm4PCFaA1xS/
	 EyzMCbbnf0yAdffRpg0L3tinYG7P33cxMV7HET/P46r2gumZSJli6l+weTKjXu4Xz05bnuUZjiq0
	 pmeNp96t6ySl+iel6n/kLFUQ4jB/oHXJUdtkfa/4GsK1oSi3mE9NcU0/7Sm8GouX218nqxeCKNAe
	 LwiiNRm1iCtCBsLAz/96ynLKP6QvZ52ne2DDmdgcYgi9GkisNL5EWjuxwkA4c5TsawyE1bNa3DO7
	 BF7XbJPNNVsa06JylxRz4kLskpVXqmPs09Vwxn6iaK3eANR3IN5vmGDXzw2dA/9nx4UVIfov0F9+
	 3FD3ZLQom/kbFJOxCJfcD4ehTLaPG8nbmWOf982IWvOn24PKa5+3owmU1y4w3Pp5eVulVOIKMu+6
	 zVwphqDXppwIFAD9JKisnxWxKJ4+5Uq23hUJ2U3ZkSX05uxIxwqgEf87bC+SEHkaomIac4p9/3Lg
	 Jdd6Z5lXAueJyRSQIdrsOYeGy8aTMf61MnSrNMD1y8QJKlKOblGFejXIGN8oaRqLMgvCqOFYr2F6
	 bGmGgmB6z92I/MWqt+cdi5K0oJl00zBWs2XD1kucFkDnSUD6P2iwgpjMd2Wym5mMlLu1yXkHXK1t
	 AjaDRV3xkdT+duBWUk6CYiEZTHnHqh4Rox1fC6OWWh7gxV5vGXGKfK+ygKFdaGL7bQHhpo8OsNrh
	 ILo4L/k6l6CuNO/Un5shA//IrgSSL9zzT+RnjY+ZSWgfEnKoae1MaeBHmgzDi/x9BfGneqNimrwb
	 OhMBwcNZZ0TX5XskB89pFRAXzg0hm643TXzLnfu02X7O/reQluAWrKdhpBh6A+Nadf0L9IbxRBSi
	 WZDXm7B5wMHfT0pyXkm8jnvYn4f/aCcEkXwplDrHpumfbOjAd0WoOsHzgZqu6YwwTJpSIRSHlZ+y
	 bn/YtDozYt7Ua0ncRNxltyxIGiWiRxbsBIdkxiv/qeGhyD8dTE6x+RpXiFCF1H85SAkSvMx6+pkh
	 MbR+YM2tq39v/Tkg0aQM7b1OV2cDEx3JJo5eTeKpOo2liS2EZfZt4Db4lsRjzANEK2TNxpbQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Wang Jun <1742789905@qq.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] soc: fsl: qe: panic on ioremap() failure in qe_reset()
Date: Fri, 27 Mar 2026 08:12:25 +0800
X-OQ-MSGID: <20260327001225.23192-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
References: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
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

When ioremap() fails in qe_reset(), the global pointer qe_immr remains
NULL, leading to a subsequent NULL pointer dereference when the pointer
is accessed. Since this happens early in the boot process, a failure to
map a few bytes of I/O memory indicates a fatal error from which the
system cannot recover.

Follow the same pattern as qe_sdma_init() and panic immediately when
ioremap() fails. This avoids a silent NULL pointer dereference later
and makes the error explicit.

Fixes: 986585385131 ("[POWERPC] Add QUICC Engine (QE) infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/soc/fsl/qe/qe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 70b6eddb867b..9f6223043ee3 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -86,8 +86,12 @@ static phys_addr_t get_qe_base(void)
 
 void qe_reset(void)
 {
-	if (qe_immr == NULL)
+	if (qe_immr == NULL) {
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
+		if (qe_immr == NULL) {
+			panic("QE:ioremap failed!");
+		}
+	}
 
 	qe_snums_init();
 
-- 
2.43.0



Return-Path: <linuxppc-dev+bounces-27054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B00C88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgvfl6wcSz2yft;
	Fri, 11 Sep 2026 09:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789084479;
	cv=none; b=WXMPvBHM1i8avfy1wX9XxTxqBa3BXHJsDzkAq5g6pehjiAGIjoQ69cbboIF6I7AWJduTw36WSyAlsFlm4rk14ULqvaTQ7RNumc5loel4OGuEWK6qS3u78lEiT7sidNLhNv2SlMf8P6HyBYAwCmSggMDz6La2Y98m1HGYlBJlRi8CnlNP//6swVovIwTINbh/ZcCd0BTS8BQEcwH/c79qv5iyE8bLvCTBZGAG9DPZoow7BsQOQ7Vvi6lz6GRIlxk2VAzNtfLLOEsxiJKL9QTB59A8MvkkH+bLXjbt1uyVv9qwNbpumjfTYrQekMO7VQoTQZcPVlFXavqz4hsFJ8ljrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789084479; c=relaxed/relaxed;
	bh=iEJC8ovy/jeEI3H151lIUXdkoPv4NnE0mIQL+cpW8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsJKGhkpY4dMh+801YKiUhlqfEk3bWkVWd8Muewztw9JE55Kz/2Rj79xToVZT4DVd0DgaphoclOgS0oigqRaJEbTVf3bMLvaQZmzdPgxXsW/wCw8EG/A/sunu8WA5V/W0lk+yJJahvPYrE7UYmHHX2dotbPSnPQCelPaqzPakYYBLssX8m6n8awmXa2gyM/h/P+KtyoynmFw4JG/f/5GZWQORn+hLVM0aGYw+ovCjhiH9/NrLuhlNttMcdbwhGsz9uyf9KQs6GODvGoNUvtBdwowKVf17Varri9ZS/U0KW5VdaDvxldaGiMPIr/61sEzASmYAKSkbWd9LdZ5Zs4wxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n6C9U3Xp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n6C9U3Xp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com [IPv6:2607:f8b0:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgvfk1NtGz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:54:37 +1000 (AEST)
Received: by mail-qv2-x10.google.com with SMTP id 6a1803df08f44-90cdfc6db09so3270456d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084475; x=1789689275; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEJC8ovy/jeEI3H151lIUXdkoPv4NnE0mIQL+cpW8Yg=;
        b=n6C9U3XpnZR50FwewtmEigDmT2GcgOwdBAdinTCcJ6GUTMYNcDfstK5zg6/zMBtzXX
         ANiVf//67M+SPUSwQ4TZLw6jEVGFaxqudnVJA6UqjlMkwJsNN0r4tVzx3uXeEi6Mc4k3
         J9Fx5f2tosOVBd537mjISKDCOBh55865ACJ4EzDbJwOzMfv3iLiDIzBEdEpUI5ISbDGW
         pbn3PX6l7LymdlQdHFeL0JIzcspUFXjEe7v3tx6wmaKc6KcBB1xilBnOJPSCv/c9RXRY
         aPZVGqdYiQIcn4knv85U68YyuPI/+jpI3gbkBG4DqK4GIsi5FZcnfOGWXhW6gPwB27aZ
         UFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084475; x=1789689275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEJC8ovy/jeEI3H151lIUXdkoPv4NnE0mIQL+cpW8Yg=;
        b=Ey1fs5jVl4nGzpbE9xla6vKdewsSbn081DPlqADC/bPm2ZaxUzRy9VbzgRD62ke54h
         dlKjE2IHDVHzCo/TEgfrfGuuTUEoHA9vgBJphGIIVwmBx4Ypkx9oIPR99VHfLuepCSCM
         tnF9kZIyoUWRU7Vwz4xS2uAESKwN8qLTNQYEmBy4aBTWLJW812P7rv6UgnoPyyh46i0P
         7n0JMYaLmAE3lwedjvT6o8GU7nCDyh1GIhrqhkU96IKcFi5GfX9BJ3GwZLPxYXM4B721
         b0BH7nAjgl4BDfyKDHVCi8hmZzcwU27R5UOuILadmA02PPzfvecRH6+j5RwWKLEjvneO
         IJbg==
X-Forwarded-Encrypted: i=1; AKwUvBzwq+DyFJkpY+ERu3z3t+zRGgBojnjfTTCHaiV8XxM79hWrqFgPfnNSjzOyoC92GYf0b1kgzIjlQmZ9Its=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nPrYmnAFOx+14fQaCCDGe+w0E3Fz+pEypb1AUr729cJoL+cQkm
	zf6gwWjpRG0t7vZ3iMjL0mc+FYtPSJ35epJQIF3ouHuNrNeXohpC5zo=
X-Gm-Gg: AYBFou12Q+22TyM7Xuv2NJxM2//vlOy6FPixg2GmhH3O6gFa0TkELCL5sj7Fu6HtWta
	YG4MjAh2RUsV/zuVxV6jHubJnY8Zk8yJELM7HNojwDV0uUooXZVIx29CQKK6ATYAlAk19UqNNGl
	drh6XsdNDJrOVvgi6Q1H9NNl3jkbaKT3xpaQ8mhDR5sk/YoPpt12g5rCnygy9nigPGK1r7O1a1+
	re7oXZlgvXJx5mPhOg9NF/lEizv0RTOOChNoG0CqNjnShmviyNXKyDuwRD3AHP/mE3yI4L0QsZm
	XH7eVKyACfKWrM5JPnF94fWT05psJ+a7vWi0BY0gb0sOMPzEYnuUPS0DVXegFTzoS9X9/YsRbZX
	OtKnrrhwvWgvxMDPZIMVOZFVDlQUz03EiazIrB13tgLWdNitZmX20mJLa9XgWem5ehCdU/gH1Db
	iFho7fm1L7wObZKkqIwxL55QkXhWGHvWHmfItBOmwZHZYfcUdt5xc41+lqGeODvla9AHZ6iAZIr
	BE4bI5YuNKGs1NrAWYmgfJmLeOALnjmtRxGY8mj/oHstXoNpUpMa2X7kRN7YfPGc2F+KdLu8ZVW
	08y8uezxq74HRVvpj3yX7GjJEZQA06eFKA==
X-Received: by 2002:a05:622a:1a8c:b0:530:b2e3:86c0 with SMTP id d75a77b69052e-530c877ae0dmr35072231cf.50.1789084475199;
        Thu, 10 Sep 2026 16:54:35 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/4] net: wan: fsl_ucc_hdlc: validate protocol before starting device
Date: Thu, 10 Sep 2026 19:54:27 -0400
Message-ID: <9cdca816ef561fec983c79c39a3bb9564d4a0e06.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
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

uhdlc_open() starts the UCC, IRQ and NAPI before it calls hdlc_open().
If no HDLC protocol has been attached, hdlc_open() returns -ENOSYS. The
error path then calls uhdlc_close(), which calls hdlc_close() and
dereferences hdlc->proto even though it is NULL. Bringing up a freshly
registered interface before an IF_PROTO ioctl can therefore trigger a
NULL pointer dereference.

Call hdlc_open() before enabling the hardware. Balance a successful
protocol open with hdlc_close() if requesting the IRQ then fails. This
matches peer HDLC drivers and avoids running teardown for a protocol that
never opened.

Fixes: a59addacf899 ("drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f56..82796452e54a2 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,8 +34,6 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
-static int uhdlc_close(struct net_device *dev);
-
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -705,12 +703,18 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
-	int rc = 0;
+	int rc;
 
 	if (priv->hdlc_busy != 1) {
+		rc = hdlc_open(dev);
+		if (rc)
+			return rc;
+
 		if (request_irq(priv->ut_info->uf_info.irq,
-				ucc_hdlc_irq_handler, 0, "hdlc", priv))
+				ucc_hdlc_irq_handler, 0, "hdlc", priv)) {
+			hdlc_close(dev);
 			return -ENODEV;
+		}
 
 		cecr_subblock = ucc_fast_get_qe_cr_subblock(
 					priv->ut_info->uf_info.ucc_num);
@@ -729,13 +733,9 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-
-		rc = hdlc_open(dev);
-		if (rc)
-			uhdlc_close(dev);
 	}
 
-	return rc;
+	return 0;
 }
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
-- 
2.47.1


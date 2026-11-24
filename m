Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946B606A69A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nopl3EES
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYVyZ3L8Xz2yCP;
	Tue, 24 Nov 2026 16:01:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795496486;
	cv=none; b=GPVpZGdStsS5skjssn41jbpArKxCAyuI3BiqXLlbjeLx8UWw3/4X8ggcPBdU2HOY9Hvo2j3+kDeYP3kcu739zDpn+FffXdd8SCZoHAVnyD4Zk30iKI0O9iPK/yCyxMvjmeGkCfo70bwjqnNKibT8SW/UMcmKAZwQAKqCvfnle+PEygFmLgcd88nI7cHxYvm/+E4kmvtXly9it18sPNHySlBs3k1TiQwexcnslY/6dLNkGzbsbH3L0dqflNJhTNpFhG0rujYAnQ13X6zpveaTVQtjNaHPCk8CyIE4+QWUy4JcD5eevy43oh6p8UsYXnixU0HJ+j9Zy23c38gblcddzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795496486; c=relaxed/relaxed;
	bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv4gAYZlIUcZoGI9TfyJRUgGX0LCENKDgMgXf5pK01GfQyvlHA753+El2FOme5gStyQktsF1VUO8hcFvhrVcJ+aRGyF11+556wZVonncHRBSAH/pFnjYiiYKTD5hOBxpctSPTJ4Z8vtZ4zOMPY5UMB2USPqZxBZdaiHZJBYe9ifeHZoLUxqSXrp0hPDV2DV3TkHBQyasWJXwNEZCaCEOawtqzOabkX0G7jrknrVt4+IEAkfPdvUc/5qWd9CWaEHjakqdqB5Fuk3p23tfQQwQ/FhU8mDAhGzXflRJssHVgFRIFociO9JqcubiW13ebVkuKEK1NgEcWGoTLnDDEnG4YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nopl3EES; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nopl3EES;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYVyY389wz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 16:01:25 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso38869985e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496482; x=1796101282; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
        b=Nopl3EES6WjW/DtON5YTXMplxIk/WKTQdtnN/Uu0NurZYWcxzklU71cuWTCkzqFnPS
         2bBM48Ahd9mLXRk89jQsYxwAqCUVWKH5wop1cXoOAM9KxVgiXgShfuN6sC333NDU/wPd
         lPHgfGk/h8nCrwtXVAj8dQRkKfpVjukyNYFehw3K6dsCnKCf6K604KcOh9/KDoJUq9M5
         N8OC3DOVOF9s29ccY/RqgZ69ACnCkdCWrJ9qUQ/rbMshatJ45B1otnxYWB+eei7J32Lk
         BrrOJBWh1HkfIWqxDdgnuFQUEryh7BlRCUcX4ND13P3acWvKwDB7sYYyoMHL6Mp9q3Kt
         m/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496482; x=1796101282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
        b=dsyHU03vVh42Vo7M+Lime4ObmC/6816hoNOKkfq7BDPWA11v58Ws9ADwv4gT7HLXyJ
         8JT7PRjC27D1qbU2nLZWxuZy8uiAkLVFr8dEsbP88iBdWC/KWzfirKVmz8U3/IHnzlkJ
         LuLy7MXI957+OyuWXn+hmnvn9iqEcVBCf+yAUZOpbYgLnr0TMlIWD1PgzUN7KVTKq5OI
         xEWYvxZyhTZvK9L9IPS9BJ4EHKL4mmOmp61uko2+Q9w2g/CDHw6TiXrBx8RUS9YMCdrR
         k92HtUJ8oxLSV/iDqHp/1DjT/9Pq6/c+YyrWZXRIIJt8w1HtXKZMcKLgOJCfZP4yJjwv
         6rFQ==
X-Forwarded-Encrypted: i=1; AL+hErFNsdbpBG81O5JspLIJAO3DJbXMYa1YqFkHGQrNZaUGptoVohP5xMGwmzF5myB7XQPuuw1r44Oth30u7U4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8ewh/DI9cpVyVzyEYfXgmaJ61pmpK1rgovN+1tJ8wuD2apBO6U
	pw81to836BFI2hrOfh5t0r3HGpiyXxlnGaVmmYRu2K4cHz7jZHCWHpDR
X-Gm-Gg: AZFdTZeo+IMZ0EeTn3deZi+WcRkb+G1q172nLlj7ZDDl0u6pCGCfIY6Tef127R4Ve2M
	zvSjsyNcRJfnBZN/VCKKmomiKIPtOnD/rSc3f1/pIa0fyxYOP3Djzpse21cmpXy4o4CMfEOPNW5
	+gI4ymN/J9+TdLVA2ll+uBOhOgBTCFNXQ970qYYteGxui/wIiAZQopDGclYkY542fWho1u4+Hba
	ty0IxoqqTLxtSwmidJruN9w/iRYTKv0XpedevFSqeWNmxJTpGMisaFjCLpwEUrYoPTT0krd3RWi
	u7txkW2NubntYtwTsoqTP/aIl9MB8Vgew63j/rXfl/kLaslxODsh3h6/OtSOyg/OWxDX7LhWieL
	/h35EWbvIQTVgrCTgGbhO9ZYj2x6PJExDGTrVNDUWrDECXXCGggDrSe+Hco2rNZWrd7IpD6XFeK
	hHBVmL6uL+QmTpPrcYTaQOyUqV0OZYLnX6vRSGPUwiyKUKkwLKPlR89OLTaTJnx50E84ScfcTO+
	yeONDxQ5QpJJorr8tSr3X22XirWYyhTgrJBqyF3abr/IStto3LCsRd8RCxX+VWXTT2VicTeBuLn
	vdZQLeUsJZhvhm6wgr5+6AgyWTPBXxtR4DW+xEh1qfgRu/V+PmXVU9utNkwnZIIXetImJnlPyHi
	nJVr10OiJrgYcPfgvscRl15EwS5MxI8sRgbNhNDVhO3j3NUZiLk2+QMtxeXYNZ4xFSrvX5q6GBC
	OR3D+O6lVlV1Bo51AlAaPtVq8k4bpqgHb1OgLidEP03nWF3W6jr4fE
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id 5b1f17b1804b1-4bb8881a890mr272747495e9.22.1795496481860;
        Mon, 23 Nov 2026 21:01:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:21 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: watchdog: maxim,max63xx: Add wdi-gpios
Date: Tue, 24 Nov 2026 06:01:16 +0100
Message-ID: <20261124050118.87944-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pali Rohár <pali@kernel.org>

On some boards only the SET pins of the watchdog are mapped to the
register, and its WDI (watchdog input) pin is connected to a GPIO. The
CZ.NIC Turris 1.x routers are wired this way.

Add an optional wdi-gpios property for that GPIO.

Signed-off-by: Pali Rohár <pali@kernel.org>
[pepe.schlehofer@gmail.com: rename gpios to wdi-gpios, reword the description]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - rename the property to wdi-gpios (Rob)
    - wrap the description at 80 columns (Rob)
    
    Changes in v3:
    * Extend description

 .../devicetree/bindings/watchdog/maxim,max63xx.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index defe0401ded0..72f16d9f4596 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -28,6 +28,12 @@ properties:
     description: This is a 1-byte memory-mapped address
     maxItems: 1
 
+  wdi-gpios:
+    description:
+      GPIO connected to the WDI (watchdog input) pin, on boards where WDI is
+      not driven through the memory-mapped register.
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.54.0 (Apple Git-157)



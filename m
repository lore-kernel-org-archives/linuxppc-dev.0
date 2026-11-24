Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57110606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYsqcdY0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYVyd2018z30W5;
	Tue, 24 Nov 2026 16:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795496489;
	cv=none; b=bh/yO8jp3hkNup5/YaBi9LgDNcdRPcyqvy4CGrdIueBiDJLRyy+Ud0dBcKrRtwcVrRHoQBS8QS44YgYIB259yZxDWF6AGzMJC2Vxkngird9+L3NGdTZLclUZOCdEF4C+02MNsNiYAPa+YIFp4tZMAna9KwRppFDYkD5HWUvcHQUD5sMTHybY8/dVO3ZbyA+wUMVrgz9BD/FicMwzlhCfxr3Im5wXlMiMnYClNVvYYTkfXUdPR+/rZenH8HJjOQM1G7+Qf4pF+ijgJBn082h7UA2R/J0eXgH1MIIE0IClY781eZ/WMoXb7yzVX48naSxFdpFvHMsZEN2LmIA+HDmUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795496489; c=relaxed/relaxed;
	bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnbjJNEs8QNnMQBRsnW+e19s7j9A2Vk4aJlMWxJhc8Feg6YKBYvdDvYDUiJMPURs2iHRm72KC3yKBnAJHbpa0gNd4ta/Px/x3MVz+W3pLbCMBb70GRZEr+Gh7EKhLgOj+ulLbpVzICERUGyEkHwglLyGyEusWOFlH7ABqm2NpRqZnJ/iCG9caKE2yq69BVC54whS1KLZsrPm28dp1xbtFaknjwCAyh2pFxfRDOGTSsbmyHLEi/2w7E8ejZf65oBPWIrIWtpXZqFVd5r25pJqjjapWFRU+RZbQhSgvav29XXBFJ712S1v/BgexMRGYPwaNdbUHrI6uL2w13ov+PXZew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYsqcdY0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYsqcdY0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYVyc27hTz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 16:01:27 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso49236015e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496484; x=1796101284; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
        b=rYsqcdY0kMc3xCI0bba4cfyeEMgq2Ilc51qKwa2KZrIYnuYBFODXnHT8f6+fBPNDA1
         IUkqB9n4xTV8gzLB9k/hYdfuwCAHandmMPItEdlY51Ykr9dUVWIZ+SlAEWnZEN4Qt5rn
         veIptcCQ9B4WX4ms2BFLtFGQtnTqG7dVKEco/bT3vBBq16l+55WEAd1nYnwh+ZWJr+kv
         QBKrgcA8pPpY7KlucXxCRvtg5HEKKJv4eqLuCoWF+Fstef+OdL1MQBo2Lxg0SZEK3iTg
         EvZWY62T+uBaU1KSqd7s8s+L7BovyG1E8FKMJ4VD6YG1EkKP2MAg/s1xGNr4l0/isk7j
         pcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496484; x=1796101284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
        b=NVcVGzX1JR0DZaRmJM7G+mxIbh6y++bRbIXdhRXk8iyV4k1QTDpJpNGuPnfNhX7FvW
         DsTkwpmXT7bFrANScQI1priIfG86i/l6Jr5hE8r0bTdz41i0A4NPvSJQrXNMmmp+M2oI
         4gzkfYBfOx8QETUL8P5bZmdB6TD55crotcZ7cnAEjAZKy8QOti0VS+FEBqlq8H9Y1yV6
         cz78pg9CAoZa73XMZBgtEwNBvg3ou/iXsMnKeLnG5wicisZB86l2gzQYsFjhAyKNNm1Z
         aQd+KEd2rAdb6XM51hpEwt4wiSbXyGYV2A+O5/mm0TO1ilRMqY6YrSkz8+6CnzPopr7h
         wWvA==
X-Forwarded-Encrypted: i=1; AL+hErEJxfGA91/cf0B8bssnUngIUesMRk1423Q8B6rd3+4mOqo7t7YzHJL0DuCzIsX2MyRHxQXVlttJ1urRyPM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+0QjIgRiQUOa69vqPbBlSgIvdCiOC6qz41le1FpsiT47uOdI5+
	BIL2vd1/xCnTt2b90amaDBC5NmvYZ6VTE+1KmQ8NmfbFa6Hgpn2CFy9M
X-Gm-Gg: AZFdTZexr1et60QZtUPhGPs1N79J6+JnyPE6MMlAEDz1Tgk5iwZjcuZKcM0xkV2VASg
	KprS5I6CSbYMM4zk83d/Kbq6I6t3TSb/LVSmoMrYsqCHDejghQ+3/n5jjyvs/L6HBeXBeV1wWYI
	I/ABIahW59/8p8ZRZd94PFT6cu4BlGjfYDcaJES751LlWeFwJE6TdsTgfPQOrIMtxowQ41XPSjr
	zO02Vu3CbKOkTAB17mE7hUlLIm2Y1a2prNHRN24Uw2n16wupdAvTItiYvBsrmBkX+LbUtuMRhxq
	/6oMOPV4+ZHTxPCAgp6/csNwvtPJ443YNHt7v72qmU1SrWvkerQHzbzVS5rQ3vA2RNdDZ7BXwdJ
	qZHznVPwwp4UkePrs5b/tQteu3H2T+p6oI7NSVIa9IqmpA2HBmWety5PEReKESOT4JiwuUrHh2U
	YdiROpIO8TWbWfBNb8ZFUj/84px7QW/ZipncdUNh+PskhYh2zLFQugIQc5/jntCjU2xO9/PRUDG
	ij20hfhC69sZpBko7MUBe6iNvfZX9zbIayiBmmWDMF/RAmRxahyHJHj04d2FF+5zFPA5x+tFI0M
	O9OQHSSNkI8H5Ni48lpLQwofkoma/gOVmFYC6+zk7462Bw6YWqhft9046j2f+sBuVZaihKmv9hC
	DDKlnqtNqtjOmcWBMeXQrE6Y+4fMQsqS6VkLhzTHJXapKzGJuiJANGAikU5WkRv1lgIOkezMKhH
	AxJ8KE5ewC4j70+UoEqwZqlSGnVPIE9rmkTSaDH+5keRKSH+qR3fxt
X-Received: by 2002:a05:600c:674f:b0:4bb:56bb:1196 with SMTP id 5b1f17b1804b1-4bb8880fb9bmr266365245e9.23.1795496484431;
        Mon, 23 Nov 2026 21:01:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:23 -0800 (PST)
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
Subject: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Use wdi-gpios for the watchdog
Date: Tue, 24 Nov 2026 06:01:18 +0100
Message-ID: <20261124050118.87944-4-pepe.schlehofer@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The watchdog node passes its WDI GPIO in a gpios property, which the
maxim,max63xx binding does not define and the max63xx_wdt driver does
not read. dtbs_check reports it for watchdog@2:

  Unevaluated properties are not allowed ('gpios' was unexpected)

Rename it to wdi-gpios, which the binding defines and the driver reads.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - new patch

 arch/powerpc/boot/dts/turris1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index dff1ea074d9d..494a96a1f78c 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -363,7 +363,7 @@
 				 */
 				compatible = "maxim,max6370";
 				reg = <0x02 0x01>;
-				gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+				wdi-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 			};
 
 			reboot@d {
-- 
2.54.0 (Apple Git-157)



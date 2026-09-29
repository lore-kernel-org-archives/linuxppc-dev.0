Return-Path: <linuxppc-dev+bounces-28435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ECFCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 02:29:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv2Db2p39z30Vb;
	Tue, 29 Sep 2026 12:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790648943;
	cv=none; b=hl0HoHJOd/KCsNjj1FsCogezyOdfDA8L77W2vm1njT38lhy+EPTEVtg6FGPgULQJzG8BYATtKl+RfYCdgaqhHV8PuE+g3PE0rzgapTRxFhNcK2nLWk/UaeU4gtjMzbxX0dRbM4DAf4dvQCFAkklEA0gKqHuLLRb9pCj/mTl51sAomNShLMWO5bLyMlB0Oh4KuRYpC2Yp4p6pG4AURD5lvBknkkJKClhNRo8vOE28DvGKGGl16HT+uuzH9B9KYjGoNhrWNqaHQz6IdtdcanRQNgJJyXzFhW2s07z30S/aFHUWY+BloTQ6jP7REm7M+aZx7aC+5h/eOY/D27DNxI64gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790648943; c=relaxed/relaxed;
	bh=N2Q7/Tr8R4pY/MWK1/a6+UXwdCPjDDbiUS19/ruPYIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XobbCGnHH6/1xToIlqmdeZ2RkP3D5VGBeQTrzCtVWO5tkSQz1a/t+GHn2Uv2f4BBflX115dz/rwqOkoLDo36l15jw3QT+f5H2k+pS0JBMRKC4TiZJC1eHjDcn8ooArJikDFm5s8s8w3Er7tgIsKiA+im9PvGztoM48FoAZM9v8/Vo27+ctmCbi9Fb8chDi6Mh/ynmeO7iqb6W4Jf9mK6QfWUC/OTtquRKm2dqKwIAl6/T56qvmTf0WBJ14UaEZdMK6Q7BVNqh4XzHh2VDDIsMOWJYNfKDjGAWIg/vGor2YMW7B1sNd1YmIgkGUtmglvMaEMLEXPuWsFqxtrn1Jvc8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2PPMQ8d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::c; helo=mail-pz2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2PPMQ8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::c; helo=mail-pz2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0c.google.com (mail-pz2-x0c.google.com [IPv6:2607:f8b0:4864:3b::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv2DZ2sjrz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 12:29:01 +1000 (AEST)
Received: by mail-pz2-x0c.google.com with SMTP id d2e1a72fcca58-87c90648f99so2781240b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790648939; x=1791253739; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2Q7/Tr8R4pY/MWK1/a6+UXwdCPjDDbiUS19/ruPYIY=;
        b=X2PPMQ8dACBaj/mamrUhBDZTfuYowL0kXgGa/5n821GTduMGgd2tKFfDeimuRueBdx
         IP8/q5+M2YWvJ/cC1ckT2YxgUi3YNGFJ3KH8LNyFoKFthBxsiAdRZ44MWDrTKz8KcOpD
         0z3mcOlyX+LKv2bNitrNrIZoVcDcULNgPFn7Qk9h1w7B2bXQhRMJ2r4TOGpzZmSe5mTk
         e1KfZXmEysOHR6ZkVmAvvDc0n1tSFLW5d7sWEaIu6crj3vJS++eXaXrUGsJnlrc7e7ZK
         XqbTleCjdKwjAZPy29/Vr41/NvqSYj7uxHUoNf8o+A8sk0jwrfuwNGyc5T6+mWRlnnbE
         KkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648939; x=1791253739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2Q7/Tr8R4pY/MWK1/a6+UXwdCPjDDbiUS19/ruPYIY=;
        b=utFYn6+0viiDbVfVRAtZ7E2I7Ev9hsdxiJPAsGkgv8BjOy83puP3cML7sUq7xbyAfP
         n5au2/Awb/1z6Hl+5W7rlFO+st34jdBl9lBWWf8NG2kZMhZCl7zzwWNAxdF765IiH1mR
         t0LYHMWvMweXkofKOcB0OOCHrzJI8GltZOtat1cPBFb0OzL6TtgcUkpGpjVQL4yCb9cf
         YwqyfgSMfCyu/b1fnJ8Jh2UbaqYjL5zAQNJDyZzXrUqjiaS0bb48o6qQohw+XhWhbw3W
         zJdkeS3dhGAxMq30QFuasOEwu21/CrcR55fZTvLIQ7VatAirlv1tQ3d5r5XQUZLkUnU3
         q5BA==
X-Gm-Message-State: AFuF++lSRSKda+gdZrOJSnMK7LyluNJmbWFIXIUyl52Dx00JG/qugWBG
	ND5GjVbwUnXsSC7CCvI0FjpEz2Rpmnvk3Fauaktd4EnsJ248dF1O1H23DHXM5EDv
X-Gm-Gg: AYBFou0Fr3e+xSfuoCKCu7iCsqWA5bt9d5OTNMBY0itVYh1ANxZnVD52EiGjRZp8zdX
	yhXAYbw5B27TnJ07hOauVi4hiWKmSAdYRivL02sMtAlBV/Foy5yk/jZMEU1iW4Ghgvsl7tudhPV
	6IyCBpXLmfaAopILlOJ+fAe8Hq26+Xx/u8a7OLycO9pMOn4AwCINX0v4vHljdzqy0VoTGprdvn/
	fejGlK6qMrZHtPGq3Rx9AfN69vlRYyGldV24fz7ey6ROHBJNHXDLbpSSTx3QoVMjjC7ID6OQ8cT
	3nlmVGP2VD6vWa4oK7mU2dc8sVUtsDAY5f4KLcewLMBHslhuIc5vcANhqapWrFqJeIteMhMweKg
	LVSAlvd7WxKcOXZsNxs1IHGtyXJI68Wv4+X2L2togjl4Bw9CRfdcrluB7/Ep6cZey9sffCEV39R
	t15NcwZmo74D40/YF+4jezXO4Skl8l5aSqXVFf22bhFAS3EyBWqJJD9fbz20ignk6fqFjT5SbQn
	+8kNJZC0xJ7n0UnkN8vRBsNaISV9XMfWDXibCSsGZDhnv80I01a14lAiFvJxdfwi4/DXAVcyNUi
	rJ6zlQDAWGd1dVlirvCx8weWBnKs1q9e9CEP7VfOluIU/GETWQ==
X-Received: by 2002:a05:6a20:c709:b0:3dd:ff93:a99 with SMTP id adf61e73a8af0-3de0e73d7b6mr14414466637.25.1790648939195;
        Mon, 28 Sep 2026 19:28:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc79219db77sm4919997a12.14.2026.09.28.19.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:28:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] powerpc: dts: eiger: add placeholder reg to ndfc node
Date: Mon, 28 Sep 2026 19:28:55 -0700
Message-ID: <20260929022855.24484-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The ndfc node of eiger.dts has no reg property, U-Boot fills it in at
runtime.  The new IBM NDFC binding makes it required, so dtbs_check
now reports

  ndfc@1,0 (ibm,ndfc): 'reg' is a required property

Add a zeroed placeholder, as the nor_flash@0,0 node in the same file
already does.

Tested with dt-validate on eiger.dtb.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix default reg
 arch/powerpc/boot/dts/eiger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
index dc4d74c523ec..33ce507e71d4 100644
--- a/arch/powerpc/boot/dts/eiger.dts
+++ b/arch/powerpc/boot/dts/eiger.dts
@@ -196,7 +196,7 @@ partition@3fa0000 {
 
 				ndfc@1,0 {
 					compatible = "ibm,ndfc";
-					/* reg property is supplied by U-boot */
+					reg = <0x00000001 0x00000000 0x00000000>; /* Filled in by U-Boot */
 					ccr = <0x00003000>;
 					bank-settings = <0x80002222>;
 					#address-cells = <1>;
-- 
2.55.0



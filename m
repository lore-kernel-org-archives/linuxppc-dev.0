Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1660A2623
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbsAO9uC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPy752Tl1z30WQ;
	Thu, 12 Nov 2026 08:57:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794434257;
	cv=none; b=htHDfR+Qo3g9Njfx/ZZHhj6fFAPnt3gp8AYAh3Xb51pwKJa24swR03/a9ljXAUQ5HUjzsRFDNObKmS/cZ4EkWzEcY8+69ypRajzlEHVPg1U3H/0/NA8rOLsLA9Vm659DqWMzTDdbjUnR9tXdQjWFJr4U257FnKMZvYsAe8oTRdyzoptT8FnkDzsygXit82RIoR5F6a0buWhqJ7kVL+d3S5DXrnAnSuvOnGa+jDzy7raXE/Sb8df4HMnys11LGNsoYic++H8XQBDLbvUM2fuaKUipiqQYLHM2PhTCZBeNxyoFewZJZNg/m8QOBCGniNEgxgQD5vZ0Vs2m5dMGculewA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794434257; c=relaxed/relaxed;
	bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/0cxPedcHwhEk+iCuMyOF8geXOzEhT7CUvE+xxGMmVeEKtV8nERy/teb4jnkmD7coWR+vfBTZQkv/cEL+UT8OcBHxDisQy+82lYFNT1cSyoJGth5aUnLwegJA/lz8MmmmrgWaXUPjZgHTeBCDD/cC2K1GhxsHHy3ov6rmK1wiHxbpQ3TN3J+QdlfXpRp7lZ/oq/5y9S/k5lR/h8NmzTFDcqxScr9kBV71TZgEuqZ1iWPXzMN2KR4QP5S4XDXhv0hDneXK1fqQtz3PW7p7vpybswG2tPMkfpcJTE6rcSaxsxU503JgjZjjVsSiElARXvWh+IWdCQD2QXiHmIPzIbEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbsAO9uC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbsAO9uC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPy745Fvnz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:57:36 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so7057644eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434255; x=1795039055; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
        b=TbsAO9uC75n2xSZhXhoisKHFBd3J4+G1MRgmakEjHkt+k7XMoQkXoZLN6TM0qJ9sd9
         3YZK2oJKYxfA3/6/NfZSejdazmhBslyOd6weVdD7z78+wyOop8l8QiiIS/v2AC6lR53j
         tKICW11OGTbbaEXUkiPIXsxAb6OeyvvwZUyYYwnVU7Zd7h3cTtJtA21tVf4ywwaSfqDx
         nyj95MoNwqfDy4M6e/R4w43fm9aupQbNxWPRdu8PO3juZA8c64V4ztr7pVo6QBtfUtJp
         yXwItp9Iibe/0VYM5cRXbDlMNNxEKv05zGBz0eryWvWunrRlcm+wAN8viBqOEl5qiTgi
         C1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434255; x=1795039055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
        b=P9Se/4UFrfX9thyN3jCWHM1Hrxl/1VCnxIY+ViuC1YKAKimQGGlKJ00nPGa4uDhWG9
         eUfSgt+KTcUeDUvSoFxAikvM9v1C7yLxIGk/K+u3IBMGOqaW9WGH0GXpDWDlrBAGT35i
         ZQ/yB3YhQQLacVcfgVoJsg3JTn/37PQE43eEk27KyK8c6GiBvtebj2ohxv9ZuZfwBY3F
         bUk7wbJBP4s/1RjjKScq0ASkOfbtv5FY3Rfw28D1xTOfcXDj3KZhC15GjoL6GbOpw8Mx
         TPvIDuKiCKZ+FBFJ0piGK+v9Clc6Am+sVetP83FZoMVRdWKULxLQUHr6yViZoAm5E2Zj
         BU+A==
X-Forwarded-Encrypted: i=1; AL+hErFOaT/LIzBaZ1pVdUpONgsO5HBsHHEi/aZeqslwohvUuNlAvnMfEsUvbo0MzfRSNkkStpluh2iLcClLXAc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+IKDMsbsmpUTQUMRV3I0qZX4QRBubcBrtV9ktM/bCHFqUT5ZsS
	lQ87XPAarbiK+AIun2u9TAgQu+ad8s0z9V32tTsEZmvO/+fR/cBwaWRI
X-Gm-Gg: AYBFou3TY8rUWSquP2x7kDjByUN6l19rT8GJFJ6WzDi+BZRwPUwcEMwrgValpvVYf1B
	biEptc949aK52nRtJcUJ5nS4KgEuZ0q5n/85Q0YzZfcu/CjsiIxK9ewkzyUR59lsA0FUB1txuNT
	AR3zNqP9gChmLt2GL/SHPD2L3O0NgpKws5zGUiZtH1ucCSUB8O5VbzMcjx7Isp4QRdYBv8FX3L7
	OHEZfHkp9U532teXDnh7rxgLVn5fztn3WMf0wa/QaKBZdPVnNYCHsRyCg5DNrN5vne7pdLYqf15
	78Mdv1RFBmXSzCiiGpq88GTQj+7GHExptPPaPp0ki4p49rJAX2YQXdjJVkkUjtyH2QeDpz/hk26
	NqoSg6lgZUCQB2RzIde8zJhHZIMSDHlOKPQlLcENhfO7TlLwsG4RuCfy7H7Sky43eVDD7C8pbGD
	m2MVuFu1Ob9GPM66JZrRdczVegxuQW0678KwTxOYBCCBLc2ShVfwtf9L34id0VAL7S8NXXNFhEZ
	a02ckAN0AtRgCUYZSE+HbSAzSAqJWvTFgr6VnJyEIfjkeR6XshwYAH99B1df1VH+USNczl3EFqG
	wqLlKR192rG4F+14dfmezIaEqENzb0baw9VGrvH6Hg+qsMvFc64GrBDvnogq9D8Yij9eoXffbgr
	TOLCNFtdpXBzFo32BGA==
X-Received: by 2002:a05:693c:60cd:b0:369:f18f:3492 with SMTP id 5a478bee46e88-37686d38d9dmr5076667eec.35.1794434254626;
        Wed, 11 Nov 2026 13:57:34 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:eb83:637b:7b26:8dfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm17823523eec.3.2026.11.11.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:57:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Martin Diehl <m-diehl@gmx.de>,
	"Alfred E . Heggestad" <aeh@db.org>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Slawomir Stepien <sst@poczta.fm>,
	Jie Wang <jie.wang@intel.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	usbb2k-api-dev@nongnu.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
Date: Wed, 11 Nov 2026 13:57:22 -0800
Message-ID: <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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

The yealink driver is obsolete and being removed. Drop its module
selection from ppc6xx_defconfig.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 8aab229fb909..29acc77573d6 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_INPUT_ATI_REMOTE2=m
 CONFIG_INPUT_KEYSPAN_REMOTE=m
 CONFIG_INPUT_POWERMATE=m
-CONFIG_INPUT_YEALINK=m
 CONFIG_INPUT_CM109=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_SERIO_RAW=m
-- 
2.56.0.567.gdb80ae8cd5-goog



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA9606CF69
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FlOVSRK1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNzZD6Qdkz2yCr;
	Tue, 10 Nov 2026 18:59:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794297556;
	cv=none; b=HZuem0xbqGPshap0+PXE9FC1GTI0ifvQcB0urKyu0frJsz/CGj2eZvarp6veUOPa2K6gfM2803dTf25hqMV62czAE5KoloQwAKiIK0uKHxd3RT9mXTcPP/idkDWwBsHbJ33pGYLjCPf+HaY+5pfzwKebkTBMdFTlRiQV6seUvItxbMFDi1HEvkvD63r19ZYVDUGtw2XM5qTe6r8G3QULC/eGvB/fGvzHq6ocma03I4bbKri8E9g0y13tjpFOEyG9o83KIOucr+gVc9N/kkX6pzV8RZgn+/m1XUxNwe0HenYrxteH21hyr5c9dYrXtdBIfBXqU/aPQfkS1zaAAX6/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794297556; c=relaxed/relaxed;
	bh=HxK09xxN2287CuasdDaPYZTGt3qPRFw1gcuA14R7A5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoTaGwbQIHxgA2jtB1bjCe708y5YO0J9KOoC+ZC95xo9Us+IRnu+n/UNyvm1PjwPtHTWQCjdzZVXS8YZVKRUWq2UwkFn2OIm2a+390o5YIa6OUd606CiyDk+0uKRTvKh1URVmGxxmFvjvk21PiuKUggzZvJSDiJhECjlim11EoVOAcNI+NXjaMTSrldjm1PCEaNVeReGADp2U0p7HzWLUDxXkm1uLNErDD4ldi93XvNBY3PB+YK568pk3nsU1iZrNvZy1j7UvBJ7ardoBUy1NW08CwTeNhIkbSyRISTqtvpnN1v5hP3LNP5dTuKACLDC4G8e8bMCjxKZbuGhAc6E9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FlOVSRK1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FlOVSRK1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNzZC4CyNz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 18:59:14 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-372bdb942dbso2342957eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297552; x=1794902352; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HxK09xxN2287CuasdDaPYZTGt3qPRFw1gcuA14R7A5g=;
        b=FlOVSRK1ivKL4RTIldkY3BOSiYq0I4RgSQNR3SaN+x0VeX4G5IeoQa4HOYwwTg0R8H
         ARbDZWhK+mDIUZweGzhtefVF59mvXqaQkHyohN6w3SfYon63X+hd7Zk6lgrejANAQUOg
         jm2I8UegOq/mF/Et1tN59fW0phECgrtI+hpZDUwc9nRgVFzj/wtJX8jTkOFSAtI1RJQq
         vJ1qQ4i8NU2OQi2fC4kOBb+mX0X6u1gCd+xvw7gOCdSSgbBjsxpVLpj5s4wVy3c+9iry
         U8wb+zgMNUEfq0J0PbJSUyakwy1Y+7Ku3kMZFJHOphSQEJfrJBvjMhoOLz6olDYfUNb3
         9NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297552; x=1794902352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HxK09xxN2287CuasdDaPYZTGt3qPRFw1gcuA14R7A5g=;
        b=1C9GIeEGvQ9yrPtlFtthkaWQMlPvYGGjZV6jtGNPvWech1DEuquhv3ZYadz4Pk23rd
         XtIFe0BkSVDbOOmLnre2j3Pn4tQZio36HGYGFyWK+bcx4bwkI+iHY8Plk3YSq4BmtsCL
         Bpp/a29pAiJroQrqXM11GLN0lLed+oZ+3mYQnKiWDC9DaQtDYuBf8P/LcPcoCvc1z1qc
         QQyQU2h5dh2erAVYyERhE9HuRyKFjhCS8lqHkagEZI58gfthcdeqhAJHAQRT3tVz4EPC
         drstByQm5W6KoNwiL/syVsV6Eb9Q2FooRT8oKX58dlYRlI1EXtzFqNUkj0Tiboq40Msn
         Tvew==
X-Forwarded-Encrypted: i=1; AL+hErF4cdEPtBSsoPrsTT+g6AeT8CA+FVNrqOHkNE3lyG/Lmw9vG9UjDdWmHr/g9C4b3T+Yk963xDWCtGUwers=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/WYtQrCcRJV4SZNDcxQOoRoXh1h93r9aKd/D02aJ/2Fmlb8Y9D
	79IiB1gR/8AIWrkw4UvCL/yT9DWy4o9mVbrBahpOijqT9qXfWXGVoAWO
X-Gm-Gg: AYBFou21m/g4PnieqgXu9SA38UbF+he+Vdc7OYXzervEFVuZ8d0BIarpPedb6Bj8yrA
	6aOp5lVflrBlfe3ufZCelhqEFsS8RgiF5d5yw3/OxrQQ1mKtGQuioXN3K/UTLtCvpgkwLaDnDId
	qTzImpwbX/UxkkxdUvrZcJ5jEn7+jNCj3WKRvjxnEhPNRkelqVd++315fBApEmrqnw417YKaatH
	yx8o/vICDzGCjCIW6cuDuHyKgBkTJ5V4bemtbLur7yBYzaDa8YsK/QGX5PKOPYEMg+ivUyVz2m5
	grMbA8M2I8QpnJ/Arz1K8kr8aWS+cg1PAIEFkzlNkM3vkvAv+9CRdkFVzVdiVdP+ZyOuuk2CA9C
	ScxHK0tW4J7byI14gSFa9/IXjQLPkcOx5B4gTmyo7KoXMrXgVadh9RVu1iwnot4oIn5dacOqqXp
	MNhHlOs0ezV5e4B66uFZVW9XmPkuMR0vBnzTsFZOJJwPCFI45ESOVUNvtuuOb5UziH2J5W2TP1r
	GoMqgiMgNrzsovcAlU/py+9qNH6ivpmqREyeDj8w7IkCK7HJDXttvxDJnh72K1IgwK1uLR0lllG
	d4rmMjubzeDFLdaRNaOV8aGD9iKPB+pgwknRTChFpVe5JWnrbvRyqGtEogtQlAPkqZw8gEMZp9q
	tkwOEdnY4pgnZgqPL0NGjfXSE9FUlj8N/sA+JxipDLtxU
X-Received: by 2002:a05:693c:394b:b0:36c:49a7:86ac with SMTP id 5a478bee46e88-37520713cbamr2941577eec.37.1794297551590;
        Mon, 09 Nov 2026 23:59:11 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm4498321eec.3.2026.11.09.23.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:59:11 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/2] ASoC: fsl_sai: Improve error handling
Date: Tue, 10 Nov 2026 14:58:39 +0700
Message-ID: <20261110075841.12104-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series includes two follow-up changes for the FSL SAI driver,
covering hardware reset handling and dataline configuration
error reporting.

Complie-tested only.

Best regards,
Phuc

bui duc phuc (2):
  ASoC: fsl_sai: Make fsl_sai_reset_hw() return void
  ASoC: fsl_sai: Report dataline configuration read errors

 sound/soc/fsl/fsl_sai.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.43.0



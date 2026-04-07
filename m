Return-Path: <linuxppc-dev+bounces-19437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF76FEEF51
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYh24pyz2yps;
	Wed, 08 Apr 2026 00:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572328;
	cv=none; b=B2q4nEZPcNRZWf5STcXdVvMTg44Oik7J8To+iU9wbFn062D1lxbmWJjP65rPOu/87StvPoS1aFC9idttYTpJuRfEIF5zz4vLoK6EzEc/IZlzLKX2Vn9pojA1ugq7lYd//954hC+8FqGfjYOIHg8kIZrofiZpP5jvS5mU+ILuiNEoHKr3ady6t0baTgtz8h7R8s9ztPOP2h3MD5F0wuG8M57gDkCG9XeD24ggPMiChXDLorgFbslZ1UPc6bWsD2Mx7EMyU6dJ9YOV7N4Xq7UrZAMt0X6Ltb91mHjWb9I7wClhE1hgUgEVtw1SU8zr784uSYs4c1IcamYDJIql6wI25A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572328; c=relaxed/relaxed;
	bh=qgL4Qq7YZCy8/RvaSgFHNT5E42dfIeMN6C/f1hBgwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWq7E0Nisjoy4N2UyLLIoSOSrVVlEUKZ0fQJ3Udr8aoW986xNQXIfovYve6KSRJhrhmry//lY/fqxlAfaHM/j7lNp4st/8r0KR+QykWynm9LnFnluaKFZfGC3Mh4Pakys9vjoAbBg60ZZVmrpdghPqgfEG7sM5LOQ+DLIR/1aek/F3w6IhZq/rgxG6xNqgVzdsmbwSMeMGaBvQHIbIYBU/lCP/j2bzKlY1snWBrkI7GdhpM7HB7Mc3bt+0xjcwwWNAMBF1NoE7jVgoV9lSMO2uVnJMWD1frjlE0/GTqgjWL+fZkf6kLp0Ef56/7EHNFPqbOhI3/kiQ5XDu5dattpdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D/Ffg2Wf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D/Ffg2Wf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYg4kbqz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:07 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2aaed195901so22350515ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572325; x=1776177125; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgL4Qq7YZCy8/RvaSgFHNT5E42dfIeMN6C/f1hBgwoQ=;
        b=D/Ffg2Wf9CKewMjdvJklp1x75MSlPCwT9YjALrQwulkANB63Wl1Blecb+Rl6SJjJiU
         Y+Yjop2Ofc00J0vbMR/JW0goQ18b4HFfEb1wVHkQAfeW+eQPpxrYa+Jxv3+T1ehG9UVE
         OZ1qe2FrFucNtb0x831uYhk8nqcGYoG9J+RhgLIoqDQbvrNy5SdOGKKzmyX5ITHWeNvy
         HCtC/m3c8/arMsS5tDwK6VUymfV/Qym/zPnG2ENSGjF3PuY3ltJCUXAAYhJoKet+vuhc
         f4qqaBd8tNvxsG0H6K65RwtGUk7IuKhLRM36x5An7Xow11SlDeGqFZXoQi/opFFAGyP2
         8Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572325; x=1776177125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgL4Qq7YZCy8/RvaSgFHNT5E42dfIeMN6C/f1hBgwoQ=;
        b=qlRsVsz0v0pOuO9aAKLEwGIZ4orkEz+x9RxXIK+969xy1xIvho/4d8WrfWgcUyxSF9
         gk2PioY564GBW1ePup7RyeedDwM7/7xeYGubfSfhHncHM3uKdC2fa2Bw9mJx6A4BUw/P
         V/1RDWS16PxQ0njXTE0grQA8ub3BMYckZpd5yFuF4EUBmLtLkQIAQclNeNobRLDKzyhr
         UGnhl3gncN0Wtri5srQOJm9YxzlKctCfUXb9Xt7vKYwLCveY+zDOTCGWW0EIOudzIzk6
         tBB+DHqWm7ntgwP4K69a+M+rU70O/7Q23KuHDaRkQwBFw/LG3nmoqptTKYk2K/6gpsSn
         KT7Q==
X-Gm-Message-State: AOJu0Yyj5msFnDTR8bZoX24f/Ep8xEIf0tqHPQXk4Co7jHZP34abh8xl
	p/z6FsbpjP7ytTz2u7Bj/y8I1qh1+32q4rcTemS1Av4LrsXtBjryQ4nshyZjgw==
X-Gm-Gg: AeBDietqrUYsnvteOBPfDsPMJQIMRKo2etGo7Ww4HGHMwwlg7//ysgT6Iqnn7BrXdGz
	a4tgH6nZUNB0hznCeUTzkqzxgGYcB5dkd43DV195owcaxHFGlwBF23nqQAV+sm+QH1NlkB2UoZ4
	k3SPqZ9ESpLa3HLUGx0iIrY56GeVQ7a3KRW4YnAXyu6Ta1AUee5R/hCtpceqnnl/J7QRmwd9eTJ
	XVJBo1JCO1MNCLAXDMnwD3CTvcE5CjrEAtOV2leEsUFraU7kO1LWkWWlyYhOXNUREaGFBMMMbak
	iXTR4o+WDt9fdiDVKOwAXVu+R7D4b3J2z7ebDjhhP8jC4YmGQG3+cKEcf0BicIgyX/8vomL7D9r
	xQA1vD98EiB/OUQjaGPfxoCwa7wk6zZKat0P4JCAa5FdKsMPMsnhApl3q5a0cXEI2kuTrtA7mHv
	lNhJCCF0AcqL9AiKIzOGvrj3PBHXZGJ+ZFPoNko6cXuUVTc+ju3A==
X-Received: by 2002:a17:903:2f08:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b2817159bdmr182384625ad.10.1775572325101;
        Tue, 07 Apr 2026 07:32:05 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.32.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:04 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 2/6] pseries/papr-hvpipe: Fix the usage of copy_to_user()
Date: Tue,  7 Apr 2026 20:01:36 +0530
Message-ID: <7e618bc382608acc390054786e3119db2856822b.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
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

copy_to_user() return bytes_not_copied to the user buffer. If there was
an error writing bytes into the user buffer, i.e. if copy_to_user
returns a non-zero value, then we simply return -EFAULT from the
->read() call.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index ef10f5a5a4fa..fffebbae113c 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -206,10 +206,11 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 					bytes_written, size);
 				bytes_written = size;
 			}
-			ret = copy_to_user(buf,
+			if (copy_to_user(buf,
 					rtas_work_area_raw_buf(work_area),
-					bytes_written);
-			if (!ret)
+					bytes_written))
+				ret = -EFAULT;
+			else
 				ret = bytes_written;
 		}
 	} else {
@@ -376,7 +377,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	ret = copy_to_user(buf, &hdr, HVPIPE_HDR_LEN);
 	if (ret)
-		return ret;
+		return -EFAULT;
 
 	/*
 	 * Message event has payload, so get the payload with
-- 
2.39.5



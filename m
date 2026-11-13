Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C4606A886
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJx0NFw2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQxTT4qLPz2xwN;
	Fri, 13 Nov 2026 23:31:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794573117;
	cv=none; b=R4gNPSoboAgUQovDdzRMxwPEc/jrCkfni91f3eOYQdsKi2xsRWSSCOUyykEBnZtonFahHeW3eobZwslNmz8xPNuDkS9Jdeq7B9FPAPtoOiQugsM8kqyK/SVRnajyYGm2/2N7Mf6mV41q2gwwb+9VXjySGCmNrdn5Aqcr+yTHVm/7a9FM9FQflbQZKJ2PAMjJQxwEKL8pLDYnM0sBn0dGBqVwDYJRRHsOrMekWhrS1AMMSGJ6FpVjjTpfsvx3AOEx9ORqAnep+J+oqA8176nTdrMezxqnrAbyGKqXFkD6EhyF5Zy1RWGZMBnsboKFA7JQCML6jz68BcQ02fhL6o3C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794573117; c=relaxed/relaxed;
	bh=h57GRlCyH5Qwzw7Fjj7aWeliQUGBEVr9VFDUhDmpCbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqTQGFHYfiEj4IQGr3egMwqnFwu52W94L44lEBriexZE99FGgNrZbassZ20yIQtQlSJnyrnp4zTGaQgyYczt6yQmmHJn72GWCd+ihE5SvLQz/2yjLIE8TyRTUYUcayDmeNTaDiIu+o+8ZFusCngzfM4fHUaLdnuOCFMZqgaqyY8ZM3ERw4h1ajVUH6Y/d+67jClIjM9VMiR1ExGEX9Wv7eAUt5vNdRfAMVN03rc4s7JCiEJi+0sv0oodECB8njsuj6WaaREd1JHghuj2/lmTxAy+JrKYyhSi5s1y1mr+H/poilpOZjEyLlZXnWvzI2zGPKsQYxPcbsTphV/nwYMk1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJx0NFw2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJx0NFw2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQxTS3FNJz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:31:55 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-372bdb942dbso991738eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794573113; x=1795177913; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h57GRlCyH5Qwzw7Fjj7aWeliQUGBEVr9VFDUhDmpCbw=;
        b=FJx0NFw2IC4g2TrhIeyNYN7d1FXqvuj3We8+i2tfFXHTztrMQq1WufijDJJacoU4yf
         0BsPt91Xb3W8gUVcACRZ+/W8cX2JsNfPW8aswzAgn3VHChf3SZtZYMAZlwbJyQzg5MzI
         U0o44RJpa1ks/ZBZIHhvs4tga58QGpsIYNZ55zD67txw2b2yEzf1uAZYXBb3I9bu1fOS
         zNpbs9r2i0RNNfCsSKEeoCf5VTGcHrO3co7G7M2NzIKrdYw9JYAZXhFRGqqoy/kVOCLj
         ylblbV2DOjOSqewtXbtrjIQQh2ZbxdijMRDIchqs3vY9oMwrTAqN+IjS0HvMVjmbQ7u0
         CQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573113; x=1795177913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h57GRlCyH5Qwzw7Fjj7aWeliQUGBEVr9VFDUhDmpCbw=;
        b=NgGTdcXm7FyMmG35WRfxRmSxGm+DPdOlP47NaBmivSAJlhTWZYDtqQFs49Dkexow74
         jiCgulL+id1CObY0Px8EvcoNL7dg7OvCVNwplse/F9STXxR0PAFv7FwHSfEJmrFS4NX/
         whSnrVou+7VMi5EYKy7J93gZhJcvzvvEaXDSd03lhnhSSZRqjicYOkzeMz66e55PJKWL
         7mVgkQqlJbxvimvIOfwWLzOhcOr0jPEVXACpjuzDlwElsFMsj7bziURzeAh0UtzFOi9f
         dCXSkr3Qlvv/wDgzKDgETgb0r5QD24ukp1KjXkA/VV9z4Seu1qHC/cZ2A8d8ZUF2g6sp
         Porw==
X-Gm-Message-State: APuU4Z/IFgIzFCl0Hu66nsHUsFKVjF17ZgI2JkpoKe7qylAMZsqijBpm
	gaLT7U9cyd40HsZtizG2XZoHBbQ/stSgnE64rcOz7StKRO+iVL8W1c8FA2oxxw==
X-Gm-Gg: AYBFou1c3L8/osmdp7nIWGrnxXgR6YUDZJLsN7QBAAmVbr8trjfClOBXcYZZRBxxgLa
	jYbuL3haJJZTjxcrYhw8fgcYgRojM/xOGWRHgytEVAtHG+SYLFRSKNTjN1C0iQ1euJwBCGMLn+u
	aem5bc7Q454X3aAYEWxBFW0kwXOV4MA6WDPZvKuUgZvYdC29JsnU70jBm8JdW1Wsv/amvfk99We
	sVOXi8qChiEH2NXW1vPFCqJUn9KXz/FtIR5ms0gqF7ex3qYNCIPO5q5Lznu+SiYYn7FB/HSM7Eb
	APVag1O2G8eXc2Ocg4ijxQ7ep7TCsLL7lbzqWicXQRmZULjsWIlZQvsgdWrrsooHAJdcsAvv382
	4vVjcKihxNqMAbWRwXoH1AYGPBejfphCOg4wdp4jb0UAnFLiEE/Fwm1H5JDV18WVcHknJ1nF6tQ
	7Xe8+iRcpuiyNU9pU58whTjrDNdfb4zRmyv9rTX0ROXW0DLhh+mrt+O9+tTNfBjqJ9apCCxYwWh
	5SpKJwPJerzXa2poVDmrTO1PoxTv+bY8NesETMF65JGSNgyoY9OOBEgTH8uqKFOhd5Of1Js5FyJ
	iQnts1u9cz7fj9gI21RykwcyPZ/OxdMmdQ==
X-Received: by 2002:a05:693c:8206:b0:36f:f3b7:6dee with SMTP id 5a478bee46e88-37966e3ab88mr2258546eec.7.1794573113194;
        Fri, 13 Nov 2026 04:31:53 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm7215936eec.10.2026.11.13.04.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:31:48 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 0/3] powerpc: kprobes insn page fixes
Date: Fri, 13 Nov 2026 18:01:35 +0530
Message-Id: <cover.1794572365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Hi All,

A few fixes that came out of looking at a W+X warning at boot with
KPROBES=y and MODULES=n.

- Patch-1 fixes that warning.
- Patch-2 (reported by Sashiko) fixes an oops on book3s/32 when a kprobe has to
  single step an instruction out of line, the insn page was in an NX segment.
- Patch-3 makes ptdump show "X" for kernel mappings on e500, which was noticed
  while testing the other two.

Ritesh Harjani (IBM) (3):
  powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
  powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
  powerpc/ptdump: Show the exec flag of kernel mappings on e500

 arch/powerpc/mm/mem.c           | 12 +++++++++---
 arch/powerpc/mm/ptdump/shared.c |  6 +++---
 2 files changed, 12 insertions(+), 6 deletions(-)

--
2.39.5



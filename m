Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5140606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZidMebF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP7Cb2WfPz30gp;
	Wed, 11 Nov 2026 00:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794318219;
	cv=none; b=ESAoyiX0cUgiqhOuCEa7TTmczDoNBvuqTIhOlaNerTbkt8YWoLeVt95/ITPc5gnYhNqTZAb+Z/qidljLvJj49NGDYqhm8BDhMCY+TxZJGGb5FmAkMV1R3LM3BjpBAMNaXPHM5wsYF+S96nyvt2NNtqw3c9XKLfOk+KNsX3La7b7HgiV3ydqx+Eofgl2xz4nMoV/ABgepTogzsJyJvAJvW+SWHR4UcwIn6ORP8kc5lIkx/rFgxkV1C6L+M+QAprCEAxmi7+DTx8kHwEJ8Vs7m6R00MbfiX4WVEdYztJ2yaYTYm4lzmGe1sVAr/3xBS9Ntgp9wy/5y8LlNg4aLGjOvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794318219; c=relaxed/relaxed;
	bh=SF0VorXBRqQHhsbCyIkGXlS2ClFfeF3LBlFw4KZVLng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5+88q4gx2h6fn9TbqKg/xug7du+G19ff7WABxs9qC/QckwBKiLRIFbQ1c62PxBmMPXWlE7r5gjwBLybwKDnnyh4iPgcmhrnfeD/u7NuBLMJ/71V2cs/yNakrTDfqdqe2reAmfjPDvZIFmfDMj6/8RiAbrg1T7qEbzmXVuuOgyVTenBHVRXDJh+Di2qrps8E1T+Googb/Zv8EAAmRhGnJbC3eoBRnaEJ7EpqGobdrqLLU354O1HZqw6XNSL23uapyFh9jeQXrnaEMVkcPME9PJtBZm0JnE52gA7bFEW+9BtT82fFzzrlR4pCK0aC6p7oj0NpX17tic0AqSQBPJXsug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZidMebF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZidMebF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com [IPv6:2607:f8b0:4864:20::1232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP7CZ0jTkz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 00:43:37 +1100 (AEDT)
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so1963091c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318215; x=1794923015; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SF0VorXBRqQHhsbCyIkGXlS2ClFfeF3LBlFw4KZVLng=;
        b=TZidMebFFWV8Cew0musAxMYxWYhLcK0AE1pTRq4GhB1FjP3CMeiG7fOPTR3+BKyB+S
         VrEtO+JQ0LaZOddJuUGJhVZY3yINmhfN6JKOO5bZPsEWcle/ZP/7EboeXM6HOLIYaa8t
         GZdcih2QuDeiVxZltUC5gL/aNnG56SUfSfCwjX/XkPkcEKqM4RYdCtW3VG93XD4oEjCY
         9O2XJJH9sP+xkoeUMp2a28rH+ujU9Q+Jo9QkTeD7qVAoOk1gHIPe5WGjob6MJDzsKhKv
         0s/Y1tA9Bn3rtt/2ZKhQJOZcIGn+jRD6fQ9EQ1kWG7pJeGbTbL0hpjd/ki0KFh3JsCkF
         XT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318215; x=1794923015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF0VorXBRqQHhsbCyIkGXlS2ClFfeF3LBlFw4KZVLng=;
        b=CgRFiwpNXCzn6vMX1P08lI3PQ3pq/NXocZlZp2VoKD0sqqMbyUGx2iWUMtalQTpfcJ
         mMpoTM+Akc98hRPL9ETcQfjF/Ld1Ks/Wjz0qjbZ8ZjCHY6CqOd57FXqaUebB29OtxoBZ
         bYZd09ffEssBlK7R7IyUSJsZj+gGdN1a3EceQ3YsWhMGIZZNtIvyT+amOE3Z+ln+kBQ5
         As6bAFBrnwYvgh03hWu6/mtEmHu+nFgNtta2tObBcASNWVX+Yy+XHz9sh0EGE9cueOWL
         qa1ptcdOBexCDkWujUtvIS9EHHoI+0jcuTWakY0Fzg81dJifWf536eO0Cc78WCl82LQr
         n85A==
X-Gm-Message-State: APuU4Z9hszmoElpUIB89MtxxWko3c/KAMS5EGfFkM/iAGKWH36anQLE1
	m55kqK1tjyAx0WlRvQzofI0XM9YjKjjIoQbUdvNYHqpI9H2Z3c1ohVrL188Es3P/
X-Gm-Gg: AYBFou2TiJm3SYckcUYXgK9121mc7zP1aoAWkjMfSW1jItZYAUiK03HRl9jMHC6LjLR
	fddzIVUXsxx+1y+YsqFRLo3DvbW0tCXviIcHa06UAtAn4A1STNkiqvd92TGi9LfSa3NsBi0WgTz
	mnMSKQVUt7YeIghMSVqbfmv/ixvahjEs8IGKc/m6lTa9Kpe8dA8rfKAnphYfxw8JAm21C17TDK3
	sitJ6zFlvGNcrb2myAxp74cnYpUFhRYaOh+cbP8hgwHHfjNqJx/x7pTWYJ5CZENOffG+s/57yLH
	bfhOBdn3phad1MZMq+piubsBP+NRmgbxy8NBNiqxCdsOvCszGrte23aDwoftrQ6+X9azsGsz8Da
	L+AnJhou4ArPAmeJvS5FEn21MCGmafln+eQAzOsMsI27YHPSArdsdW6eBSwrxZY99941XQERotR
	jW7iCKR87Iy5o9zmB3MaCVlQDCyWxT0wH2bRM/pAX7rH09zta8Y/zwGxWwtzL5qDiRYQBGoR15U
	Kxx+4a8DEbwxapjHTNRn74bBcwxCxZedom/CtXDOjRsWU8X/WFTC/IZeqIjnkRFExqLiKzNQbSY
	PqCmI26RxeW2EZf6g+XE12V0/F3/ggkdbg==
X-Received: by 2002:a05:7022:458e:b0:1b3:b131:6a22 with SMTP id a92af1059eb24-1b3b5fcdbefmr5046056c88.7.1794318214706;
        Tue, 10 Nov 2026 05:43:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm7500065eec.6.2026.11.10.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:43:34 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] powerpc/smp: Handle missing ibm,thread-groups in parse_thread_groups()
Date: Tue, 10 Nov 2026 19:13:24 +0530
Message-Id: <39282c731de90f47678952e471236ef22e9d4b15.1794317777.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Power systems can have ibm,thread-groups properly absent like in one of
the PowerNV Power9 boxes where there was a warning splat reported on
7.4-rc2:

  WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1a0, CPU#124: swapper/124/1
  ...
  Call Trace:
   __kmalloc_noprof+0x490/0x690
   _kzalloc_noprof.constprop.0+0x1c/0x7c
   init_thread_group_cache_map+0xd0/0x2d4
   smp_prepare_cpus+0x2bc/0x484
   kernel_init_freeable+0x168/0x3c4
   kernel_init+0x34/0x1ac

This happens because today we don't check for whether the properly is
present or not and directly pass the return value of
of_property_count_u32_elems(), to the allocator.

This went unnoticed because earlier kcalloc() caught the overflow due to
check_mul_overflow() check and returned NULL.
But since commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
conversions") switched this call to kzalloc_objs(), size_mul() saturates
the size to SIZE_MAX instead and we now get a warning at boot.

Bail out early if the property is missing or empty. Follow the return
value as documented in kernel doc of parse_thread_groups() function.

Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7a25eaa59e62..9a0f63e43821 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -824,6 +824,10 @@ static int parse_thread_groups(struct device_node *dn,
 	int i = 0;

 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
+	if (count < 0)
+		return count;
+	if (!count)
+		return -ENODATA;
 	thread_group_array = kzalloc_objs(u32, count);
 	if (!thread_group_array)
 		return -ENOMEM;
--
2.39.5



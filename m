Return-Path: <linuxppc-dev+bounces-26652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F255C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 06:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdd6Y49NVz2yvX;
	Mon, 07 Sep 2026 16:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788763941;
	cv=none; b=irujuv/ux1qTFEG3bXvp01y9tlaumR6yJiV+gfxa6azM1+LDkFHRkEMig31cOhA/rnZIUwQw9gDyJJCs42c1Qa/IsrHsWWjRo+3wCrYywqghaUuYcNv3ZHcC7jyTnVCBAqZVxDJwVUMlHROegb6JSDKZrPZfwVxg61+eaTd3HKRV2tuY7u0ZZFk2VGBQ2yGxFuzFuUReZjX3Yu+pNWRKkKGk/PrzCu26oGUzZi0j3hBKzXxCQDLxYydVo82+AIY2eyA6Y+9YM6XF5BBsgk5gAyPdTw7SeJwDbdfQLvGJo7nHKWUqTadu10tESAAWge5V9Lh93p0sHROjfTnQrDe8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788763941; c=relaxed/relaxed;
	bh=0keQuQDh3GWYquu5tDAaSwyIzlXxpUqzOXBgn/Zoyak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f010VTWdeQj/A7/0H5G4Y3CabCxSd00MUax++XsQhoNQiB6CC1yY3ZIB7bYDhMBYe9aYdgpHadS/YW2fmaNX2P0Idf/1tCFbx8L02uGoVaOESyto2ShHUSLjyQ9kpti2voev+dPAzmrxL+HzJWlgY0DV0bliVeAIIvdffdzl11Ainc4Ymw1UqQI1jzMERnvWtOqByLWK88R6x8dvP9xlknYVNEpPJCTaOOtp3OKdezry9elfS4lsrelxwlzn4ZUd7/t5kVCD03N57Q2lgPS+sZx1BKH51FTG8IjwMe9hPBubqA/BqCSwYB+N4Ut9m4qYZ0n4rHXrWfg3t21zt/PtTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CM8aRa2o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CM8aRa2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdd6X5KCgz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 16:52:20 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so3300303a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763938; x=1789368738; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0keQuQDh3GWYquu5tDAaSwyIzlXxpUqzOXBgn/Zoyak=;
        b=CM8aRa2oVcYDzJLAWFYGrm6/soiNWnJTbD2CXgnu5akuyyvPawcBLra1hCZBXghmZ3
         DNnslIqedEDa6rArGmxhRWgDlhcDlGk2WZ7moyUWLkZUeJUFzYWYuRUTiQCo2PmGEt7J
         5m29+T5FvIRMRFKkM0ngdDQ2aER6kOOt2yRphRKs6FLB4HXaGf2CWYYPbGi19Gohhw2j
         C9DOA5cjE4cwMAfSgRAjxdF15nYU9dokeC7UCK/Nc4kN8e4i7Oe8N6Dt0JtcONL52n5J
         nyrlrzNRXdTAZfiqQo0M50+WdQZPDAfDvcdS6eAT3FXpCUN99yLVB7QmmPEZ6sJUQ0Qo
         Prog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763938; x=1789368738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0keQuQDh3GWYquu5tDAaSwyIzlXxpUqzOXBgn/Zoyak=;
        b=kEi32nvBQFMok3p8v1pII1/5ZzOgTuxJYNy8Hhdf3VCbo69mByC6fwlkJrvH3MJKt3
         aMSq6Lp9Eb/jli/N2fJiAjWUjJDngyxVJqOB4x+YonQEoPavX7EzhkZ8IHFj+nEvSST+
         QxMh2v1HnVTCmPoQlT9RWTq//P9YNKmq2iYHnnTBFHRnW4MmA2IfYV0wZMMT1bN+soKL
         kSqscyrq4BfE8Drm3U9v4U5j21GrVQUqR2e0bZwdOLi0LkecK4Sp21fRh4ZcjbWPrUEu
         ZMyOphK2FRPpQrsLXylpElozKX6Fwp+mp1RRowDQ+4nWYWgGiFo+fumX0/3lUGHo4wLU
         adEg==
X-Gm-Message-State: AFuF++kHGbcJFmC3Xe6rf1NjgiXx/etpNKFh+R4fbPqmpJAoEthIylDa
	caPygKEJD14ZIjiPeX2e7KhpPuk1PFuplRoUKlVyKEY4ANFgd9dstXZ4
X-Gm-Gg: AYBFou06AoJCOZx3MtDuTyMUvqOmTiUfevzRMdmSSRB5jEgXExz9zRUvRJMAqOR//Zh
	M2GVANNPUAKsIRl0VPk6Ct3p10YaVyzK5LpdE/i4dKPPZTCtwJl8HrOIWrlH7yheh9mWhFWmrvz
	d1CIShGcMAQrcCYsowuVupXTAvzmziAVtSZsH41XTAYK1IbuUXfWFZUZU+SMXc5dfFcyIRcFLQm
	cwZF4sDCJY2Wj8me6hkaF7Wjz6Wy2P7KFnNFmqcvHdN38ufGiOcWXf5TpmJKbSpdpSNu5VVLc/t
	vlgYn8D2TzOJQfDmrJbf41bJpiJa+6bxdka+ifhscNivueBfviJv3/BHE1/3MybGxLFB//jx9ah
	X4j0PKwZ1GggKVhl9M9cO2SH6fKUyI7nAU36sydVo/+VDBBrcL6gNsTaOzdJyNZFJHPztn1XYOE
	2o8p8MdApUTA1+dRti5j+DfikiTm2RptFbyUJZvVwl1XyDbW7MNkiJXBCr+6aWdXrVfRQ3q243H
	g15KYVMFZmjuIPCi8c2OfbV
X-Received: by 2002:a05:6a21:15cf:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3da39b57e15mr33996691637.4.1788763938332;
        Sun, 06 Sep 2026 23:52:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm28825941eec.21.2026.09.06.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:52:17 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] powerpc: fix repeated words in comments
Date: Mon,  7 Sep 2026 12:21:53 +0530
Message-ID: <20260907065153.33578-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907065153.33578-1-hemanth.selam@gmail.com>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
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

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/kernel/paca.c             | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0e263b97e016..2e0c5bac250d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -101,7 +101,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long limit,
 /*
  * See asm/lppaca.h for more detail.
  *
- * lppaca structures must must be 1kB in size, L1 cache line aligned,
+ * lppaca structures must be 1kB in size, L1 cache line aligned,
  * and not cross 4kB boundary. A 1kB size and 1kB alignment will satisfy
  * these requirements.
  */
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index c3fa539a9898..c2486b43c5cc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -384,7 +384,7 @@ int xics_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	 * the corresponding descriptor bits mind you but those will in turn
 	 * affect the resend function when re-enabling an edge interrupt.
 	 *
-	 * Set set the default to edge as explained in map().
+	 * Set the default to edge as explained in map().
 	 */
 	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_EDGE_RISING;


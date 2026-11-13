Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1E606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSq3ma8t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQxTk08h6z3bdD;
	Fri, 13 Nov 2026 23:32:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794573129;
	cv=none; b=Rphm7xtleXD40ivUaXUhYFNbFmMQnaDcus6/s7dHFTv+tNFdYbzsI6G8bTYypZSXruj83zuG0CwEaPzB7KJqikHNPlwWl6RVd1ld7EKgif3QbIZQrj/znvV4bAVhGIduj49ixdzFyRIopoRuR6gRoALVgP7vUmHuGDO13ki+jCIvY+F8L8flrrpfJD2TuFNDlZhM5RsdhfMUwDFQn6ZCFGluC8GKVFpScQ4DMP2PvM3UtYF9UahVc9UzZ5perlyLIH2qDw0havbgiA4J9g4G6790PtFwhII9RwKCqcvZtRCworFuBAt5A0mYHGVce9kGM+MyvdAApef4vjkOCS7NdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794573129; c=relaxed/relaxed;
	bh=9Tz7d94H+7yGZeyFtk8/ghp9+AIhmI2e9QWMgoSN7Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HM8SJ4MyUJJO4bZr68sastX7mCY72KewHDPkBzLcEgn5oNNMCcUUkmvYgquwJ0MlLEaBGKFK/j8CUqYjCpZKF2F+V2ZnfdXp+TN5RdJheVCjCcyM/NVdTF6Rc7Zck2n6W8FpE4UgsiVNgYm7e60kC2PnvYp8hAhgA+Wbywq3GKYDlWmuX/Jb2LlF4bsOqJLHq5lkpZwaUTVmayUGHQo/5S+5JXhou8osDL8hOXj+4ryIL0L0aLvcJ3f3Ah72ncO4INWA4B0j7d/TxCHbOw030vQnzCn8QlMWTn53M9MmQtzpoh3KxpmkP2j2U4j6Oxon5HPMRr/S6Ub91wLy3eTObw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSq3ma8t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSq3ma8t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQxTj21fzz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:32:09 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1747004eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794573127; x=1795177927; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Tz7d94H+7yGZeyFtk8/ghp9+AIhmI2e9QWMgoSN7Y0=;
        b=tSq3ma8t60VuchDFaHaqPCmyoQjMRQTXVgQq10vI9qOf9y+IPQCeCZAKkXopQa/bbH
         9jDusk9+wBXIs94zQSh4TXdoiIZhJOT56M2X51P2u9tXZQ67IWnGEnU4GMCEkW65NIgY
         M0avfZLwbVLBOlWWB6vuN4pPuK1e2OrjmyCZ2y1bFTQS1MtTyqeyi4r4rr97wBQdwWSE
         WDg7BYJOtLgDYkdUFXTofiW0WpNDP4/HwZGJhuMmLLf4xd+V6ipdwQQ5MCIXwmHZuiTS
         lM8gnRTO5WHQi5qmGFNM6UBgPmYDdJxMStt3ZHjZLJXYpBKq2lqe/m8onJfKwgLEjxzp
         ztrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573127; x=1795177927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Tz7d94H+7yGZeyFtk8/ghp9+AIhmI2e9QWMgoSN7Y0=;
        b=VLxgGzKhciJ8SqN8zecvkD22qeCCgzh0GDr/Lp8i6G0/SEwhUPP4DSgsGe6C6bLxYj
         S+B+OWdXTRUxZg4OUnDBwwchA6Eva+IN+Bw37iMoDGZ5wpEAMGjbOIhTya8huCs18uJl
         wqgAIG31m3w/bxkLHDEp1ZX5yJM7oRdepKeDjeKh5dDs4frxwN0nQqnrT9JPZ8yR5GYn
         clEgiSRmIb7Xt/qFuTaMdJdAUeZJmsy4zVthUKlfXW7lJoP9K50s6ikquiEHQhOYfcO6
         7IY+rKE+O4nM06MCQIzNMOHoE0bSd8CWTRsoJIuvqnl5+E9RZ21BpiUlonYJrIgYjbIs
         uhEw==
X-Gm-Message-State: APuU4Z8wYfA3gqzK8giHplMYN5ahxfvURtRwzOz1TBR65hYWXMg8LnsW
	1uW96US7K3puy9LjgvWkMtC4xddOVAKB8VjGq5ccAJussgzU+NTmiHpzaQ1B4A==
X-Gm-Gg: AYBFou1f1w4KnGHe2fXk83Exh2QOVXA9KzchbeXtXkP8P2N6MC7tcl56J+SfeZWXN0M
	iyZhxKwBI0K9Jnlvi9fiSlR23ADlbDLj66N2lyrH4tFOPLMxqHriRL7PkqK/S4o4carFAf1yssR
	WERe9dscsSZhJrXDuz+uqIUsXdy/kMghiWk7D65XAFw+pko/sNe9AbzlYtECok+jKoPy8sl3Co+
	ZBxU5lzMVyiykE1Ul+EhdoL25qEqvbnmsaWblHmY/GR1Hav+rsM+2ZMiLBkJaYjS28tvUQUJ8Yh
	LRqkk3yyOJOa/CUtFjA17fijjS01ZB66DApfAvwPYB28KNnmJ2/BAhxHPBZqqfx0CcCfckAOecg
	xfX2dRm1g1BzAPjTAT7A44CcrVlpQFET3XY3VQo+T9wQiR/iI/k4wd0tzx/ses9oH+r3orJR3zW
	g38S9dqyI2muXw8hVkG0yZxZGycIrTgJ9um1Zxfp0bMYCGOD2HGWRtQiwI8TiHRMjMTB8vXCbty
	JTu2JGUQ2iIxsbImn9e4mSUCXbz0gxmdgyce78eJFntxCuxt1lUYfY9cdCP8yI9n1aaojUTxpf7
	b6s0aTOKSy0x8hVZyhv72cA4EKG7BipxQA==
X-Received: by 2002:a05:7300:d58a:b0:376:feb:2df3 with SMTP id 5a478bee46e88-37966766dc0mr2197550eec.20.1794573127145;
        Fri, 13 Nov 2026 04:32:07 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm7215936eec.10.2026.11.13.04.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:32:06 -0800 (PST)
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
Subject: [PATCHv2 3/3] powerpc/ptdump: Show the exec flag of kernel mappings on e500
Date: Fri, 13 Nov 2026 18:01:38 +0530
Message-Id: <074831f06e18d1b8cff91e7588aa7985077dd538.1794572365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794572365.git.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com>
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

On e500, _PAGE_EXEC is made of two bits, _PAGE_BAP_SX and _PAGE_BAP_UX,
and a kernel mapping only has _PAGE_BAP_SX (supervisor bit). The flag
table requires all the bits of the mask to be set to print "X", so
kernel_page_tables never shows a kernel mapping as executable:

w/o this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r          present  coherent                  accessed

Print "X" when any of the bits is set the same way it is done for
_PAGE_READ and _PAGE_WRITE:

with this patch:
  0xf1015000-0xf1015fff  0x00000000         4K PTE   r      X   present  coherent                  accessed

This only changes what is displayed. ptdump_check_wx() uses pte_exec()
which already tests for either of the bits.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/ptdump/shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index edc69da19b85..e28a41a8b1ac 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -22,9 +22,9 @@ static const struct flag_info flag_array[] = {
 		.clear	= "w",
 	}, {
 		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
+		.val	= 0,
+		.set	= "   ",
+		.clear	= " X ",
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
--
2.39.5



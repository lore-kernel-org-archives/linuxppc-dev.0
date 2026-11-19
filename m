Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D760A260C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyVRBZrb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPP21jGLz2yNj;
	Thu, 19 Nov 2026 14:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059606;
	cv=none; b=PrF7N9gSyspcnovgpYzpEgHEhn4KQEES6Mar3JWmiuxkA/qNcfbPCMc7x7QqFxftb4k9ihcev4OFijqVy9l5oMGgAF4VwlXROknakcsm4nN4B/eSyWR3PssDI83JVw/P8IkIDnx7Y9MG4DbgOfP2SCxAEAaUeT6Q1c8SgBgdQ/RpVyMKquqCWtSEAgUytOlIwC7drvSv967QAUjfl4rMS+W/9CGO7YZZAF2pgGztJlKaK2qOG0PGeQ0z1vnfI1h/Sjc+4ztLW0iqohk6VESiK67TI+ZEIUoDw3CwDkSbMkLhb6R1oRt/msGW8I20AxGA6mUpZ7QO2f2a78VU244EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059606; c=relaxed/relaxed;
	bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXBVoOdgv0Vcm1PpztAUp9Mhmvh8jqHF/egtVFkzoIU5NqcPAVTqNQB4pY/SXCcVXxFjI+ALNMaaLXvrEveKH4zJMh5K/C1ar78Z8Zs1nMs0BH6kS++UMbfnWfQwm3Tk9EtWCehnYPDE80C/cTBlAWkjgfx6+MJLhVIQTsqEMK6W8WAeHHDX8o04gZdlqOG9eTKe9VuPbzwINow5CuqOrO34SVE7wB2ebEPtku5OKRPkxS0rsNyApKuHPkLJAYTBvmGMs7XAcqF5jVU7Hr30pkhXmLSByPSPSYWvlQoKKvbOaOQOukb1PCBYSkIKdGBWOL3YyIwxyNkFtUu3cbfe1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyVRBZrb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyVRBZrb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPP13jZcz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:05 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4099050eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059604; x=1795664404; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=YyVRBZrby5rT85vZRc1b1sEMQ7HYpNiDmjydznJMuDsFIKVY0UvDBYOa5nZUoTBJb8
         NYDlKxLpd7yLAbKejMvJn7fWv0Xy26XFVnaCTnaOMINBxWHBsPDMoJLcdHp1m4P9Qz6j
         8au0GHt/We9o59XD9RjwD/eAsRBJ6s//oDc7Su9Z9Y1cDrBp5xyjaOIGj4+brPmFjlQJ
         Hh44yhRatDWcLjxtcxZCF9qhjVLU5iG88Q7Y5zkXwYuBdH1FHgdrs/c2OcdpMMRbv8KH
         Ty9W4TS+5T8zJDurKmKbQGlFo5LDNoA4MrWa1koFoxEi6vSecA/3Q+hEpP83EocIKXGV
         bSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059604; x=1795664404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=BsTlk2mFIkfHjpzOZUixfqaxqn/cetKLygbngzSv8SHFqf5SgD6RiOKxTBFg71aNYp
         34PEW/AmqvhdHS5osUPzcTwaBvZkB6JBkq5YQJYYDACEGFXE5iDyTHkkfGaKkmeulhlJ
         0azwE5+99JtRNADdAS3RiHvVxmX7f7y0Bcccjjvoe8Coha+2vuBIKdoJCr0IsHRzRzSr
         Omh1SQUqzx7XMoiEjigb8HDgKP8lLI3rzjGj+nBWuEB8oMP93a63/aRHqunUIHXc/lVr
         rtoOHWpGBKepWYzGxHOb6oRUtZyM9NPaHWSgQf+catDdgHMJ9QzWjqV7CkdjP6FuIz84
         Pq/w==
X-Gm-Message-State: APuU4Z8u3mpMEpTZOvH2oB+p7UZafzsBQBj4p0fC0ip/JF/NRi0qVn6G
	MXUdYwn+o0E2yOCWk7KWsbel20XEK5F6AzQ/vtpz/+CPZ72LXHGJqXcrQ4QjmQ==
X-Gm-Gg: AZFdTZfYxerIrcOrr8gk2+yQtr1bCxCvzdsKjoQ9A3FB8rRJdQC94FzsTGFocBWmA+q
	Ohehs+CSCzkVL7ShqITtO+iEuge+OuPDNPNJPts1q+EKIsRe/lvDMUwlDJO8xl98vuqMQiKjxtu
	GKL3Bh0gpMKLF/iTyg6Mf7zfuM0sz2VoHY9n2o9KJJcIdz+5qI9uyBY65Vuzhef21J7VLHq0Z/u
	zsyLLacky9DjXtU0INI9X2/kOto6JxB1XboT1p/OPdSLxjdphv7fitEbMLFvtr9H2TfsPFUKTRI
	/oyvgcejPrnl+fK/a+Hk/3aNMJU6w7dasKh4W57dLCtvXYhUd3emcYwlfFIe07zi8KoIb3uiDM2
	2pUmW33dw/h6JqG5VHUymJi6JDtsfH/4DRgN6Wah0svSxwPXIcio68qNGdBMz4BBscbDQ7M5/gE
	SdPsJKT7+Vd5icbJOB9sb+4Uyq/YAuVHAiOXEzXd9Y+a+6DSHV6A9bj/ltvq3vOOCJVhxOFIAFW
	matqXb1Y56ZygaMl0Dun1q1HR7UYuQrbaWNvHZ/gFavD3FEav1jAa93mnHCMoz9aMCo1MvmMPC7
	RsHdGUhvC1F7CP45DcFGX2dUV7FEX1po5A==
X-Received: by 2002:a05:7300:6da2:b0:380:d99d:ce1d with SMTP id 5a478bee46e88-3828016fed0mr5982804eec.15.1795059603644;
        Wed, 18 Nov 2026 19:40:03 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:02 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 09/18] powerpc/pseries: Rework hash flush to remove conditional locking
Date: Thu, 19 Nov 2026 09:09:04 +0530
Message-Id: <10471bc512382a2cff1284adb191d738efb63ca1.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in pSeries_lpar_flush_hash_range().

This also simplifies the function definition in my opinion - so this
is also a win.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index abd77c45cbf4..5dbf447d3a83 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1526,28 +1526,19 @@ void __init pseries_lpar_read_hblkrm_characteristics(void)
 					bpsize, idx, hblkrm_size[bpsize][idx]);
 }
 
-/*
- * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
- * lock.
- */
-static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range_unlocked(unsigned long number, int local)
 {
 	unsigned long vpn;
 	unsigned long i, pix, rc;
-	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	unsigned long index, shift, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
-	if (lock_tlbie)
-		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
-
 	if (is_supported_hlbkrm(batch->psize, batch->psize)) {
 		do_block_remove(number, batch, param);
-		goto out;
+		return;
 	}
 
 	psize = batch->psize;
@@ -1587,10 +1578,24 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
 	}
+}
 
-out:
-	if (lock_tlbie)
+/*
+ * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
+ * lock. Firmware with MMU_FTR_LOCKLESS_TLBIE does not need it.
+ */
+static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+{
+	unsigned long flags;
+
+	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE)) {
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+		pSeries_lpar_flush_hash_range_unlocked(number, local);
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
+		return;
+	}
+
+	pSeries_lpar_flush_hash_range_unlocked(number, local);
 }
 
 static int __init disable_bulk_remove(char *str)
-- 
2.39.5



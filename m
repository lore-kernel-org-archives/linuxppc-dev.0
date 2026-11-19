Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C909606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh3K7Y26
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNP1LQ8z2yPR;
	Thu, 19 Nov 2026 14:39:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059573;
	cv=none; b=ibOmbB3HUpxX+hPVf+QGO5otKKPLQbGECmmLdO2N0q6N91guOrl4f9ScVCIrv0wzL34KBelQI0OiegAq6Un832++ROu7jU41RMgYsMenHOfx+9lJmXoQUYGJxBoCLwZ1Oa1CPS30EkVBOp83hFUi7TA8/oPr3NsBCqUFrb3tS6Hc8Y4DyTU0bQTDKzbepYWz5HCclTwjOyloFgZVptDf/eEfoxwAQr4GAh8/ZFy2iTtBhTIjIabLPmnL29equHmznzD2va+SNvtgNHyh2fvLBU7muG+yh+3a85Gagkf8BAEhctEhqxVS2byHqn52pEIFxvYbKI3+BvnACoH0RYO8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059573; c=relaxed/relaxed;
	bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdXJnKA8og/LMCpCxs/yHigY5lNb4X+wSxYtjeyaT+8xxfUan4Ytqy+oBTbOE+L6gNscr2ncvFf4wSFaU01Y7C/pNqdfPaJ55ErRP42mK/5ufAc2qOMKoKACoj2+mApbjkUVX+E5lbDoSNLLKZclbzZjNOygvAzpjfxPOvLdWFAolSrsNDzmj2dkJqsZuX9jG5R8j+Aszj5RtH49rED9dMLR62tKKNn9ZKugJGOvyfPN/rIeWYjZ9xyrzW5gqu7H/5WU4Mb5pCLmi9cIPG2vpcXQXonWw3l646dKPEb7fuNGT0rj1kBMTrBm7sWRQw7xdbwV/orbiVopu39B/NdHPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh3K7Y26; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh3K7Y26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNN4KxZz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:32 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-382f4710a17so2333464eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059571; x=1795664371; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=xh3K7Y26wR5OSJ26Z09VHf7Jjno08R4I7T6KP4g8rWYNBwJK4BqsOeUl2GY8iz43R7
         IQvF3lVEj6tVHaXwn3vjdr5EiNKZg5MZrJBZN3JgYSf+TeO3iI+5lYUfbwhFWhOawMiT
         Cv3/m/lCNtHLneVV7WtbY8UKa4+bcxZhRC7fUl3HJkqUKBm2d4s/ejqiTlq5tKcJPQ+o
         7ZwneWV4dgig3RLM1vCewh4foIelOZK4uZwqOD9OsyRNI/9v8A+OIN2GiwaYrQoKyI9b
         9ECvEB6H6I6C6+80OBgMbP1c1zDT0zs2uFUk89qHt+cHrbcaZaKaXHcID77qCCzMfZU4
         9dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059571; x=1795664371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=LooCXP2nqncfX7aboxW2ezedLpkCHp3Qg/GTy7HyUfm6dz5HteCF/Z+r8h6qdW7JTt
         XcZkp8FG5IQOnfX5oVp5owhFqAmavw46M9FRGHVz9b+AKugUd76yQffBH+bnz22OZHen
         Df6I1ch5WR/d6cXuI/vLNlH1Dst3pDWIUnqtLaeGIAwIPyFkO7ids0CPDR6i/y1LO7mJ
         DX/98lE+SYpmCjoUc2f/xkbcx9IRXJvUP9G4y8n+fesGmcAb5aHSHPHjsaRxGLayhpVv
         YzauJmUH/YTtHKyrFMtSgertUo8BJa1MueblbReODFYC2+hpAub9hYvGONj45mprMFQK
         QX+A==
X-Gm-Message-State: APuU4Z8ygCU1i1AypdPwaUbxvHtVvA3wICm1SKTa4Q+04QXLjOFKVWOH
	gFPl+ESZkvrO9PilG+LSqwyiZKaTX2vdR3Vy52VSVMchX/NXFdaGidz9k9WrIA==
X-Gm-Gg: AYBFou07C3WaN1QjVq0s7EKsJOWmRzXljMh1O2C0GL15y3opGtjpfE/2kcIr/LEVDQT
	EU93O3viBGuF2i30U/HQNA3kHYEjiWHOHU4FNc/Ff0/cCtk+bwblIQmSiCGwxkQN2qugK2TcopJ
	BJvzWMjgIqtH20uDy3kZo4aCUk8QaLMhBNaQPSA2bpb1I9ukEX6WsRO6qylexVXLbTMtRQCcENe
	HC13xSCX2cG/o3wd4zei9AjKSvtjVWQ2TfZpc+0pLYoZbtaaeTJ6j0802iUanRr90DpRCG8xlzA
	KXPIfxmnV9egbj+PAztoPfsJ66vQVILh0xmXwZAw7XvRVLzHyLk9TlA1X27mhmtKdqxKJt3JJgU
	E56Y4bfuFkWppr+fK6p4Mmt63MOPGMEsUoc98qnhQQ3/sFceC22i+7l84LmVP7E/xOJbJpEUYqd
	fDjFJTT1XNM2aaxG4qkmA/9kyQ5Lpkg7abtT2VO28jVCPypap4WVtJz2MBHwlM82o60n4fkNDh+
	LO8bbxYzc2+WaNT2q1ohE4WMDFGgYcwhTjFB0xI622Mr89ZWym6nenEvEoLECs395I+2WMVY4dB
	Bhd8UqgaOXkmBMm7pCoU9t1bW1NX3xOkZuZGJElrN9Arkr/YdHPLtic=
X-Received: by 2002:a05:7300:f408:b0:369:f035:661 with SMTP id 5a478bee46e88-38280a3c1f8mr4556846eec.15.1795059570467;
        Wed, 18 Nov 2026 19:39:30 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:29 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 01/18] powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
Date: Thu, 19 Nov 2026 09:08:56 +0530
Message-Id: <c6cce4c4ad2b177cacfb7bfbb7bfd4a26fcd4612.1795058683.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  iommu_api.c:380:1: error: __ctx_lock_RCU 'RCU' is not held on every path through here [-Werror,-Wthread-safety-analysis]

mm_iommu_is_devmem() takes the RCU read lock to walk the preregistered
device-memory list. On a match it returned true from inside the loop and
skipped rcu_read_unlock(). Hence fix it.

Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 60d00c9e7f19..56d9aa6cc8e2 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -356,6 +356,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	unsigned long end;
+	bool ret = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
@@ -371,12 +372,13 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 			 * and the caller needs to distinguish this situation.
 			 */
 			*size = min(1UL << pageshift, end - hpa);
-			return true;
+			ret = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
 
-- 
2.39.5



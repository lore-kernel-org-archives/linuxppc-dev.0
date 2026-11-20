Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53174606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qG1iX3pz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1t50NlFz2ySk;
	Fri, 20 Nov 2026 15:03:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147437;
	cv=none; b=nJwll3r1HoLlwKpY5nRNjLHJBQNZqKOyavpQdnzeDymPI3hVuGgIqyrBpwrTg9Y+1s3kVkllVmitgdVIUm0T0kfHMOhF/rYmxaFhLpWVSYATrzTo4GE2X66t/wYXOFdIPxS+itWh+50zehvr2JrQAhdlyhJoyHQn4Sph9TeKfiNiO6gk9TJhhaZx107ympgLlB9GwkaPDq3nba8WbD42W4vPFpIvHx44Axsu2p9LLRKSMTPTs2l2HJqGAYACmtkhogFrE3HFcMy0ltGGsgNVscHyLdN0Ti8xo1NrqTiqnyYn4RShwh5bPwTPGMlv9I8u0Nvf+d3xP32D/dotRY6Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147437; c=relaxed/relaxed;
	bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghRGndLJnsotbXTYOd57EmDnvdhnGaj8SmFKEka07SY14O4aLynt4SYo4psRT+x3Vp1CoYfoBOf/oJ8Zm1or552cJKlxyElIUuNcmfHUOxyDUH5qNZ0WB7QBEDi9XO1BCGLDciEQD4sioTJok7iJl9sSXpfiBlx9MR0d2lqwfxnCGLCXxylF1PvofCnfvm+NMlWPA1SXHiKbsD5jWTtC6NEal7BUG+wY5vYsNG9xk31WZCPWPhZiFMdueNjTZtW1tCb2kdO5O5MeaBuxK+wSsekfEY3IJ620Tv3yb0ZrQ0gU1ncXOSIts/e93Upkro8Ygr8IWaMlqkpetDQuW3qq7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qG1iX3pz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qG1iX3pz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1t42hjSz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:56 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-380b40319bdso559621eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147434; x=1795752234; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=qG1iX3pzvm2Jjo71X+67SUUaoOn9iKmr4bcM6bS9wJJS762uWMnEsBdR044AaL7Rd+
         Rkrb9/nWZv+fJ8ZizMdWXcOo5eTdOEVVT7vTVOK51g5bt2jfuoCBRt7x1CH4U6OuOWS0
         BJnK6/ugJcJuXzK0xkBf6JUJk2Jty4IY4cXmMxBzSUy+Q4qmNYeJMddZmLRHRHDFt/DL
         1YwFrOTcCX7xwlYAEwXdDICOKJLbzM4hfGIpBJhJ5j76qxPYtOPXj/tfuo0QAUCTt+qG
         JSMJy+b/gONc+308gbx0SjN/c/Tqnbhda+mnRnnzTUiLLxr0XlC1nLPDhhaqcnnodLdW
         EEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147434; x=1795752234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=weuH7a4HqPMuBb657m3G9rvjALqLHT9s3rigYvWqDmgNfS8mTxCCPjFK1ISWP9Ha1h
         RZ/OK5gnLhvYnpNJsaN4kZbSv2cm/krlXOyqnGxV+mr/vk0+ohZltpolYyjCELK3Fntm
         7T0vUkUe03/WIPKRI8aahixpslCVNyYG6N5EUJvvxyjMQWMwnB7t4Tk1sC6bpuFY4iQo
         /dH2cG9ISy6ZFzIdd7keT3dfRPSLSzCmKcbo+CqlA8hh2/Ozz4xyTZgQ19ymclXt/3Vg
         et2PlCwqI7xsptQW2vJnfGaPEaf10bsd1t7kSri+EzA0lnctKD6UkDadhhhM2UCH1qJx
         vq0Q==
X-Gm-Message-State: APuU4Z/fYPblSkI8PAfAnZWpQgIRs3Vsb8jRBw38eHBX8Y9tjLgcaYPU
	xC3u2ia+tm1n1RUJapp9zzIPzthVqv4WSPJpaJJN5Kr/svnNcXsy2qKGZXZgUw==
X-Gm-Gg: AZFdTZeZQCjrrHULCMLL8Gcy9b1QbFpm7yYEUGJs/tmWIDGI3EXUx+dprR6Q+I5e2fL
	dzKSceM1ul+0XIOt304EYVloBGMwbjeqT3QJc96/FXicp0ugmaYE4/QqWnPvoQGbnkPdCsZYOwo
	lDsZif+PofzHrB3NdX53+DmfFXkFo5EOMZ8QQq3/GpbQ5rxIKPKOyatMcqHTMRBN+QD+wZCxKxa
	PT9Qx0YA7yAKuZ6uNvWfZgMHVd1xSmgo0wFRAMTZi/dHp6gLdxIb3XDOVA/7OtdH470KhgYa/sK
	yVnNwo2PP3zhX7zM8fLanrcELCajagQVhg1YC2VmH3bJBoLjvbXJNABNi8+G39k/a5edtQRvxYk
	b1S+3Jyx4JHY4tbW58OlnUzht8XbKFT/qStSoJTgTj1avZbW+7rAURNwwcFzKhT5dJ1pUhyuUVv
	Dotfpa3LJGw0t5TgCyq5EiSfaclVe7sdm+yPyqpV1H6BdS/o1XnoXyhSbEpc/eT6kM0Mg8lxaPE
	OvECMQzHNOX7IXWikkCpn9bfK9+vc6TCPjiayexNIOcpbH35Sv+mGXRiwRYeJvXMnMAbCs0Ys/1
	YWclei6ggMF+BSeEYo/wBBBGy95pfalH4A==
X-Received: by 2002:a05:693c:62d9:10b0:383:d3d1:f315 with SMTP id 5a478bee46e88-3856fd5a67emr1690093eec.19.1795147434540;
        Thu, 19 Nov 2026 20:03:54 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:53 -0800 (PST)
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
Subject: [PATCHv3 06/19] powerpc/mm: Rework nohash TLB broadcast locking
Date: Fri, 20 Nov 2026 09:33:05 +0530
Message-Id: <b40b6042422310e8f27f0285e7c6086c32e29d45.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
  mmu_context.c:141:2: error: releasing raw_spinlock 'context_lock' that was not held [-Werror,-Wthread-safety-analysis]
  mmu_context.c:147:1: error: raw_spinlock 'context_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]

  tlb.c:257:4: error: raw_spinlock 'tlbivax_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  tlb.c:259:5: error: releasing raw_spinlock 'tlbivax_lock' that was not held [-Werror,-Wthread-safety-analysis]

This reworks the locking in __flush_tlb_page() a bit to satisfy clang
context analyzer requirement.
Also steal_context_smp() drops the context_lock, so it needs to be
annotated with __must_hold to inform the clang analyzer that this
function holds the context_lock.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/nohash/mmu_context.c | 1 +
 arch/powerpc/mm/nohash/tlb.c         | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 28a96a10c907..bdbe1f55f388 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -95,6 +95,7 @@ static DEFINE_RAW_SPINLOCK(context_lock);
  *  -- benh
  */
 static unsigned int steal_context_smp(unsigned int id)
+			__must_hold(&context_lock)
 {
 	struct mm_struct *mm;
 	unsigned int cpu, max, i;
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 07a2db16c2b1..9297549aef41 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -252,11 +252,13 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
-			if (lock)
+			if (lock) {
 				raw_spin_lock(&tlbivax_lock);
-			_tlbivax_bcast(vmaddr, pid, tsize, ind);
-			if (lock)
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
 				raw_spin_unlock(&tlbivax_lock);
+			} else {
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
+			}
 			goto bail;
 		} else {
 			struct tlb_flush_param p = {
-- 
2.39.5



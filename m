Return-Path: <linuxppc-dev+bounces-27647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D64C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:08:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmHcz17b1z2y7r;
	Fri, 18 Sep 2026 13:08:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789700899;
	cv=none; b=lqtniuEp0PwPrhJkKwbIC/nBDbKVhploA1pCkAqDRh6/yq9d+IsIRvIf/3mmC1+EMUuvfpWUp4VrBaM4GjhRPu/j3hYxOrnxmA/Oe7h+Qca61iT+SKe9Sw1U3pnvAJlSbFudYJcAiwgIVTNV16OOemzg0wEdA16rPE+yWHt53fXFhBlvmRL0qumK0PpeBMUcrb/7+0soz0fZ+2ZXdEy/YfDe50900sPsOQmioLe4DlD4u4NuLMtedTLzA/i/LWmMj0JlLFqhh+8PXtd2WbhK77serZgVyq3AICI0udUm+6E5KJLA/65r4Q5jvC8/w0YeRzjn6jxFIWSN9lZ2m4of8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789700899; c=relaxed/relaxed;
	bh=fJH6YHeiT+QMLup9WdHDyY9l+/LmCkYCMjy0ciLd1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUsO8I85sTqK4YwIzQdFTAOBJbPJBZc7cstQA6uLlhEuC0tLlJyLNz31BVwqFi/TBjZqhTRHNvdxticfCqLJV2CCFfX1c4h50fDpVmntY9MRsGp3625O3C7cXlXIHUPhsfnIvG0B6LACs1tfewXXPZirouflSJt2+HmXNiTwxGpxfd4DmcbTvT+vtSpHGxfXRuOJp/S/HLBIy7gxQXkLNevMb7uXaAlh30Q/AC25yt6C1Vns2WZnLPde7pf5rutA0oAB91tdR3kfOCrGuoB+KVVm1BEZvSGdMKQdTJD2112d21/pP/Ah8yNvEOWMGWHdt5HdzKN7whU+IEVAuxECaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgao958j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::3; helo=mail-pj2-x03.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgao958j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::3; helo=mail-pj2-x03.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com [IPv6:2607:f8b0:4864:39::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmHcx3hFJz2xQ7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 13:08:16 +1000 (AEST)
Received: by mail-pj2-x03.google.com with SMTP id d9443c01a7336-2d6fff25530so1407125ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700893; x=1790305693; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJH6YHeiT+QMLup9WdHDyY9l+/LmCkYCMjy0ciLd1HE=;
        b=jgao958jhZ9K6Nf3hzMp0vKmCioArPCFqHKCKpGCKh+FezI6TSAveZzGBgIfdPTO+2
         DcI5CtS12smeM0NJ6QdGOvMrI0KtXUUxzKdZ84DkMLRfUcsk5DxyO6YeO/u21U8ZtiZW
         KXlB2zlC73eekWqLZUHgA9V8qf39KlPEoeGgNXKhktTtbh7ZTzqTqOXmC6GQyZeo/1F5
         O8mRMvVpvwL8fvr9pIkb5MbH8fvbTImNOAChMSuCN/7106SN6JrZwv1DqGMac4KtSzaJ
         yPdiCWMC7MwS7ChlQU7xwCT2f0E4chKVXO9nJyaT4efJ0bt0A6Bk2bcphEnIpekZMeeU
         ttWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700893; x=1790305693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJH6YHeiT+QMLup9WdHDyY9l+/LmCkYCMjy0ciLd1HE=;
        b=uxypJP/6vmcFSsLLCRz3nf/z+VIrEQkZaPu8wECe/KgiorB7Wy27+VIxBwG5Yfb69G
         yzyDyKSa9Q8z72MpLhJsk4Urpt1BtvLK+3ZNQxT+5vw0n/QAlDj8AhqEhaP82KumU9n/
         SbNHSThsuCO/VkaODFV4VHxBjM/aLb1K1ZGv069ol063cwtFLtsoUuKuUD60lhomsxR1
         LzkKzS6iadhGgWafdl6IX+eSYvm0c8AVl1vlL25INwSL9uOKCwaQtMjyGmse/DtMEW/O
         iCuiTpg4S/0/40hAygmvCOAZNhhLhJebOHVZzQbxKy8LaCL99//u6OsJGdZKhVgfcNqr
         1jzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxv7Dql7AuU5oOViMwxqbxx1SwiAJlt+j1PbYM5JqR+W2+HpAA10UrsZ+cj92gE9M+jWqfWjE3JDXc9JsI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nwGlRzKCU2txRN0SvwnK6kmWdfhTgzH6kHPAFUfendXmOyLSpc
	E2RJGPBzy5t2HfsV+UFIgOvfT1VHpz1a61rzcgnFQMe3SAidtPv2KCPUSs0rNY3ArnI=
X-Gm-Gg: AYBFou2hPFAHiEZZDYvhicTI9JjFN7TaBLaN7t9+A5V2NryNnYrkbfHzpakdb9YkIPu
	uGmPJTsTIA/jKiDLwjJ+7G5oBut2scAcUFFMyda2s0zg/wOXmk0GF3mHZf2Jg5M9FQTGZUCQVIa
	3fg6zyR3GT0CN/tWtGQe9ZmM6DqMkKst+R89f7fs1w8OET0fLdvfv/9N4n01XLRg89FFzCVdtxt
	wdUKyvpqjn0/FVjvibKKboWeecOTgnr4wApwVfuwklcM5cgqLeq6ujN5j4lXUnAwHwZkGs0ZNk/
	VNuniZjoHiR2FqkjtQ+UuwZU+1Zj1FYy2fRe3fNALv/IRl7Tb6OUevl1Q74a3v60YU3Swi2FIOo
	Mv7948Mfs2m1PKnynL9ZjePSzLGPExTp1pmV23TxOwOxgeoKN8EGGkC10Y7+vAV6Fqy63JZniEP
	zRXq6gqVElMwZlapmWMbFpe78W77SgzkCAIWHRdKUDW3dyQhjCMM/9yNHkO5ydijEmHnh+eHrTB
	/4EyfOZixR16dYXtNxjWUj2pWM5SeoG1L7g8AaQ4vaMKGSrdguOhUgp3MAa6v/VaxCd0jQf6xbC
	u8CWs5d7jXcMsrROOad0YQ3/oB7leyTnKGS545dWavB+1tKUopIJ/JFFpR29AxkSzcQVhj44edz
	4
X-Received: by 2002:a17:90a:4cc5:b0:39e:5d5f:37ee with SMTP id 98e67ed59e1d1-39e5d5f3b51mr8698a91.25.1789700893449;
        Thu, 17 Sep 2026 20:08:13 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287be968sm433645eec.26.2026.09.17.20.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:08:13 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] powerpc: remove unused audit_32.h header
Date: Thu, 17 Sep 2026 20:08:04 -0700
Message-ID: <20260918030810.420490-1-enelsonmoore@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last use of arch/powerpc/kernel/audit_32.h was removed in
commit f26ad12356a2 ("powerpc/audit: Convert powerpc to
AUDIT_ARCH_COMPAT_GENERIC"), but it was left behind. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/powerpc/kernel/audit_32.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/powerpc/kernel/audit_32.h

diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/audit_32.h
deleted file mode 100644
index c6c79c3041ab..000000000000
--- a/arch/powerpc/kernel/audit_32.h
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#ifndef __AUDIT_32_H__
-#define __AUDIT_32_H__
-
-extern int ppc32_classify_syscall(unsigned);
-
-#endif
-- 
2.43.0



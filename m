Return-Path: <linuxppc-dev+bounces-21422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DECD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 03:52:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMpBp4v0Bz2xtC;
	Sat, 23 May 2026 13:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779490754;
	cv=none; b=RMPhH6KXapQs+Pot4VHk9OnUM76boQ6fgFwvQdd/kcRFd+K51cuXkB7rLuXMrxj0+NqdKbP8ig21UqrEc9W1fNhDGMvt/9FuV9ocgx9mWAzXy7bVG4d4I3TbzUJTHuXqWjjgrat8Ig+U5dITWrtcZhSFroysNCd/rJZOqK5oHb0RX753RhzuZewOA9fb6SvI7duTKYjMiJTBPvjSGrP+ZOUojlAB2UHjsBqTkx1demDhirl75I6/0j5AVKAyBli6tcZghYbjQEFiMTu9avHubSuNWbHhAkBUaBwHCj8utDoc8PGCZFG45WeZHSPOg/cxWNUMxNjNThZ27AvB4EvzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779490754; c=relaxed/relaxed;
	bh=YdUzE6tqdZkacDbc+Ei+hTDSqETPzI5AVuuqPmJdYCI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fGPkjTzOaUUHok9w+iOyWmj/Pp2KSX5p/84YNsL9tjkWd4xoSfVxkMJLcdZQfbDy6ZnsvXIiGJHCcQwLWCKlvrzLu2vtm4azlMxl5PgCZ9V0bFDasECzBlslbeec+MRJNw1Df4aS6DAoIzlZURm+YZYJ9ZRK1gDtx2HnqScuf6OuWilg4ycNqgAKpyrWpkNIEuG02weSb+vDDHpszgXmBg0aUbWpY3fD+zUgEhJaGdmQ19jssiaejIZ6mKWW5AJyKzomKsDTfGfEDYH3AJ2lgIS/iOYBgSGM6W4cgUMbhU2cUP7P2AFrOtOzR2o/zFAmFVXt/+TIx0dhXUDXWCn3sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HLNDxcOG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3vd8qagkkdbgh7a2f062f4cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--tjmercier.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HLNDxcOG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tjmercier.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3vd8qagkkdbgh7a2f062f4cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--tjmercier.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMgh05whBz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 08:59:12 +1000 (AEST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso7521482a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779490750; x=1780095550; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdUzE6tqdZkacDbc+Ei+hTDSqETPzI5AVuuqPmJdYCI=;
        b=HLNDxcOGwTK3gNnbJT69RNyb6U5hjjuLntvp+WRNe54dWQgz/CbyWlJ6f3bEsC6QsB
         HLYqEaITSiI2Hj4VTjGMoqE17eqkElMnIS7L3zkFZ/sd6Uiv/A33+vFaUdDf2hOT5OG6
         k/mtbYu/0hKNnWCSWOnHGz5wcmIqU098ebRtK0Zv4fct2P5Oxe+xYr9SZq/+dvQQJPCi
         ysO1NJonhe1fphv687xON8oBYIq9QFWU3Yk9/uriTZ2CEA1c4SlYTLxkQZh/5gosGvRp
         9a1sJe2cQEtnG0WBc8CpMXNo59kQ1/C+CbiAoTZb0oKoYNHEuCdl96xTJwzLhf+pON1o
         Xe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490750; x=1780095550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdUzE6tqdZkacDbc+Ei+hTDSqETPzI5AVuuqPmJdYCI=;
        b=kgG+4MUVqP8i07t2tWMHLBY+XnMSTJKK7oJt+5rG1T305Kp71p/baYGcmpXdPl9M2i
         ++v/Cz17uj7Kxtau6IqE0MQxg0WwnkadwDu3Zs1iaq70Txuw25nleZugZJPAMF/pk9cZ
         n+d2qevKUrzDFSvVG4m1E/pcYu1O+e4n1G6wBY4lOhyRbpPl6/4sI+tXvZruHDFYutK5
         OMzL2tviLyrBOZCm5TxDoQSlzlWTeQkz55IWnL/aDHLxvSErXOg2jvTuMvTF6WL3p/jI
         BZbNrPy7iNzbJnFEzqQ9JN54YShx4M76kyOMjZEx19aFp6tYwyfTRSMqRDqKi3SlQ8dF
         9t4A==
X-Forwarded-Encrypted: i=1; AFNElJ+pdmNnN4dJN+3SDwcZwdDutgv6X9+YyPS1owB2Uh2qfyzdjcz6VwPbzufEHIbuAqLIKGJlzCPe+LXvVqY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1VzQKaLtz8HLkujvP9wgbcOh9CaJ8JhjFtEx4n+FMVmCtg5U7
	fq8ooU2cSum7OUiTamm/rhWE9aH9KIBD62Zm8uUhCpeeVVOU6KLGrIeHE0BdiNWv9XUb0iGPOix
	L3IfgC9RCS5p3IwGS5g==
X-Received: from pjbcu23.prod.google.com ([2002:a17:90a:fa97:b0:369:8552:9db3])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3511:b0:369:e1fa:962b with SMTP id 98e67ed59e1d1-36a67896c7emr5260153a91.26.1779490749237;
 Fri, 22 May 2026 15:59:09 -0700 (PDT)
Date: Fri, 22 May 2026 15:58:53 -0700
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522225853.878411-1-tjmercier@google.com>
Subject: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
From: "T.J. Mercier" <tjmercier@google.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, mripard@kernel.org, 
	sumit.semwal@linaro.org
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
module") the system dma-buf heaps can be built as a module. The
system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
but those functions are not exported on powerpc. This can result in a
build error like:

>> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
>> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!

Export the functions so system_heap.ko can be built.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605230046.E9uhmQXM-lkp@intel.com/
Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 arch/powerpc/platforms/pseries/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 384c9dc1899a..59cf32e51ca3 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -50,6 +50,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
@@ -63,6 +64,8 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
+
 
 /* There's one dispatch log per CPU. */
 #define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
-- 
2.54.0.746.g67dd491aae-goog



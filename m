Return-Path: <linuxppc-dev+bounces-28450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4FDC9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:18:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8dz3h4Yz30PJ;
	Tue, 29 Sep 2026 17:17:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790666279;
	cv=none; b=WjJF0dwY3uWsHQxBKRw/LYGFbHzXcpZK2tUu/M67ftw8sASDcmtO48bZNwKK6xyVlceZaNHgaOxUQCeNOXDifh4UVSMTLXRhwWQuHzm7wuVZ0jkUDkTGEJRP8icJ4JhstqsIAlSKm6o1NXW1C5aocGXB/4TdOvn0Ta4UDqA91l3XBADqBozQga3oa8L5/iJyJZAWkpvigFpt8ys2AgpJDbELcqiQxzP5plVyOCijL14EWV6CkbJhmo8h+F3PkOasdzIdFt8ZGiDG0pIbb/6urENGSbYsaiT0cJRYNlKNVevcRLdwjolRfU/LYlohnxTNfjimArNtp5M6Ti/IpRlVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790666279; c=relaxed/relaxed;
	bh=m8+4ed2pEOUpvT4RZtU8pogb0RWHCYruOyJOR4nVdY0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c6X63nRKOiicku/95RvGVbghzsJMZ55oJNTqYTsEa5zTszvFs54Bfa6f7lJ7Q/Ydyun4p4ilX8OUwXL0BkwVVFgIdiHc2oPQ7X8ftbWxSDGqkqRwU4hr/Sz64ctyBfrpwJLqiCu0H23N0h6mLM6e/9+V8L6AtTHxk23xZQH88VBsybWc8tphCB5s8DXSXdPk3XyCpYWjhqx3b5lg6tC8jEsxsainC1HRFg6nfEbow0MJ3gXQ7kmCt4RrBt99vjZgvHe/TEMak+MJsDL1c0EYvfCQsta/jh2K8rVZrV8McC6rVmM/yWoOxm9IectwFqixluc1bZG0Ke+wWO4+zogkQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k/Xv58Pb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k/Xv58Pb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x10.google.com (mail-dl2-x10.google.com [IPv6:2607:f8b0:4864:38::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8dy5j5hz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:17:58 +1000 (AEST)
Received: by mail-dl2-x10.google.com with SMTP id a92af1059eb24-142dd046b87so2770888c88.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790666276; x=1791271076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8+4ed2pEOUpvT4RZtU8pogb0RWHCYruOyJOR4nVdY0=;
        b=k/Xv58Pb6TADGmH1nVIQ+30uonVKPiqY82wFyhA4ULOuBnakq/F8jo0AaeSfLp3qW9
         M+2Z8qMsiEQ6N/vuu3kf9knLmKPyGxOAenewYok5glHP/0ARxhF56aOzhJHNQvQJeJRP
         n+IaCG9Mfd21X67OMml9ijTHY3x7cfkfCRXkyhnKrujj4+DAdthA4YVNCwqNHWbwlpI7
         YErVZ/vyOtydShQYz1+X30BeM6SkWBuSBwEbM8l9xEYiOsJxmP77+rmuwdIYnGz2ovmQ
         FF7HwJW31Iuqk5bEAtoT3tXPy2UGO8khb5z4NeoA0qs3K8yB2fgFAoBapNRu/cQdHivg
         vPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666276; x=1791271076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m8+4ed2pEOUpvT4RZtU8pogb0RWHCYruOyJOR4nVdY0=;
        b=AbHzPDc6ZfLgU1A2gs5Ty7wv3QsbYa9/+AXHQW74vGCFNw8YoTj2RYWljcMzYwz8Qr
         ggD3RY3NEMNpdXBz8SIrplwuvsPjplT87TTk7ZIpoQrk4z+HVeI+rFtiNZ7wR8TEtYFF
         02hjJBCXJF3qcqXIO+QFMDUmV9dpM0dRdW1o1PbRVKML2hteDtpXOgx0bW4jWMzcQVqn
         jC35iv58wINfXmVpyJH86lcjHichPI9uqNIz3R1jyhAXXW2DkJ+tiYm8NALg+zefiPGf
         0hGmbOttZqQKxQmprSzIac94apnxPsq8PdnwVwQ2a7ssjtScmh30lNaHLqlUKdNIBrBq
         Eqjw==
X-Forwarded-Encrypted: i=1; AKwUvBxiweWzKRtHKuVgvTkk3oB5WetMyvWuKNjYrkRR1aHW04bUZ31O6m6x/UZ2v3WtU8Uqo3s4hmkM/wyGgfg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mKW/hxTw+qgiG1wConVN0MTKhEby6G5o8Ez/9C1caVza7P+LeF
	F0s1uN0Q073SYRuq9IRTD9fAcCBq8Dbe5U+VUICSR33fBNVkAOiHwe6y
X-Gm-Gg: AYBFou00IZp6THTJi92XCZJy40F6xK0VdxemJoS3XS11DUz3eMyQtHVId0wCUSgP9u0
	Zxk76jQXuA4pG+LCS3RI/0oJJypDabqJV71NCIR4iLpBJLPnM2qCLcmJeIFOFLKNg59QJCT/7AE
	c3CFXPBymb/NXBKpZbc26wm91IYjNtgGbCoVzW95OPv1Q5ygTw4Nw0HMvDB/3hzjhZbaQp9TARD
	58p1M/Owmg6UaN4VMoItzn+tDaTSMwp7g1UJ4cIlKU6eUMXX75YtiH8vT/ADKr9qlBgvedY/qL/
	Nk7irLwVxHky2b7646j+p2Jvtt1Fa4Qdp4BPVRxategfelBN25krItn3YLDrGdxwhkmmGfQY6tc
	s27l/B7O49d2kc/+Xck/txoLsKjDEdhs9IW6T9A19h6CrqilguhFr4yczj3QNegK5fvMzUMHqxk
	FrauVVC56RQ1RXos5zR+M/iEH/fZsyrDQ0SgDuwVLwWy+tD56B0wJ2mTkaMoET5F52uQBLpBOld
	Nt5qqvp9P2tZzSvYmWWa6R5Fg1A6IpfZmBxLEUdVK5YNYGlVpU=
X-Received: by 2002:a05:701b:4314:b0:143:50a0:56d6 with SMTP id a92af1059eb24-146cdfbe26dmr11752569c88.7.1790666275660;
        Tue, 29 Sep 2026 00:17:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c0ccsm29980096c88.4.2026.09.29.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:17:55 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	ruanjinjie@huawei.com,
	tglx@kernel.org,
	mkchauras@linux.ibm.com,
	ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/syscall: Avoid atomic test_and_clear_thread_flag on fast path
Date: Tue, 29 Sep 2026 12:47:44 +0530
Message-ID: <20260929071744.2965058-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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

In system_call_exception(), test_and_clear_thread_flag(TIF_SYSCALL_RET)
performs an atomic bit test-and-clear operation on every system call entry.
This introduces an unnecessary performance regression on the syscall fast
path.

Combine the TIF_SYSCALL_RET check with the unlikely error condition from
syscall_enter_from_user_mode_randomize_stack() using non-atomic
test_thread_flag(). If the flag is set or entry failed, only then clear the
flag via clear_thread_flag() and return the error value.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/kernel/syscall.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index fbefe1927b10..8529827d697f 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,14 +18,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
+			test_thread_flag(TIF_SYSCALL_RET))) {
 		clear_thread_flag(TIF_SYSCALL_RET);
 		return syscall_get_error(current, regs);
 	}
 
-	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
-		return syscall_get_error(current, regs);
-
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
-- 
2.55.0



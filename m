Return-Path: <linuxppc-dev+bounces-17159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0461CEFD208
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLS9B4RCRz3dWj;
	Wed, 25 Feb 2026 19:16:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007390;
	cv=none; b=YEPVMhECwXd8RWhC3RzoXHLmzhsuCtkcdNHIprAERqsCICVQeGRgsicW3M/mQ3Ke2s3NJXAzE9LH4ruV7j0rgViChyiFEQbdH9GiLMqqdIHadeEylNEXKiGhtdWSTbM2WJoWtqZ6kr5FQ2nEQU3e4lHwFJy2QXtOUhfl5FCvGMaU0tdNYHJ1zoo7p1JKf5cVJx9mtHx9HfZBttxXrYcvjSBsR15wPUkBBGOJrBf/+8OnW7uPDIUiWQOQoDKXS+TYCQXxkp2DzQAySkNo/odSj61SpF1h6VBSmuTOHq0UHRfuwU95xSVTE6YvfJabhQWuYXl4d4Rij9uX+Fr/vpky4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007390; c=relaxed/relaxed;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ItsUCeuj3PHaVMXn2kkfGGfNMFXjrxdy8mMssa7L2nRG/5LHDigHc4p3KhIx5jyg9ITIGLh1OUcjvRozOo6eCVx/lsSsX6+xjhOnOoTcIDlq1AdQw7PRIJD6JZa6PvLC9iPyI+IuWuzNKa3WNeSVA8ESL9i4R4N2Vt0gpswSXZ5q+suaQw4dqBzyj25P8Ppmro+ObYx7WW4eN2N+T8PRMe1+qUFwAPT7wlttZz38BNbZDlUuwjYVT5CqfQJc4eCWHRB/37+xoLXpNJMyAL9SGbeKmeFQpd+lw0pmBTNTytzDWdmNiQJgUsJHaER9bX0P9HSXI3fb5gkt8UDg6EsG1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQblmx7o; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9VPG7zj; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQblmx7o;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9VPG7zj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLS994S36z3dVw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 19:16:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	b=UQblmx7oRS9e3+OhisC6B8dvjTVGB4VnN0sS0MTDDUfrKxMNbSJWnEidxqyqaL5yBfeLhU
	HxX17kF/ASY/CKEzL4hr1Emg9U0+OrhrQxMwkHNAV8Khuv2JxkKqtNHXs4qsGdNh0fuFJd
	pDZMrgdgCDDXJYVJ5Bg7arb08pSCgvA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	b=a9VPG7zjtktjvCZA6dIsLXqTzGC1S5vVSHYuFFwrvsIZPQIzppqgg+gbC79muxYx4ZXBzZ
	PR1uzagIwdQMBOVAjctmXY203lSCkBRpbzp+3evoZOLl8I2mIzQlYaZY/oSWgsg3mNrUDo
	+ujFfSgSN7ZGppFccxRN0uhaU3WHe0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-YXdFjCA1Mnetuo5LYiwicw-1; Wed,
 25 Feb 2026 03:16:22 -0500
X-MC-Unique: YXdFjCA1Mnetuo5LYiwicw-1
X-Mimecast-MFC-AGG-ID: YXdFjCA1Mnetuo5LYiwicw_1772007380
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F2CF1800282;
	Wed, 25 Feb 2026 08:16:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37D111800465;
	Wed, 25 Feb 2026 08:16:09 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 10/15] arch/riscv: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:07 +0800
Message-ID: <20260225081412.76502-11-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: LRjnBy8bdsOBoVnWHs5UCjRDJHMiFKAnQ45wtpoFilw_1772007380
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/kasan_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c4a2a9e5586e..dc7cc0dcc7eb 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -485,6 +485,10 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	create_tmp_mapping();
 	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
 
-- 
2.52.0



Return-Path: <linuxppc-dev+bounces-17162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169DFEFD20A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:17:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLS9r3f0zz3f1K;
	Wed, 25 Feb 2026 19:17:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007424;
	cv=none; b=ZZ5C0YtWObRkyK/e/6+yLCgTEZKKxKOgNeHIcO00vQDLyEmqdAkQ6y8ZJbpJly5W9UHSmL2pTZ4bFoK280zsY1jddYPVXW8LvXLgQrkvGgVd82Z5T55Fg2G/repPDLzZtFS3oiTTsUV+JH08D9o9Cj7nc2VHz7DgP0ftZwK8n7JBSkQTOrgyEXVGNsEhJb233r7ctumzrtCAGnx3Weea6zs8zqa5VqjV32aX/glF1wdBv4NYRAQieOFjg0/m6dF7dH0oggB2Bk4KO/Rnc8Jp+K3LzYjsiplIfVPPtnOO3ytgN1Ju6DBDcFIDDWCHikG1ZtPrV2foy2LmfQCL0rn0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007424; c=relaxed/relaxed;
	bh=pa4Mok84BgrIJ096oguK0x0r8biU2FN9KdJaqHRRdYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Kn7LKgsdM6VQidqe2kCAbJE76gPhZ9Q9gp3y9Uxe9B1A9mmwGBcY1YACFr5JV/ZOjQjQzHZX1fvIv2ur0X3VjvD+4nkbrYANeHed4MYfklM6o/mZI4NPqUC8CD+ATawzhWE+K1ePzNKa+KMXm1ZbxZvE6bnW0aZeILq4sAxWhpnq3m7g3ovtZq5nEhli+2u+qRDXphcKpb9Gg3JIH3N0TtfjU/NXo4kfMC1sL9qmVWEsd1U7PUib0SD8XTABfvs56o2PT+ubVAfF9Aipm81Dmn8s4SAdIDSeHFRLzpyQ3Aj75uCr27Tnt61l6a82AitinTvyqaUR+hU5hYXvfIThWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ig+rRKcR; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ig+rRKcR; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ig+rRKcR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ig+rRKcR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLS9q3rG7z3dX5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 19:17:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa4Mok84BgrIJ096oguK0x0r8biU2FN9KdJaqHRRdYY=;
	b=Ig+rRKcRmjrvPvilOR5uDqcc/ayENsEkUZ12BM+gDuHeqMnIPk/DD5x1mqek68Lf65QEaL
	drHrYS9XGnyLNAYkKs8+moAdlaMYAQKHtaH5Q5dqAzALZVEAW/kyr4DomF1syY/O7nBnUL
	JkxcZKn2w5RjxgYT8ZWIC/PHHlHz4vc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa4Mok84BgrIJ096oguK0x0r8biU2FN9KdJaqHRRdYY=;
	b=Ig+rRKcRmjrvPvilOR5uDqcc/ayENsEkUZ12BM+gDuHeqMnIPk/DD5x1mqek68Lf65QEaL
	drHrYS9XGnyLNAYkKs8+moAdlaMYAQKHtaH5Q5dqAzALZVEAW/kyr4DomF1syY/O7nBnUL
	JkxcZKn2w5RjxgYT8ZWIC/PHHlHz4vc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-nAFljNsZOpiYJ57hUOCZnA-1; Wed,
 25 Feb 2026 03:16:54 -0500
X-MC-Unique: nAFljNsZOpiYJ57hUOCZnA-1
X-Mimecast-MFC-AGG-ID: nAFljNsZOpiYJ57hUOCZnA_1772007412
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32EB918003FC;
	Wed, 25 Feb 2026 08:16:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A81041800351;
	Wed, 25 Feb 2026 08:16:42 +0000 (UTC)
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
Subject: [PATCH v5 13/15] arch/um: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:10 +0800
Message-ID: <20260225081412.76502-14-bhe@redhat.com>
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
X-Mimecast-MFC-PROC-ID: QH9DYDFE1DUdoIYFk2a5SkugzdsUQzkvGe0A-x1SGpc_1772007412
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

And also wrap up the kasan code into CONFIG_KASAN ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 89c8c8b94a79..2bf858ab35b5 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -62,8 +62,11 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+#ifdef CONFIG_KASAN
 	/* Safe to call after jump_label_init(). Enables KASAN. */
-	kasan_init_generic();
+	if (!kasan_arg_disabled)
+		kasan_init_generic();
+#endif
 
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
-- 
2.52.0



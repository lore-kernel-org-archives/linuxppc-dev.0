Return-Path: <linuxppc-dev+bounces-17164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39374EFD20A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:17:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLS9t4dqfz3dX7;
	Wed, 25 Feb 2026 19:17:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007426;
	cv=none; b=Xb/ZmfRXqAU/fechzdtqhZAhG5jjL4cp80ZMbgXARKoEOtfvLg1EO/tbpsErhnczttOC1K5yR/5xi3JmEHY8l5Knzx2lLVellRs/U5vIMeWtwB33rzlrFacHnRtcd5QbTVeaU+rMAdV+IfRC6/fFJsiCai4OxMHOutP7fAdM5XWwFUkUbPluhp9+MGGaILWY9idpg3JH28TzQBB9/2rNJlHBxKVi4PEdgjgkZuygudbwQaObfZ0pLQulCP7vVbQcNuZPaAOh6+hwjl1Wyfs7AWhw05+F81aDIDPioef/0Zg8IMlrr2Po3ur3LpIw1LT7yjNJ7l4D/DhB1ZrD2UhINg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007426; c=relaxed/relaxed;
	bh=yJ/15auNTcs4bEnKE4TKOadihs1pA/T7OdgqiTtaDyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=YTBtqA9C4kbpNpuSo803Jha76ZLa/Snu90iq6t+fv2W3AANHqlbJlBPukrERSGyj3cf0RgUQfrdj+zdqrLa5PAXQSKPsDVtTwFn5f+nDbgZekqJCe2T/V3pQ1DhHnv55RQx6kzOQUk9Pgiw+nd8DKhFrFvkYFKZNRN/VeqvNuVNWnKBsBHY/QDzDjzrgTzkRy9JHwszVswbcDUU/NfZh87CXzlQMH3wja6/2LY7OvI3AuM2Mr8zalgy+C9o7v0XsCA98T83BSATlw2XIEElkFovtg+01RTp1ncwfOXxgT+x++MapYvVsYJBUKCQI0dtWjziJqcvbVJlu7tkQ/HfsNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9qhd6Bo; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOoen/vw; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9qhd6Bo;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOoen/vw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLS9s4c3Jz3f1r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 19:17:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/15auNTcs4bEnKE4TKOadihs1pA/T7OdgqiTtaDyY=;
	b=Q9qhd6BoKk25/pDR1ffVxRvMTUCEb8owcd4l0GY9vah8KPb2RrvtxOESICBzhS4v1fEIqt
	Df0AgoQbW/6+gzmXrfCDUJc6BPww9nwyf7EOcSRHikAMePojL4qoPTfxoxKePrZ7IOl5h3
	LY1ZkZHyuRSMNyM3W87CfKTAqzE86Rg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/15auNTcs4bEnKE4TKOadihs1pA/T7OdgqiTtaDyY=;
	b=iOoen/vwp+ia4RQ72J6I7gaFI4EShd9ePvCzaKGHTSVpqzNdGLVHhAAhLJCl00i5F9AbrG
	rw4BnKlleM7aZulu+M/tTmKzHCO4GmRciVfRcCK9f66AHaI4UFT2VlGlhkmXSTUIe7Jx3K
	UfAoilVrtiYzzmJXmRzPGgAh1baT/Io=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-MO7Loi8qMuGy7jOa06YqRg-1; Wed,
 25 Feb 2026 03:15:25 -0500
X-MC-Unique: MO7Loi8qMuGy7jOa06YqRg-1
X-Mimecast-MFC-AGG-ID: MO7Loi8qMuGy7jOa06YqRg_1772007319
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320AA1800349;
	Wed, 25 Feb 2026 08:15:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFB231800465;
	Wed, 25 Feb 2026 08:15:08 +0000 (UTC)
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
Subject: [PATCH v5 04/15] mm/kasan: make kasan=on|off take effect for all three modes
Date: Wed, 25 Feb 2026 16:14:01 +0800
Message-ID: <20260225081412.76502-5-bhe@redhat.com>
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
X-Mimecast-MFC-PROC-ID: bcaggeRTtf809QkySRqAw7JQvAx7dUEKHMIojEzHdlM_1772007319
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Now everything is ready, setting kasan=off can disable kasan for all
three modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h | 12 +++++-------
 mm/kasan/common.c             |  4 ----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index b7cb906825ca..cec21a08446e 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,10 +4,11 @@
 
 #include <linux/static_key.h>
 
-#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
+#ifdef CONFIG_KASAN
+extern bool kasan_arg_disabled;
+
 /*
  * Global runtime flag for KASAN modes that need runtime control.
- * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
  */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
@@ -25,18 +26,15 @@ static inline void kasan_enable(void)
 	static_branch_enable(&kasan_flag_enabled);
 }
 #else
-/* For architectures that can enable KASAN early, use compile-time check. */
 static __always_inline bool kasan_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return false;
 }
 
 static inline void kasan_enable(void) {}
-#endif /* CONFIG_ARCH_DEFER_KASAN || CONFIG_KASAN_HW_TAGS */
+#endif
 
 #ifdef CONFIG_KASAN_HW_TAGS
-extern bool kasan_arg_disabled;
-
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return kasan_enabled();
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0d788a468e96..fc6513fa5795 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -33,16 +33,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
-#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
 /*
  * Definition of the unified static key declared in kasan-enabled.h.
  * This provides consistent runtime enable/disable across KASAN modes.
  */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
 EXPORT_SYMBOL_GPL(kasan_flag_enabled);
-#endif
 
-#ifdef CONFIG_KASAN_HW_TAGS
 bool kasan_arg_disabled __ro_after_init;
 
 /* kasan=off/on */
@@ -61,7 +58,6 @@ static int __init early_kasan_flag(char *arg)
 	return 0;
 }
 early_param("kasan", early_kasan_flag);
-#endif
 
 struct slab *kasan_addr_to_slab(const void *addr)
 {
-- 
2.52.0



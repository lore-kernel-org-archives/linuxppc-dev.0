Return-Path: <linuxppc-dev+bounces-17160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9DEFD20E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLS9P5m63z3dW8;
	Wed, 25 Feb 2026 19:16:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007401;
	cv=none; b=cJrxfE93v3L1VDNBGbd/LoTwusg12WykebA0DmAXs+KugeU/dXI+RKlhhUkl1bLiyuPWnDwrYAledBB/s3NcDZyStVhpDM+D2gcwGdtb60yoHUm1DV3I88zr/KaRYeo0H48l255px2uEYUIteM2AlMitrgY7LeFOc/nL6l5RddsTDHIfNX3XyVWZlD1i/UkkskdsQHCk50Sp07E05glejFOvdpiUQYcHcf62DG8VjAln2d/MHtfi+hXCd88NRrlavhVIZ2cDaLaGuHFY7lojmdFXZxr0Arm06cctvT8tTVeAfVNexYGcBEuTjXXz8xPza/aUOPqH+g7f8vslCeexFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007401; c=relaxed/relaxed;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Cw63tguJdUYlmT2MtKK0cpandTyBAcqxE/uWSC/Ox4WJt4+y/U/f+6KrdYtmVvtVBa6NHPtOKScNnGWpr80mjbwAW2D8FlPjM6M1g7teqvkg2qBEVsYSPn8K3vpBB3tTKkgeUmltXcX/kRgLvAIfIC4Y/u59EpHMo/VJy4bZl7Y/RLWrbH+9ciaiobe9iumgAB8N37pBuuaAO//F9y3iSc8XVlA/I4iwDhcoBexD4JPCVES1YvK5D3Ssu4tS96P8q6DL/6S6tAGePmTIizKIXf9tMKbWDR5A/14WpnHku+2JmusIO5AeiWCGVRh5D01dDskiaeiCqaVtVbiWld20Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aUpOWsed; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aUpOWsed; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aUpOWsed;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aUpOWsed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLS9N6Gymz3dW6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 19:16:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	b=aUpOWsedXQojrRpMj4t/DUX9sLSzAdJ0YFdiH/ytWUD5MjCc08kJSltqdOfS7K7AAKQPhg
	ytt8OaFrOmAdehF7EyNwn5In/j7G1yN8CrSkwhH0tU7bIvgIRA8sxdRoVke4Cvw00ViBeY
	kAhmsDjipSoNsE9JuDJpkbqNBfnxQKA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	b=aUpOWsedXQojrRpMj4t/DUX9sLSzAdJ0YFdiH/ytWUD5MjCc08kJSltqdOfS7K7AAKQPhg
	ytt8OaFrOmAdehF7EyNwn5In/j7G1yN8CrSkwhH0tU7bIvgIRA8sxdRoVke4Cvw00ViBeY
	kAhmsDjipSoNsE9JuDJpkbqNBfnxQKA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Jj4asdUeMuyAfccAe_OsEQ-1; Wed,
 25 Feb 2026 03:16:33 -0500
X-MC-Unique: Jj4asdUeMuyAfccAe_OsEQ-1
X-Mimecast-MFC-AGG-ID: Jj4asdUeMuyAfccAe_OsEQ_1772007391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B293618005BC;
	Wed, 25 Feb 2026 08:16:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C45A1800465;
	Wed, 25 Feb 2026 08:16:20 +0000 (UTC)
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
Subject: [PATCH v5 11/15] arch/x86: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:08 +0800
Message-ID: <20260225081412.76502-12-bhe@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 8_J_TgiED7LwZqqTa4buVELmlOETuNi4twDc5a-HeyU_1772007391
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/mm/kasan_init_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 998b6010d6d3..5ebf2850c77d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -343,6 +343,10 @@ void __init kasan_init(void)
 	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
-- 
2.52.0



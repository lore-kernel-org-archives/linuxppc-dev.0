Return-Path: <linuxppc-dev+bounces-17157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB02EFD208
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLS8m2C6lz3dVf;
	Wed, 25 Feb 2026 19:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007368;
	cv=none; b=nOnGzs8axR0XIMfzk2krIBGuCoLTIE+pE9O4qqgE23v+yUpi5RZyIFcS3hSJMt1RmR0NAHKc2FW4TDAb1DnHVZEDjPecNa/lT+iRGERqxgk4ILIk9JBKndstrM5RO82GHowR79zGMArTg3HuXnT1j/JVqB1cl/GBV5O/3qmXL5t3BQJEm62EkK8KMYiIa02lMcROcBLQdFFjmBPLnNREt4+p1hfki+8nTAE2l4QA6UQi6iGRA2ib6YkLZKdoCGJByZbWsmaZ6fr9mSYzFldbDqSrDRjDmMzPQqhWZBykZ3MlLk05Au/8rUKpPzy2fYlRwVrgLvdyC0XZ6ngBwD85Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007368; c=relaxed/relaxed;
	bh=19vaP3y5lR+93yTFpmYDfoD2vHNlJZSHy6oOHn35u4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=NguJJewtRcBNYHHbI3Tnl8OAkviyaGXE9UQFLg90JSUY6pLCEz0rZkCiNhsusTq4EoaL542yRlgd5RNkILGQe0KXL5fP5immvFSatXjQPLWVKV2WTlDuHAlId1EGSDmI2vekgZjvm2NtkurtP91imkIEhUf/XZNyN6n7YJVsMHm7HP5rd3dq8CfcorHtN9nNcI5pebbpUkmPLyz98JPXnvoqNYcr60NdMWsAoj7j54LZ99LCnGhs2IeqOD5U//qqszqQ28Cw508YHat/0VMFymTum4d3tiALW72AipWZJsMgOk1IlHNZEArG3Oweo0lkDp3usEFZaUUfALVBleNFIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGqHqNhv; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGqHqNhv; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGqHqNhv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGqHqNhv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLS8l3FXYz3dXC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 19:16:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19vaP3y5lR+93yTFpmYDfoD2vHNlJZSHy6oOHn35u4M=;
	b=FGqHqNhvHyj4ogM9d437AJZMOmNwcbrAbzhWHw5ZM6OKF626Y1BD5JdLs1FGgPKUY5pjF+
	/WR9927+PJ5ejhyM6AQ5q9O5LeKpDKdTslUxYAjbOXTd86VVOzUUHI7ze9YE3Yo06sdvYR
	U3ibOyuubt91n4Xe3Z5z8nW7shs/IQ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19vaP3y5lR+93yTFpmYDfoD2vHNlJZSHy6oOHn35u4M=;
	b=FGqHqNhvHyj4ogM9d437AJZMOmNwcbrAbzhWHw5ZM6OKF626Y1BD5JdLs1FGgPKUY5pjF+
	/WR9927+PJ5ejhyM6AQ5q9O5LeKpDKdTslUxYAjbOXTd86VVOzUUHI7ze9YE3Yo06sdvYR
	U3ibOyuubt91n4Xe3Z5z8nW7shs/IQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-fNbyuKNINK6CJvlLPKrBfw-1; Wed,
 25 Feb 2026 03:16:00 -0500
X-MC-Unique: fNbyuKNINK6CJvlLPKrBfw-1
X-Mimecast-MFC-AGG-ID: fNbyuKNINK6CJvlLPKrBfw_1772007358
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83A1E18004BB;
	Wed, 25 Feb 2026 08:15:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0B361800465;
	Wed, 25 Feb 2026 08:15:48 +0000 (UTC)
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
Subject: [PATCH v5 08/15] arch/loongarch: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:05 +0800
Message-ID: <20260225081412.76502-9-bhe@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4P96XGSzDWNsBCGVTL2vqMwyCb3VhPZbXFZV7-R4dVo_1772007358
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/mm/kasan_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 0fc02ca06457..047a059544e1 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -269,6 +269,9 @@ void __init kasan_init(void)
 	u64 i;
 	phys_addr_t pa_start, pa_end;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
 	 * overflow UINTPTR_MAX and then looks like a user space address.
-- 
2.52.0



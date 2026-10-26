Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5936606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/jb4SfZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrlF2Pl0z2yR1;
	Mon, 26 Oct 2026 22:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013625;
	cv=none; b=E1351sZNdVbPQNie3cItdnP2lq7DtJtbAkknsXRz7/w5GHR5eGv4K6+zPk6M40h3MCQrh/quDttYUTtNnt4renT1YyVqIIZqSYkoV0sXcRmp3TBiwvk+HS7vnob1D+wA5A139LHNhKwuSoXnle5UNSZiRYJoWJXsWA0iwyJd/Yn7SADpLsUjHNt0H20GWlfQDRpMto4CGozfP8jytRNVyDXmomAaW6RTX1G3sWbsqSpGqv+KhtG+H2er3qiBIiobCtTgQGqqhGi4XHXYKtaLvcmF/KYy4RhQk2+2TDq58F0Lp3S9xgMqrU9rK4dk8j7wdi+J04YXLJ4xiQbEqMkGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013625; c=relaxed/relaxed;
	bh=bM61ehpgyizAvovaUdB8zXiHVxWcqVnRNJf7TtcRJMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gSNQL5zeBky4A2sRAU0WjUm72caO1U8UVDIjVqccjYqbstzQEITJ5tfoQaz1/JOWfvl2l6zB87CTC+zwQW9GmDkPnkrgQkrkZNJ9MBXm5qcMClHTCnQWz2YXUzCTgyKEZat4LYkpf75nXAdRyudYkZMPcuu9/sZQw14nPkcP79sQ2KsAJM1t83v7e93VCgI+iZ9rLVKsxp9W2xzEKfKWu3ZN6sFsFLcSnv0vK5iIAQm5hUSG6VEB7r07cruva9oZkSoTYdaATd/uCwhQ3U5hdGLUIgKSOXq/AG69pFu6LVCqolq6JwJoejKsBEfpvKBRuiQsMK0iKQ74NjndV5P7Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/jb4SfZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/jb4SfZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XciNT6Me;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrlD3Rlrz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:20:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bM61ehpgyizAvovaUdB8zXiHVxWcqVnRNJf7TtcRJMI=;
	b=XciNT6MeX6v8J1hwC/kN6VSpGVbaCqeOCrWH8Tg+A9b34L558SGGLSS7CYqwaUeuO+lTLK
	S3c+6lt0wq/C7weL4NKY0dps30gQO3faIaAQZkoGxiTs4PlAjYDReXvmRgca4n12TTlayg
	7Vngdyvrn/1CLs9M7OJMryUHzv20dao=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bM61ehpgyizAvovaUdB8zXiHVxWcqVnRNJf7TtcRJMI=;
	b=d/jb4SfZiqfi2tHhRa0zUdTGhfsIRf3rFEq+PQI+96VdDPE8rtE5u1MoEY7Jem1EVFLKg/
	VS/d4LVkVvaluA8UUfSA0jg2QUVrBGGvFME2Hl3vllPXQpJqBDzKjSXxTvgc7q+X51cYWN
	my8JZgrST7Hw0H3RONcXv8/blfRfDCM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bM61ehpgyizAvovaUdB8zXiHVxWcqVnRNJf7TtcRJMI=;
	b=XciNT6MeX6v8J1hwC/kN6VSpGVbaCqeOCrWH8Tg+A9b34L558SGGLSS7CYqwaUeuO+lTLK
	S3c+6lt0wq/C7weL4NKY0dps30gQO3faIaAQZkoGxiTs4PlAjYDReXvmRgca4n12TTlayg
	7Vngdyvrn/1CLs9M7OJMryUHzv20dao=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-CumeemOmOJOuBM2QvMTNQw-1; Mon,
 26 Oct 2026 07:19:10 -0400
X-MC-Unique: CumeemOmOJOuBM2QvMTNQw-1
X-Mimecast-MFC-AGG-ID: CumeemOmOJOuBM2QvMTNQw_1793013547
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E64C1956094;
	Mon, 26 Oct 2026 11:19:07 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44ADF1956087;
	Mon, 26 Oct 2026 11:19:01 +0000 (UTC)
From: Jerome Marchand <jmarchan@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH 6/7] asm-generic: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:21 +0100
Message-ID: <20261026111822.458404-7-jmarchan@redhat.com>
In-Reply-To: <20261026111822.458404-1-jmarchan@redhat.com>
References: <20261026111822.458404-1-jmarchan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: k6fn7bhuBenpG42PiVbfKUkXIhp2EHG_l_ZrsIsAoC8_1793013547
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While working on a fix for a tracing soft lockup, it came to my
attention that __local_dec() was broken on ppc64 and other arches (it
actually increment the value). My first instinct was to fix it but the
fact that this function was utterly broken for so long, decades for
some arches makes me thing that those functions have not been used for
a long time, if ever.

Anyway, they're not used now, so remove them.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 include/asm-generic/local.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index 7f97018df66fe..4bb458b57d470 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -47,11 +47,4 @@ typedef struct
 #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
 #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
 
-/* Non-atomic variants, ie. preemption disabled and won't be touched
- * in interrupt, etc.  Some archs can optimize this case well. */
-#define __local_inc(l)		local_set((l), local_read(l) + 1)
-#define __local_dec(l)		local_set((l), local_read(l) - 1)
-#define __local_add(i,l)	local_set((l), local_read(l) + (i))
-#define __local_sub(i,l)	local_set((l), local_read(l) - (i))
-
 #endif /* _ASM_GENERIC_LOCAL_H */
-- 
2.56.0



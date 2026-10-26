Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BC606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrjr4M9Vz2xSF;
	Mon, 26 Oct 2026 22:19:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013552;
	cv=none; b=jYo5ZSFJaA+2iwrrGr/AOksi2x//E2HLt/VZV00TP327L8vAabuXI+/Z8I0QY3oodi6sDbFQLezrvpSncKcwMghnngvColatlFw3Ercux5nSXdkgeaHXNj+01mrDjVDUS17WReqwkeB/jf8h4bbwmcTLqHSOkBhBmVVRj0cLfF7B1Ajrn6Wedhp2Tc16UXMaVFfMGI/tlEvRLmVS2sj/BdC5F0qOApxwdwhYvh1T3jAzFDmHS5NG6n3KLecHCa2ll4mIfW2Tp2v3XRhFHMnO7bXnHs7D4JItUy0zAzxnVdQdq94fZSIjG/WvptTOqHsxGJAEiKzgKDHAiIsvyne/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013552; c=relaxed/relaxed;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GR3JddhNX33hjShOH3cLVodhigIi/I5qYOJsXNLlUulGp5Gw7T2a/vOxIfl92oW48+R7dB0SJL+GlNGDd0JtaIRAmLq0/z5Q4zJv305tXR5gRRROHRt3Ifu1AO4YURxQigYrbAngr07yWhSajTlvgzpBPtT5ynC6fa/J5RcUCUZe+/xq+rKo0boThretK7spHEUA4YSsx9m2BK+QO++FdS376FkvxYw8z0p6ZSOZm8yHrDFJchgwmiaMBXUVBoPNFWTv1e9TiIFAoxHoHxeM5i52LiAHi83iV6ToAZc4ks5BUoKEinrKEf2lV23LEnRyv3bJgGhqjryfl/rWgIUrWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRX/ju/1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrjq44rPz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:19:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	b=NRX/ju/1E0ccznXFasKPE8X7YWvCXDE4gsWAQ75fSz4AHjXCMu0WErLseSUenbkKRUNoY9
	PFZ9p58vK9B8eYJ2dDcXgmVgbLvheFT5tZgqsPEDZbQtTqlD8bM0xz6C81o12rbeL4ol6O
	7yX3plI8Q7F6RiLzfI+fhtQ9b5h65WA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	b=NRX/ju/1E0ccznXFasKPE8X7YWvCXDE4gsWAQ75fSz4AHjXCMu0WErLseSUenbkKRUNoY9
	PFZ9p58vK9B8eYJ2dDcXgmVgbLvheFT5tZgqsPEDZbQtTqlD8bM0xz6C81o12rbeL4ol6O
	7yX3plI8Q7F6RiLzfI+fhtQ9b5h65WA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	b=NRX/ju/1E0ccznXFasKPE8X7YWvCXDE4gsWAQ75fSz4AHjXCMu0WErLseSUenbkKRUNoY9
	PFZ9p58vK9B8eYJ2dDcXgmVgbLvheFT5tZgqsPEDZbQtTqlD8bM0xz6C81o12rbeL4ol6O
	7yX3plI8Q7F6RiLzfI+fhtQ9b5h65WA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-8T1mK9NyPHKuQWwejArigw-1; Mon,
 26 Oct 2026 07:19:03 -0400
X-MC-Unique: 8T1mK9NyPHKuQWwejArigw-1
X-Mimecast-MFC-AGG-ID: 8T1mK9NyPHKuQWwejArigw_1793013541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB69D1955F19;
	Mon, 26 Oct 2026 11:19:00 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A52BA1956087;
	Mon, 26 Oct 2026 11:18:55 +0000 (UTC)
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
Subject: [PATCH 5/7] x86: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:20 +0100
Message-ID: <20261026111822.458404-6-jmarchan@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OE22BsOJVDkQIXF_3L29CcTLzTUBNwJPmbaIevie9Cw_1793013541
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
 arch/x86/include/asm/local.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 68af7b74450af..6d0bca91915cd 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -170,13 +170,4 @@ local_add_unless(local_t *l, long a, long u)
 
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
-/* On x86_32, these are no better than the atomic variants.
- * On x86-64 these are better than the atomic variants on SMP kernels
- * because they dont use a lock prefix.
- */
-#define __local_inc(l)		local_inc(l)
-#define __local_dec(l)		local_dec(l)
-#define __local_add(i, l)	local_add((i), (l))
-#define __local_sub(i, l)	local_sub((i), (l))
-
 #endif /* _ASM_X86_LOCAL_H */
-- 
2.56.0



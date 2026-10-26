Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55159606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrks5dpYz2yPR;
	Mon, 26 Oct 2026 22:20:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013605;
	cv=none; b=MdP1ytYUUwD6/YhFMrE99/5+6FQ8HjhzFIkI2M3CnGOt+SwwfqbkK268K9kFNjqvM9XD1YVJLdHq2boH5v7gWQ/hm9AgVjoHR/lV9OzFDzHwzWXs7keClNtmsCmQZKWKPNvqxAz68Bu5HRr+gCPgWtXlcrRkedbopp2/sXeWyitvoCvWergZLzwwpZozIvMdLkjIsrcp0IjpX4GLgEyukFAMIGPNNtolxPdCLDdQh3F5UyMBsKo75xEll2rG71ZtLDYaWUq1k5z9UDzWqV0L9iCVw+9Kv85T7oaZs0uAsyXdu6W/tq8ff0DmSCrK+BiTMrNoLxVNUd2IdHCVPgzWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013605; c=relaxed/relaxed;
	bh=WoLSU0BjIbmp7+7g1f+xo2mz3fVrgAdefYVwWYlLpDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H22PaXtYYcUSvXhup8lZw/baDYpk76069g4VFDU0KF6DntfXC20GMToqJJalxcfboSxaEniKrd/fPc3ZYdTQeJdRKs9D9fiZQtYAX17PR5wfHfleCdxuF/cGvMLvuN1trJn0YsQD0yTUrQFIOJfiPvR7vuF4XWHh9O2DKXhzeuVWpM/P0JqqzPwqzmH4loM/zjoT3MhFebwvEN/PHCmokOW8UUll5OaqUlySDzvxKwLJPiZ7fqhlXqNhuOAUT9E5fumCJu5d+aRuBsIhsBE8z+AXVPDVzQkTyYNV33VS2qw4H0M2EnX3m4jOdEWUYBudnjB/qi/y3U5SeaJBcupjOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzLUFzxN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 81 seconds by postgrey-1.37 at boromir; Mon, 26 Oct 2026 22:20:04 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrkr4WBvz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:20:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoLSU0BjIbmp7+7g1f+xo2mz3fVrgAdefYVwWYlLpDI=;
	b=NzLUFzxNhMjhHex+yrRSq2TDECGVzBjDpwEe7dn6gj7t9Wo9mWoeGYOIrI0z8GN1cFyYF7
	75vBT+75hqJplk/TG5VD5slPj3CBjLlt1egZh+cRWZDO0bZU/pElu+P41Vly6zFCHEMuWG
	atSeOdehoO2tuUU1ngwXBF7lgIXxF54=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoLSU0BjIbmp7+7g1f+xo2mz3fVrgAdefYVwWYlLpDI=;
	b=NzLUFzxNhMjhHex+yrRSq2TDECGVzBjDpwEe7dn6gj7t9Wo9mWoeGYOIrI0z8GN1cFyYF7
	75vBT+75hqJplk/TG5VD5slPj3CBjLlt1egZh+cRWZDO0bZU/pElu+P41Vly6zFCHEMuWG
	atSeOdehoO2tuUU1ngwXBF7lgIXxF54=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoLSU0BjIbmp7+7g1f+xo2mz3fVrgAdefYVwWYlLpDI=;
	b=NzLUFzxNhMjhHex+yrRSq2TDECGVzBjDpwEe7dn6gj7t9Wo9mWoeGYOIrI0z8GN1cFyYF7
	75vBT+75hqJplk/TG5VD5slPj3CBjLlt1egZh+cRWZDO0bZU/pElu+P41Vly6zFCHEMuWG
	atSeOdehoO2tuUU1ngwXBF7lgIXxF54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-DPmm086NN1yVCgZEC1vTsQ-1; Mon,
 26 Oct 2026 07:18:46 -0400
X-MC-Unique: DPmm086NN1yVCgZEC1vTsQ-1
X-Mimecast-MFC-AGG-ID: DPmm086NN1yVCgZEC1vTsQ_1793013523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BB43180059F;
	Mon, 26 Oct 2026 11:18:43 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B64E1956087;
	Mon, 26 Oct 2026 11:18:37 +0000 (UTC)
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
Subject: [PATCH 2/7] loongarch: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:17 +0100
Message-ID: <20261026111822.458404-3-jmarchan@redhat.com>
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
X-Mimecast-MFC-PROC-ID: I3PbHza4dxz4yMACm9qqc6-TIhYNIiKoB_yhGJI0NvM_1793013523
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
 arch/loongarch/include/asm/local.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 2d118b1a060e4..d649b9867ba25 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -175,14 +175,4 @@ local_add_unless(local_t *l, long a, long u)
  */
 #define local_add_negative(i, l) (local_add_return(i, (l)) < 0)
 
-/* Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-
-#define __local_inc(l)		((l)->a.counter++)
-#define __local_dec(l)		((l)->a.counter++)
-#define __local_add(i, l)	((l)->a.counter += (i))
-#define __local_sub(i, l)	((l)->a.counter -= (i))
-
 #endif /* _ARCH_LOONGARCH_LOCAL_H */
-- 
2.56.0



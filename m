Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF01606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrl40Yrvz2yPq;
	Mon, 26 Oct 2026 22:20:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013616;
	cv=none; b=I3y+dV67zTgBqtWV2cM9dQGTRR7Xlk5axjM22czYwaq2+JRhZbLTlqLRiGTk5jXYqE73uvHz8NDyfYccHIv90ZqL+KLyjx8QZZqMmytHP3FGqzPQGmwHhU1067AQooW6rcyPM+pXRQovc7VInKeS1ziVahO0q52oHiqH/jj3ogAUsvvp+nZdzzPPGPwpiZiQopa5gfhlGABEHsUzUw++VLBGM0oLjYclSJ9Za8IKoidCkrNJAeJUMTqMlNcv1tHEPymPvm6QbMQ3aHinH1NZ3ZEfeXogPsKTQqySg51GgtiDGE7SARGY8ELEnQE3LhUt6ox733w1MkcBRzzE70Spow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013616; c=relaxed/relaxed;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TqrO2Cm1JlreyIo1A7gQHmrzaxKWIfO9yEHom7FxkgeFjM7rkiC/kZDsGO70dphKtn3dEsyLWTLLNagxCERmOKOttwIh59NlPf4AwlsJNoMjV5Y3Yy/hkGtMQv3wt2FXK29t3KLrsB6Q353sISpYcO7FO4n1cE0UHTd0Xu3qL7zN8MvawzrCDcSLJk8AMXqbWi/+0RkowJ/PEp0KKsqYciE3CQoQkavcAAdt7XF7z5YbEIbQQ4ri4ajGtcf7sqhbegguWUzhXc6BfhuwcGrzsSM+QXyEq4dnnKL+XF8mIlrbf3aIUixPSOwRDzsARdRRSQnYgsunzIPJl7F56RmnTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f20f/UlS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrl30488z2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:20:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	b=f20f/UlSMhwLITUm/Rk5zc3WkbrLdwyPiBsZRVYwlR+ZINkvHSbbViWkOhSLUl9fYwodIe
	lZvRMU4UOdW8H60sl6NNp+BFrNgQVQFG/A0VvbtHJsRx0w8qaCqTDz6xFQjyj+ro2HrFVP
	3rQZKfG4sJmHYRxzCaVhHhdJxVhIDc8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	b=f20f/UlSMhwLITUm/Rk5zc3WkbrLdwyPiBsZRVYwlR+ZINkvHSbbViWkOhSLUl9fYwodIe
	lZvRMU4UOdW8H60sl6NNp+BFrNgQVQFG/A0VvbtHJsRx0w8qaCqTDz6xFQjyj+ro2HrFVP
	3rQZKfG4sJmHYRxzCaVhHhdJxVhIDc8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	b=f20f/UlSMhwLITUm/Rk5zc3WkbrLdwyPiBsZRVYwlR+ZINkvHSbbViWkOhSLUl9fYwodIe
	lZvRMU4UOdW8H60sl6NNp+BFrNgQVQFG/A0VvbtHJsRx0w8qaCqTDz6xFQjyj+ro2HrFVP
	3rQZKfG4sJmHYRxzCaVhHhdJxVhIDc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-bMNloqC3PyWcCfI9gS9TKQ-1; Mon,
 26 Oct 2026 07:18:58 -0400
X-MC-Unique: bMNloqC3PyWcCfI9gS9TKQ-1
X-Mimecast-MFC-AGG-ID: bMNloqC3PyWcCfI9gS9TKQ_1793013536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4904D195604A;
	Mon, 26 Oct 2026 11:18:55 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E458195608A;
	Mon, 26 Oct 2026 11:18:49 +0000 (UTC)
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
Subject: [PATCH 4/7] powerpc: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:19 +0100
Message-ID: <20261026111822.458404-5-jmarchan@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 5v4OV0ddPDqLXnTmGjFSHsoJVfr5FgRqtu45hKOdV88_1793013536
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
 arch/powerpc/include/asm/local.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 4c033526bfb0d..24ac534cf809a 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -140,16 +140,6 @@ static __inline__ bool local_add_unless(local_t *l, long a, long u)
 
 #define local_inc_not_zero(l)		local_add_unless((l), 1, 0)
 
-/* Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-
-#define __local_inc(l)		((l)->v++)
-#define __local_dec(l)		((l)->v++)
-#define __local_add(i,l)	((l)->v+=(i))
-#define __local_sub(i,l)	((l)->v-=(i))
-
 #else /* CONFIG_PPC64 */
 
 #include <asm-generic/local.h>
-- 
2.56.0



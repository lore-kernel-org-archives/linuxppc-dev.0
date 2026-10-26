Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAD606A31D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrm05pNCz2yVB;
	Mon, 26 Oct 2026 22:21:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013664;
	cv=none; b=LPnnrDgRNMCPUMz8yqIuz6i1IScShh7YDGdKif80gkv1/8Lre5p9F68D9p6akTwCLzVNQ/OjyOi4fpiQKOozcqtuLG14fM2S/jLpdD7le8jplWlSEtzfIU0dR2l8Wgzej525SfOwas64ags7MuvmqhA4fi0P33eEgtMT9oGZgiABafdEhP0d0TrQPh5H+8kTGa49IYjIGrmdWyyPX7okHRm6IUJyxf64IUE8xF/83Q6ueZ/RgSCGx6Tixp4X00ooIoNPja/eZxS5B42ZS2dsbAdvFu2LZmgg40w3zyTqh6bGRMJ2ANXwgbhiJAayue9Fl8y1ZmHEf+35Nlj+rz8iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013664; c=relaxed/relaxed;
	bh=Jsb8n2PnG62q8kRquOJFB0kDepBKTWthhPmFyD+4b2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DKh8C7UjT3NqLlFXVn29oc/lBQYF1ylE8uE0aLrimSf5UDnO7uf+vg5aZb5bPhRMZDYVXuazopVU+7BRxK6Psaong7/yRIAFh5Pjim2w7oFKliluxdrjiyNZLRzuk+fur8/uXKRKZ41cT+Tb0NSuD8LpHMJ2A8jzKOJkIwA6RZwkdRt6EWJmp57vKACIl5QRmGFsQwNV/C3XpnBjHC0jMTJWvTWz9/sGlw8msjBiiWJAHSmyojMwYxViG+SjNnEM3CYATflAz49gfZr9yPNH66W+dJ0+EqF+9+Gt29LP6+IlqRyJKL4bowekaNjA9XQSou9AwZ3o2eeHULXCsENekg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyf5N95;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrlz6s7gz2yTK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:21:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsb8n2PnG62q8kRquOJFB0kDepBKTWthhPmFyD+4b2I=;
	b=cvyf5N95j15XApPDIF2QEMAgiBX9+Cx/OSMcRJJ2B7w9aD5YXoojH3d2Hmud4Tsf6ChgxT
	0uxSHrBXo/6mpABr8zCESE5strVQJKwdCWgnnOZ1XnrS+NxqFXcEeA3NIp79K+0OGHAWKn
	yziQX2cJXsz/XBFahKUiGII1AiO2Aw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsb8n2PnG62q8kRquOJFB0kDepBKTWthhPmFyD+4b2I=;
	b=cvyf5N95j15XApPDIF2QEMAgiBX9+Cx/OSMcRJJ2B7w9aD5YXoojH3d2Hmud4Tsf6ChgxT
	0uxSHrBXo/6mpABr8zCESE5strVQJKwdCWgnnOZ1XnrS+NxqFXcEeA3NIp79K+0OGHAWKn
	yziQX2cJXsz/XBFahKUiGII1AiO2Aw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsb8n2PnG62q8kRquOJFB0kDepBKTWthhPmFyD+4b2I=;
	b=cvyf5N95j15XApPDIF2QEMAgiBX9+Cx/OSMcRJJ2B7w9aD5YXoojH3d2Hmud4Tsf6ChgxT
	0uxSHrBXo/6mpABr8zCESE5strVQJKwdCWgnnOZ1XnrS+NxqFXcEeA3NIp79K+0OGHAWKn
	yziQX2cJXsz/XBFahKUiGII1AiO2Aw0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-Bu33x-t4PUy_yTIIX_4dyA-1; Mon,
 26 Oct 2026 07:19:16 -0400
X-MC-Unique: Bu33x-t4PUy_yTIIX_4dyA-1
X-Mimecast-MFC-AGG-ID: Bu33x-t4PUy_yTIIX_4dyA_1793013553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D97671800632;
	Mon, 26 Oct 2026 11:19:12 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9ABDE1956087;
	Mon, 26 Oct 2026 11:19:07 +0000 (UTC)
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
Subject: [PATCH 7/7] asm-generic: Remove the unused non-atomic local64_t functions
Date: Mon, 26 Oct 2026 12:18:22 +0100
Message-ID: <20261026111822.458404-8-jmarchan@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6l7LIhJIBDodoYFvOgTUoMtzz07JAAVyxZyDQqs9N2o_1793013553
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

The local64_t non-atomic functions aren't used either, so remove
them too.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 include/asm-generic/local64.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 14963a7a62538..b30ae05f42b95 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -56,13 +56,6 @@ static inline bool local64_try_cmpxchg(local64_t *l, s64 *old, s64 new)
 #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
 
-/* Non-atomic variants, ie. preemption disabled and won't be touched
- * in interrupt, etc.  Some archs can optimize this case well. */
-#define __local64_inc(l)	local64_set((l), local64_read(l) + 1)
-#define __local64_dec(l)	local64_set((l), local64_read(l) - 1)
-#define __local64_add(i,l)	local64_set((l), local64_read(l) + (i))
-#define __local64_sub(i,l)	local64_set((l), local64_read(l) - (i))
-
 #else /* BITS_PER_LONG != 64 */
 
 #include <linux/atomic.h>
@@ -95,13 +88,6 @@ typedef struct {
 #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
 
-/* Non-atomic variants, ie. preemption disabled and won't be touched
- * in interrupt, etc.  Some archs can optimize this case well. */
-#define __local64_inc(l)	local64_set((l), local64_read(l) + 1)
-#define __local64_dec(l)	local64_set((l), local64_read(l) - 1)
-#define __local64_add(i,l)	local64_set((l), local64_read(l) + (i))
-#define __local64_sub(i,l)	local64_set((l), local64_read(l) - (i))
-
 #endif /* BITS_PER_LONG != 64 */
 
 #endif /* _ASM_GENERIC_LOCAL64_H */
-- 
2.56.0



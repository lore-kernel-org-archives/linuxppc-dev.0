Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E5606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrkt5plyz2yY0;
	Mon, 26 Oct 2026 22:20:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013606;
	cv=none; b=H5HKl573qG7yWju5tF4xSWOaQwlDaN2GfOD2piQOTjmQSAZLMBpjYHrr8skxZjO84Tk1U+8Kh1WWl4Vym6sS+OLsneCILbV1XwCpLuVb4P9TGuUI8y3hIBMV2hfU3+G6y4UnmwTVCGi56/OARpAWPSid2Bz5qPuIz3DeXnhjJtDbyRr/R/g8n0k1F9dagedRlXKKcL/dzxFa2V17HiaxKzqEZVv6RcXt8GnV5o+CQQWKrvaspSWCHp4G1Un1DXjtrpClAuILZYpyfZKxUJykA2SrTBeXYglfa2DMuzY3OaTGr650P/fobO69NdUaSQUsAQwdsUkqZgKNYG5wZzZeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013606; c=relaxed/relaxed;
	bh=rbE4HVimj3UAIPKUXuhAh0R5+r8HoILlRGhsY+qOMz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D0yWfFfOb5xplTEEj0jJ/tecWIPyXET5zMtDeLuu/3Y8GFuq3gbnYwVAmOM8KhipCU1JGnSI8nMGkpw4J0NK/wOv1fPHezkxLvM6A/xiyA/VWzMIJadVMw0e8VH0ZqWY9fJjBHCT4FwTK4WYyq4VWRCal+MBwK6y3zXDlN7yVgbwAE+WpDcOY7O9LSq/mn4DugqTxk8+gJi4YD3qc2pCpvPN4Z++LLdFm6QBzFWo7xQBsy7S/H1gN29IGGaTe7yMdicxGJQVWPZHbOqvWA2OCjBIuiCGwF+vWm3NLeGRLkDPb9oFSfCHKPZFEY4I+ywJxLPimIndNR83YJxe4li+cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VwDSmqh7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrks3rZxz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:20:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbE4HVimj3UAIPKUXuhAh0R5+r8HoILlRGhsY+qOMz8=;
	b=VwDSmqh7RtMswFBhrlUy11vFLrpkFHlbN4Eb60jUxwia4RBDK52uGIjH2HbwlPrOTSuFsf
	vlzoZpvG/0IkNOwjwkGvbSB5yfRCHyNS5piBclWyA4Q2l87JHOJcwuF/zqk1KPShBMwBmO
	5/A6tyR1X5y2clzWoh3VUxDDOvX1P9E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbE4HVimj3UAIPKUXuhAh0R5+r8HoILlRGhsY+qOMz8=;
	b=VwDSmqh7RtMswFBhrlUy11vFLrpkFHlbN4Eb60jUxwia4RBDK52uGIjH2HbwlPrOTSuFsf
	vlzoZpvG/0IkNOwjwkGvbSB5yfRCHyNS5piBclWyA4Q2l87JHOJcwuF/zqk1KPShBMwBmO
	5/A6tyR1X5y2clzWoh3VUxDDOvX1P9E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbE4HVimj3UAIPKUXuhAh0R5+r8HoILlRGhsY+qOMz8=;
	b=VwDSmqh7RtMswFBhrlUy11vFLrpkFHlbN4Eb60jUxwia4RBDK52uGIjH2HbwlPrOTSuFsf
	vlzoZpvG/0IkNOwjwkGvbSB5yfRCHyNS5piBclWyA4Q2l87JHOJcwuF/zqk1KPShBMwBmO
	5/A6tyR1X5y2clzWoh3VUxDDOvX1P9E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-NuJb4LBHN2m9x8cklxfmMQ-1; Mon,
 26 Oct 2026 07:18:40 -0400
X-MC-Unique: NuJb4LBHN2m9x8cklxfmMQ-1
X-Mimecast-MFC-AGG-ID: NuJb4LBHN2m9x8cklxfmMQ_1793013517
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F055E1955E74;
	Mon, 26 Oct 2026 11:18:36 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E78FE195608A;
	Mon, 26 Oct 2026 11:18:30 +0000 (UTC)
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
Subject: [PATCH 1/7] alpha: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:16 +0100
Message-ID: <20261026111822.458404-2-jmarchan@redhat.com>
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
X-Mimecast-MFC-PROC-ID: heHcWwGB3kxw4_jOh5BEHgG89SZ3d_r3Vqrhx_QcBlg_1793013517
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
 arch/alpha/include/asm/local.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index 88eb398947a5b..1578c76adda62 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -100,10 +100,4 @@ local_add_unless(local_t *l, long a, long u)
 
 #define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
 
-/* Verify if faster than atomic ops */
-#define __local_inc(l)		((l)->a.counter++)
-#define __local_dec(l)		((l)->a.counter++)
-#define __local_add(i,l)	((l)->a.counter+=(i))
-#define __local_sub(i,l)	((l)->a.counter-=(i))
-
 #endif /* _ALPHA_LOCAL_H */
-- 
2.56.0



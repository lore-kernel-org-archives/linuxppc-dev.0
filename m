Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F960A263F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xQsqFIgL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWMmX4tbCz2xwN;
	Sat, 21 Nov 2026 04:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795195820;
	cv=none; b=CPbhx1oFD+505ybGXBiAaSxH6vTjV/VY/gpyNWr1Xxm6vmlJuJOEiU9KiBlRbgoKdnEi0zcsGAcB0TMrWsZAhIjJDQHE/XvJWsSX7VIRIwDdGDMYQVGh6qtPTh3pTHsn3Zc/AHMfxVSJUW6bZc9ON/8mxOrDIuiI9/7Kvw/IPacMVUt/fJGMSdUocosJso+f8c9hWHY37eZ+cPhxomnYE8FGpqf6yWD+SSv1WyhkupK96d165D7aGase+L0Hxuujb79sFf4Ei8SDBkDjztv2eRum8iL4NTS+Wj6SxTjkSD2N8YT2sb/REjsOMgdeKlFi6PfUkACboYcz92dfbCGl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795195820; c=relaxed/relaxed;
	bh=HT6eDbX+kfVSe10X1m7URXsOzCt0sFsz621mBMnptKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAsOy6zGvHuglf8VA4GlrK+CxDLHFlKRgH8H1QiZywtA6zpdK6H0kJvyEgdnxKuThEunP+2ggQnLspOaHXWCb5u292Owhuv73dNmYdgiG57zXXCR/i7XmNDGptn+8Sbm/bGPh8s+jfzlXDHZZ9BzLV28T4osQBlxsPX0M1YhudpwUSJ6OCXO4ie9vXkaLK/OzuJEzeF+xxkHbdO54w5gMC+wrHkIE+ZiJcE23WpObjVwBHEXKxQC6KvM6eGhusgpKDNh77Vby4TITrbi+VOmMZK9mBRisYueilW9sUxfmapjZok8aW89GIktyySb9As3UFWuoyfc7etYWuGRVhncxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xQsqFIgL; dkim-atps=neutral; spf=pass (client-ip=95.215.58.41; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xQsqFIgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.41; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWMmT19wRz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 04:30:15 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Ng2Ry2bda//spl0pXqaswz3X8TtF9snH5kUnqXCKZSI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795195796; v=1; x=1795800596;
 b=xQsqFIgLfWC9ep70ennh+xgFHEjIDoEudqB0LpE8938za97UTmLDdUBy35EwLgQptiAiaEbk
 XbrNy3T5s3B4a9V7OJCZtzRfZ6WCCJEIKpYq4suWi69FNRUtd3Gg8vjXI1yfuIclpOwv+0x/GOY
 F3mpqrg6vo8WzJwdMBpOuoF8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id 078465ba8668cede;
	Fri, 20 Nov 2026 17:29:56 +0000
X-Mizu-Trace-ID: 078465ba8668cede
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH 1/2] powerpc/64e: Pass entry point in r4 to book3e_start_thread()
Date: Fri, 20 Nov 2026 17:29:48 +0000
Message-ID: <20261120172949.3494131-2-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120172949.3494131-1-bradley.morgan@linux.dev>
References: <20261120172949.3494131-1-bradley.morgan@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In generic_secondary_smp_init(), when switching to the target
hardware thread on Book3E, the entry point for the secondary
thread was loaded into r5 instead of r4.

book3e_start_thread() expects the entry point in r4 and
immediately wipes r5 with MSR_KERNEL, which left r4 pointing
to booting_thread_hwid. This is bad because the started thread
jumps straight into data and traps on an invalid opcode,
hanging the core.

To fix this, load DOTSYM(fsl_secondary_thread_init) into r4
so the secondary thread starts at the real entry point.

Fixes: 2dc0bc1138ee ("powerpc/64e: Fix secondary thread bringup for ELFv2 kernels")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
---
 arch/powerpc/kernel/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a54f6f9791731..0077ce148a5a6 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -374,7 +374,7 @@ _GLOBAL(generic_secondary_smp_init)
 	beq	20f
 
 	/* start the specified thread */
-	LOAD_REG_ADDR(r5, DOTSYM(fsl_secondary_thread_init))
+	LOAD_REG_ADDR(r4, DOTSYM(fsl_secondary_thread_init))
 	bl	book3e_start_thread
 
 	/* stop the current thread */
-- 
2.53.0



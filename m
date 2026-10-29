Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AA606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GxxHcrkl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFwR6720cz3048;
	Fri, 30 Oct 2026 07:13:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793304818;
	cv=none; b=Zx0W4QJA6GFapDSl5Qpf+oWvyIgiKLaHJPgbeEQG3JLolykxT/j/6I9JIxGVU+KzzxUBh87Mq9MBwWF9er+zYSF4S6nTnGuvQ730XEjajok8NrJ1lWddH9Gv19uauxzaDteQh0xOJYzv0kfBAgGWoBbbN2mxCokhTjDCUnqms2bK0nLEXW4IVgo7sFrSaGIkRIiQwe50od0RguEQmMfGL/4d7x0F1yYChe1D3vX1Euq/u6UrB80mPYdn5f+1oWqekzK01N3Z1sTiGImJ1MHLbKnLY1Qa8cxQTALScgoTej3sa7LTX3Bj/Svitay1uG5chnWSGwc4yc6zOxqbDXVmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793304818; c=relaxed/relaxed;
	bh=/URtJhh5qYgdD+SvrO47CWxV2uFOw6FeCWrobwxfu1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Inv9Z23qI7A2LbsSMW5jKQbvlVJ37ka5aIAJsMoQoprtgZD24hj7e7IkTuW4kpkGjKQhQsGj1jeIrjweQUr+FvA2BPjEFvdW+u0gC1ghsaUyluYw39AyqTxbJcHSWqhcp5PQ6QK7s2VCrqc/uO408e22t4MCvcg+OlT8fseYNU9ht3Jx0mXPZqTGsVtKltzaevJpXz3G/BCGWqUPs/lmuArOO2PezD0TPwQHkIgZ9CaI7NkZVu2w5MAf111rlAj1KE0Ecs3ZUTjQaK5KWnXCHeYqlWRbKFdmC6EbBz4geGwQkpY1ltbNwMwahtrZy0Dg6RMd1onbgA7Op2vjxIYA3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GxxHcrkl; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GxxHcrkl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFwR16LTtz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/URtJhh5qYgdD+SvrO47CWxV2uFOw6FeCWrobwxfu1o=; b=GxxHcrklq9Y2GPUYtQO0sbXcvw
	jXtRpo6+w8rV2Vo9X7uOD0aMFHWZy34poWtVGD1XKsj/CqZ9zYfroDl1pvyDfdSRYKrlmwtNESeDO
	IcpP0IaxSPXwFvfAAmTcDw/SoNSoa3fJhxNE6bemYHuQ67ij3PaHzRDyZ3nT3z/d+B1SVgv3OoRl+
	IpU30Re5Nejtg3A7ARl6gY+lLejExhZl2sszXy/BoMrOWPHwjH7Bp/FE1lt8DHvcFVYD18iqN6dGa
	8A8qVeg0QhxqCD6guqrbLNRJzq7Kfhz5O8mPRkgheluwYk7EySV53HZ5Fj3c/GVkHXWb7PfpkQZ0Y
	pd1zy9FA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWV5-0000000AJR2-2yDU;
	Thu, 29 Oct 2026 20:13:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: patches@lists.linux.dev
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/ps3: platform.h: fix enum ps3_spu_resource_type kernel-doc
Date: Thu, 29 Oct 2026 13:13:23 -0700
Message-ID: <20261029201326.2672284-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201326.2672284-1-rdunlap@infradead.org>
References: <20261029201326.2672284-1-rdunlap@infradead.org>
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

Use the correct enum name and member names to eliminate kernel-doc
warnings:

Warning: arch/powerpc/platforms/ps3/platform.h:240 expecting prototype for
 enum spu_resource_type. Prototype was for enum ps3_spu_resource_type
 instead
Warning: arch/powerpc/platforms/ps3/platform.h:240 Enum value
 'PS3_SPU_RESOURCE_TYPE_SHARED' not described in enum
 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Enum value
 'PS3_SPU_RESOURCE_TYPE_EXCLUSIVE' not described in enum
 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Excess enum value
 '@spu_resource_type_shared' description in 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Excess enum value
 '@spu_resource_type_exclusive' description in 'ps3_spu_resource_type'

Also fix misspellings of "partitions."

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/ps3/platform.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20260828.orig/arch/powerpc/platforms/ps3/platform.h
+++ linux-next-20260828/arch/powerpc/platforms/ps3/platform.h
@@ -228,9 +228,10 @@ int ps3_repository_read_boot_dat_info(u6
 /* repository spu info */
 
 /**
- * enum spu_resource_type - Type of spu resource.
- * @spu_resource_type_shared: Logical spu is shared with other partions.
- * @spu_resource_type_exclusive: Logical spu is not shared with other partions.
+ * enum ps3_spu_resource_type - Type of spu resource.
+ * @PS3_SPU_RESOURCE_TYPE_SHARED: Logical spu is shared with other partitions.
+ * @PS3_SPU_RESOURCE_TYPE_EXCLUSIVE: Logical spu is not shared with other
+ * partitions.
  *
  * Returned by ps3_repository_read_spu_resource_id().
  */


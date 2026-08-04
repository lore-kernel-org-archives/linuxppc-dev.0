Return-Path: <linuxppc-dev+bounces-25341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF7C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnM65vhmz2yYs;
	Tue, 04 Aug 2026 18:50:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833458;
	cv=none; b=APOCnlrAz+dsw0ooE/6TxZ0wF0IBBAavFZ6zMavNuJxgyjuBuqfuByl+vDAP0GYCuieYB+xxcTS0Ltb1gwL6yMOaNJi6+WqQsPIfQI1mv3BvvAKSXOavgX7SuHNqxRq0qw0lQryuwlrqHJVNv0U+sk66gSl/y4zeyU1JwJ87Z/7lqGIgJB33wOIhf7ZmvkzTU/iswNCoJIISyUrYotP6+kZ7wvs9wJDzHdvwO0H+moGKy4YppAWH7+3WUqzrdkX2azERFq0s/cQdO84BcfmDsuJx9mNic3L9iNon1WhWNgr3wWVIHIDUqYD2PuVBv6g2QdYUb2sFJPwhSAjpbSTqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833458; c=relaxed/relaxed;
	bh=yFCC/h/Y8e/chJNplIk8jK1Ieiw7336/vahh2d+V9IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeXut/aSYco+6GWDFW4jNpm6cmzlw9ifBzKGg0duVhKLH0+w/smWQVsJQ7p0mYRpYFY4cGCyE2lBaCtnrjeYvX/paQ4Vws3GDFiDq5s6ZuEk7Fm8cb22VOcfdEr65HtxT5JMzwKrYEtYFiGXFE9dGFPqo+4mYfhN/SEIfWnkqTqu7UcTD4rUZyQnc7yK58oZyMGbXWib1TiR2WDSGWLyN+KJEoe87H/g4BhjtQeJh7ivEQbHN1xZj7azBS077iDYTPr30enuqgCigea+LzNO9GrIhebfgokwx1ANfMvN8L+9GvI975Equ6BXSqQwUHJHT8GZqmig/pMI7JDUEVEeaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f7oii5zk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f7oii5zk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM556Wjz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:50:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E991F43B56;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B9DDC2BCF7;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=Wg4a5GYB2+hy3rEJTPDy6EHTyRLohXwG7vmwER8t2Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f7oii5zktCjjdWcUS97nDJCz3QoJlcSOSLdMHx7F8kFdlcDx1MzzBAKKCpsbSdD5d
	 tHZvvGLDnf9NNMlz+KVnFuwMs185XmgGbwDmTzOyaAKzQVXa3LHvzoccDbFP1jjgAR
	 Z0YOFHXMYpvqCaa3TNT0jc2LRNvCoMwJzJxQTrxnTiGTji41xGgy+yI5GgJgA6EnnC
	 Csh8I/TF8uxE3ddyvpv7pFtPJpHhrquC+yEY7xHz3Lt+BtwBT4VqaYjp1dxAdfawE3
	 2WlMKRLh8j6JkZOx52K5SQIxMDGI9WPTWcHwOhY4wK4/+SfhtCdWr80VEqSjwI6Bi6
	 BwrBuM4MwZBbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79615C5518F;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:38 +0800
Subject: [PATCH v2 1/5] powerpc/spufs: fix spu_context leak in coredump
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-1-5bfd827297f9@outlook.com>
References: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
In-Reply-To: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=XdWocYlkrxGjIsGC8gAbyPABgvp/vlZdqZWZhKwsHTk=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlr7OeK/LPnp5999fChz+TfA179+0qld6/7q/xO
 ieVZTIeoYYdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJHTKxgZ9q9epFt57ONa
 FmvF/w99a1zkVzS0n30q9Dba+YW1/SzFJQz/Y8tOfZ3JdntNbvtHp2MM8ZbuX1+pzb4/40pz171
 sc7nLHADYSE9b
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

coredump_next_context() returns a spu_context with a reference taken by
get_spu_context(), which the caller must drop.
spufs_coredump_extra_notes_size() does so on all of its exits, but
spufs_coredump_extra_notes_write() never calls put_spu_context(), so
every context dumped through elf_coredump_extra_notes_write() leaks a
reference, including on the success path.

Fix by dropping the reference on each of the three exits of the loop,
mirroring ..._size().

Fixes: 38b407be172d ("powerpc/spufs: Rework fcheck() usage")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 301ee7d8b7df..f5964c9ebb3e 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -162,13 +162,16 @@ int spufs_coredump_extra_notes_write(struct coredump_params *cprm)
 	fd = 0;
 	while ((ctx = coredump_next_context(&fd)) != NULL) {
 		rc = spu_acquire_saved(ctx);
-		if (rc)
+		if (rc) {
+			put_spu_context(ctx);
 			return rc;
+		}
 
 		for (j = 0; spufs_coredump_read[j].name != NULL; j++) {
 			rc = spufs_arch_write_note(ctx, j, cprm, fd);
 			if (rc) {
 				spu_release_saved(ctx);
+				put_spu_context(ctx);
 				return rc;
 			}
 		}
@@ -177,6 +180,7 @@ int spufs_coredump_extra_notes_write(struct coredump_params *cprm)
 
 		/* start searching the next fd next time */
 		fd++;
+		put_spu_context(ctx);
 	}
 
 	return 0;

-- 
2.51.2




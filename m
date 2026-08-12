Return-Path: <linuxppc-dev+bounces-25756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28ECC5B567
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcwj3VjNz3brC;
	Wed, 12 Aug 2026 15:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513701;
	cv=none; b=PPNFm5pPAiuw54/WhGbzg+6MFoad7o9aCuNkez1H+jTLUapxjMCYR5jeieq3eicY0YjQPwJiUG9ND3PpoANoaRDq0vElnmretoWjZmlaMdyBWEIIVr0U5Dy4wNdVzGG35ib1vpAQNAfb/sytL6vGcibWPhAvknXx6BXoZLm89wH2+WjBwvgvaEcNrqWUgpVmgmibBiyubkOGBbHgNT21jYJcKdSUlcpkX+yThKAA+tSnAqrpGAb8n8VpdX/ldoAL6DBvEzVsrgj9CqTGu7ovFEckbqzgorsjWoVqJ8MiAhF7+uUit6T/nhkH3xF8SbH7/YS9IN7KCTNRRlpdkSEeug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513701; c=relaxed/relaxed;
	bh=1cjqgskbWE0JtrZ8SzND6dBFSLTHbAYrgSiEWWcx7hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrIhEbsChRSPPNguFsig80WL6f5vO65TuEsgRduhVB6oz+2TUmFrEdFk/vk36K4YytdFNH59pnF83/dWtT+EuuATwYbOCldEBqyyWHkTSFgr2w30AQMxAG8xpyBayRorXFVoYJmRzD1NB8Ou5qc4o/cgHBLGyjYuN4M43pVy41B/KtNfwPb3mpACNn8uuPdSvUKrzEZ//S2owKLxc7G3cbbxK9/P7oApeTxnNw2nB8giHH8GfeN5psGwf86zfRExli4veoDYH0MTMnMv2vcFJMIAzcNUftH3CaFjdIdRaAohpFPGvF6VBatxbs5JZi/VmR2px4hFq8RlJwmGJbN0oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hj5LWPR1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hj5LWPR1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcwg4xfgz3bqy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D87BD438B0;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACF41C2BCF6;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=2Ef7G09j67/eoUC8SK2Ltteg4MTYzAdNGnUkoyKYleg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hj5LWPR19q3Xoks4xzKyly0Lmc0JovtQdKa/NFqlIzOTVi/c2D0KMLbCV4PDtCxn8
	 W7O0n2T2Oi7M/xdv2blOn3m4s0gGfAGkwpZMEcZWHCvJqCkdepVEZb8LMjOR4G58DZ
	 kdkxiFUNJECmFZ4xZbkwUcjPrqog2kCFUVZl0jg3H/G3bCez2dlNOldAUxts/+pZPG
	 I2C4OUc3AKBIz9e3sOJtre+k/PejVDuir4ZRmRrtpEkTwnPjBwtGDTjK+D1DkCTMuO
	 nbgUwfrFnAqSPAvLV4I/xIrwBHuTfPGF8lLLjuZNNoympbo3fw65/npQVFBY7yrEyR
	 RxCU174uMPL3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBFC5B567;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 13:48:07 +0800
Subject: [PATCH 1/5] powerpc/spufs: fix memory leak of spufs_fs_context in
 spufs_free_fc()
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
Message-Id: <20260812-spufs-fixes-v1-1-449e201d9f64@outlook.com>
References: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
In-Reply-To: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=7tJ0E00IsnJBei3nS8CdVd0Qh/gBecZOpc59xKiGh0k=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOWbe6PYdDbk6eKcG3yuT2bsbKWTKZM88uLaw66
 pOXwejldb6jlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJuKrwvDPKIS9wVS0bsm+
 ufOuxTn1rIqYMKnaalX4pb0aDw6LPTHiYPin0BNay8Rec2FX46YA1YZni+1YFi74u+HmNc+Y6Ig
 ey9e8AF6eSFU=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_init_fs_context() allocates both a struct spufs_fs_context stored
in fc->fs_private and a struct spufs_sb_info stored in fc->s_fs_info.
The ->free callback spufs_free_fc() only releases fc->s_fs_info.
put_fs_context() never touches fc->fs_private, since releasing it is
what ->free() exists for, and vfs_clean_context() calls ->free() and
then clears both pointers itself.

Every spufs fs_context that is constructed and torn down therefore leaks
the struct spufs_fs_context allocation. The leak is reachable without
privileges: fsopen() runs ->init_fs_context() before sget_fc() enforces
spufs's lack of FS_USERNS_MOUNT.

Free fc->fs_private alongside fc->s_fs_info.

Fixes: d2e0981c3b9a ("vfs: Convert spufs to use the new mount API")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..51c432864f02 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -713,6 +713,7 @@ static int spufs_get_tree(struct fs_context *fc)
 
 static void spufs_free_fc(struct fs_context *fc)
 {
+	kfree(fc->fs_private);
 	kfree(fc->s_fs_info);
 }
 

-- 
2.51.2




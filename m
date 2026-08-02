Return-Path: <linuxppc-dev+bounces-25205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E70C55162
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:52:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCknv1xc7z3bh4;
	Mon, 03 Aug 2026 01:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685923;
	cv=none; b=IyOnkjKTYUUC0BflcgUKdecbPka7YkDj+SxBdhri7YR0FeGdN3BewbrkuWXU7mFQgjMSPogmiomxnM+ybyVTIsUrTeIHEApKJBV7oIvBDlxQ/NYu527gNfGDK2MOD9Y8OmsSWt7pAewGC4OYFg6Gyta7gEpgzV784rPg93a1z7ivG4QAuIJ3X7t9hBMgOOSRTmorrQ+8XWjp2o/DQK191WZMnEABUWKYMscxsQrPt2xgtB7MyoSLZvlIRo0iUVBNbFIecM9xZxaen7qODQYIErLdgH/hPkFiAVFEIrRO+0bdK2B6RvS9Iy05NTVRAjiEDVh+jv5n2lHMANiZoEfrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685923; c=relaxed/relaxed;
	bh=Gg8Q9xml7AYPWzP0xT4IDseyhfYy7ugVC1k7a14/Taw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5QtQ05ejvhXPDqe5JRCwdCqfSdiWhPqqQwusPBmjlbDX/gH0nxmZS0QT0itfCZMbzbXvWwA9oSK18pb+vErJswgeug+xMToqaYq4758mLD3nBoPELrrsLi2+rdB7toLdOq0lTrspNQ2lh9y36W2HZgO7xidnVrdM4hV69/ppa/lWfHdMoBl9gcGE2eWy81ORDkl0h3dXQRfPpSHXxSq/KB+QPrGXC9o2vFpYjV2GBDPkCgZhZjAes4JJ0vK22Umz+EnP/l/zNG5C24PdDYnuNDcu4wFqscjluEPOkSbck4CqOKBnz4xbbREZ8X4YXrLcMrcfqbaMOJwsxVonevJ7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BPQ5qquV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BPQ5qquV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknt2SQYz30St
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:52:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 549E160DEA;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF73DC2BCFB;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=vXE2AV78Cf4cBIpFGvjs0Jox33f1sFJXn10xcbgQjPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BPQ5qquVL2yBC7IgjHhyEXmaZ33lBl76MgJwFZZmVlN89ZabMrOELqx2zkOZUQT6v
	 KBEt9xvewY146oze/t5oITyCztfrlHHTJ7I48EnHmSHjcqc+3MAeUrGDuYILLhdqdk
	 PQZO1v0bUYy2YD3ILlSnNyzoqd01AqnkADZlLSICunQzFy2errMfg4MafrNMxaHcd7
	 kCqmWOpxRt/IqUvyKgq32Bf137oLcsKSMXHdGlyLFP3xoKkYvsXeQkyrSvFnLS2svU
	 YAMfXmyKE4iit4Qwx7NkbyVldD2ruUiZ5h0EbE7amwCQm/rYbbuBn9p1uU51PMSCR/
	 jJrDUAkSPMIyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB682C55177;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:42 +0800
Subject: [PATCH 4/6] powerpc/spufs: check permissions in spufs_setattr()
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
Message-Id: <20260802-fixes-v1-4-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=bHGF2umld4asI61QtFVSR8rrvQgLxL9YyHNp5cEh3fE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06U/5amU+1+kqnpvxr2m3yL3X705r3d7mFa16n
 O2jFc9a+eyOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEh3ACPDgdXfpr6aZ7lX
 qGydSJf7a52yL29mya46IF605ubD/HB9XoZ/xmZmju/PyLE2+p6uiWR1iT8W9Xj+3Xs3LpXUXnW
 adfohCwAnQk23
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_setattr() applies the caller's attributes with setattr_copy() but
never calls setattr_prepare(). notify_change() leaves that to the
filesystem: it runs only may_setattr(), while inode_owner_or_capable()
and the CAP_CHOWN test live inside setattr_prepare(). setattr_copy()
performs no checking of its own.

The handler is installed for every regular spufs file, so mode and
ownership of another user's context files can be changed without the
usual authorization.

Call setattr_prepare() before setattr_copy(). The existing ATTR_SIZE
test stays ahead of it so that resizing a spufs file keeps returning
-EINVAL. &nop_mnt_idmap matches the adjacent setattr_copy() call.

Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..c2b15c30f7c0 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -96,10 +96,14 @@ spufs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	int ret;
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
+	ret = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	if (ret)
+		return ret;
 	setattr_copy(&nop_mnt_idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;

-- 
2.51.2




Return-Path: <linuxppc-dev+bounces-25343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337A6C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnM728Jgz30B9;
	Tue, 04 Aug 2026 18:50:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833459;
	cv=none; b=mlvKB1mlrbMLGd8Vjz1WrN5BnigF9zvsFmOzwVUyEJHi5ucN4EE3G6+phgUL69KdS14hCz/7ywS1J8ZSnVQBOFrj9TpTdM2sxiuymWaZsI5zScHJ/o61iXEPvbBINQ9NJLQR+sdC/dmUEj+4cJRWPGZfP4PAOvs3ruW023QbFZHhXuzQD7qIbglKXoqrmkGyvB53s0tbN2KL90cdgdiU2xW54Aubk+uP/HMTP2TEv5ZoxHg4icZvx5UajzIbBlq0lTpDAfPOzzn0drDs1X4znMNnWihI1VMHA074jMeWDv5akQdLBZFRHlla+U9gDSKLgEXXd1Qm2WMB+QsvqoROIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833459; c=relaxed/relaxed;
	bh=gFs88Fk7Ct1KoWgD5rPNaCe50cEzJ/OH1uXQzwYWf1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxNlcv2H20IYWVgvqnnYX85nmbr8BiD1WFq3bYicxUvdCTzvYyIVd+8pdrywmLH4pU+9WK2gedr0OpfYqrN25fzOnxTWxWLP14HNPeIsVn6HTatnATTnnSLGf17rqiuIA/VJpjHrhhoT5yTRNpD7uHoSr5xesb/NEKks4L3HRJhokRLfsnweb6iVgF26APDy2gW8PcBhE2zoXs6LqV4FF7KgrAz44cJVjw64vRv2I8y4BSU9CMs4A5/RlHLft4C3yD3kP13x+yuFD2mXxWSFDQgms6Ue3041K0q3ZrqY5qHYTitogGO5o4+JiGKC5sG5xoR+lGlYO+cJPusY7IieSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eU4dTuRI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eU4dTuRI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM5716tz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:50:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2502D60A90;
	Tue,  4 Aug 2026 08:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D39C2BCFD;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=afJAMLbhFODoEcveLVFFRIw8h+QDoAijPxkIMhvX5Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eU4dTuRIPB4xWAu9Ya4VG5C95yTBDgyq2cEThTJGEvoWzxaI8blP/rPPPZx1tsPXA
	 qUx5LyIX4ZvGzGUMaN42zS9TmqJ5YVTYhLz8JyEhttnja7m6dNSZACKV5rFkb8Et+z
	 5Ud1ioWuadi6TjLP+SuqYrEcK7fU/AOXS/MJDjdbo+PLtQjj+UZ7JTRkXfJ1H9GCq1
	 U+wP9fVDVBYqcqfe206tWQiTcN8gzk/IJLMMfsQ2i9OHCcd/9AtYC+Pm5YfuEJ/XAx
	 NGXxTFnjOwXudiphSsTNR0x09cvaiIMenlxh2anYjzxPpQ0uwUh1YCYoxwQeEA4jUT
	 TCell6G3Nke9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DEC55ABA;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:40 +0800
Subject: [PATCH v2 3/5] powerpc/spufs: check permissions in spufs_setattr()
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
Message-Id: <20260804-fixes-v2-3-5bfd827297f9@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=dffeiU9SuIG2crRu8M1hNRxZHn/iEzt/PMyihiDEjKQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlbxTVjPNSXmaeOhL321xIPc/iZOt5vyTxgAsyW
 xgYFVrab3eUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARJScGBkeBFrNO/D0QJBQ
 //p0rZh1Xe/62jdz7osUfpo4W4BxVdcmRob9zxY7Pl1XmXm4LKPmtcy9NE23/HCHklOHvq/d6bh
 B8z4fAOdOSp8=
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
Assisted-by: Claude:claude-opus-5
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




Return-Path: <linuxppc-dev+bounces-25346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E48C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnMB2CZlz3bx5;
	Tue, 04 Aug 2026 18:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833462;
	cv=none; b=YIu2DPpSz4QmXoQKv6Ui9GCrKA0HPtQjrx7GjP5AbwGs6Zp37g+tffI2m5WL5pQW0gNXzqmvH7PybrFiYTfEa+ATsCKuW6TbXET9oEkCjC9rtPhkRYFtP3cL1gQJ7cuzPUsa30ziEJXHtQa0xhqsTO6M1Dv6kE84k+2anCyWGDWIKqluwnSIf2eMSgXWSOUoVrNr6GC3YEUJD+OL5ZWYRK9zBIXdTZi0oWnvyz7NqhQjbDk9ycC27QgGOLRqZqiUnzNOcOyYYVhjGi980ZUU/7djsQVJtLX4PqPgdJ+fL0NR2YYg8EAzpCN0lSuVkZ5KKLlP9lDtEtf9r3U5Ni3KPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833462; c=relaxed/relaxed;
	bh=Lis6TJmLhAaxEzyjdiLj+HW3Qqo8ouaEJRO+kPl6Iq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHi2RWhIb3PjnsioOZWIm16OoA3Es8NX9oDcbOY1ydRT5ovMZfKhq4tTTtOTeBW4DmX9H4iE199DkXZPy+CHMFhRKtb/uZMemZQr+IBSCPZnn9mcCoRSGkPPjyNvxKxDhu8h2xrQdbXizj68OsYOwxREDIZNZnNnnvCGtAsQxhSaEu08XiU5DV7m3H4+9hHfXMLra+vAAGrIp0H1wedJILnHhg60uHJroor2N8aWPocu5+FGYj6iSgMvMnKrCYR3Zg73qfTRtLgQZSdwThz2Fkuv+zNM+6B6TbHjn46QFQKXNRCVxIoAv0picSW+Emt1empIMITZhE6wYcMniG2mzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ESKSqjXX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ESKSqjXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM76C4Rz30Qv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:50:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F1A5E43FC9;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC29AC32781;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=GhANxRpAyu/KCkIgpDUCIepXUdGoiRJbd1x17Sr/Kvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ESKSqjXXa/wn/WkDXS6jeQObwDt3s3LJL2VCNJtAq+gbamyvwb91t4WesJ6a0MkuF
	 u6z8UADaF7/oyby9sJLP/sudQIhzgqv2G/h+sEvwpu8CJpE5oUI2XFB/FZsNVEmHlV
	 laV3cnpTU6Ru/6Cj8djZKLQZEWa4nlX8gRMz+v+m7/Xw5oy/KLb16wvHdNHJKdK7mo
	 L9AerNX+KEWbfBbuzkok7ptVIHqfIh3sPaeB6Sq4JFRSRajhwTYsAUhebyD4HxQERX
	 9stg7Ibc0oo2vPFSO2ZGZNbB+qKyBroWRdt6GiQrdrPzhDt6BRgC6an0XRFk0daZ8c
	 cnV9UqiitqlDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FEC55184;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:41 +0800
Subject: [PATCH v2 4/5] powerpc/spufs: fix deadlock on gang creation
 failure
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
Message-Id: <20260804-fixes-v2-4-5bfd827297f9@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Cj2YqlgaZpS5pzQnZtV4Ucl3WQDjefs7reGQ8GjrlS8=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlb6z8KpX3rjeYmVNQWXmXr2Xh382Xyje/KLY+2
 nnSZjNXTHJHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATET+C8P/jOTkSPaFHw5L
 OU67oNHz4MRr8YNf2Pv/vnI1YN/4yDSBm5Hh+b7oApZtpxPcZ/qdOWIkHVpfw7Jnd0M8z7Qpv6W
 cdfZwAgCYhkxU
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_create() enters spufs with the parent directory's i_rwsem held
for write, taken as I_MUTEX_PARENT by start_creating_user_path() and
dropped only by end_creating_path(). When spufs_gang_open() fails inside
that window, spufs_create_gang() cleans up by calling unuse_gang().

The gang was just created, so gang->alive drops to 0 and unuse_gang()
proceeds to simple_recursive_removal(), which takes the parent inode's
i_rwsem as I_MUTEX_CHILD. This leads to the task blocking on an rwsem it
already holds, leaving the spufs directory write-locked. The other two
callers of unuse_gang() do not hold the parent lock: spufs_gang_close()
runs from ->release, and spufs_dir_close() drops the parent lock first.

Tell unuse_gang() which context it is called from, and use
locked_recursive_removal() when the parent is already held. This matches
spufs_rmdir(), which spufs_create_context() already uses for the same
cleanup under the same lock.

Fixes: c134deabf478 ("spufs: fix gang directory lifetimes")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index c2b15c30f7c0..998512409552 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -175,7 +175,8 @@ static int spufs_fill_dir(struct dentry *dir,
 	return 0;
 }
 
-static void unuse_gang(struct dentry *dir)
+/* @parent_locked: caller holds dir->d_parent's i_rwsem as I_MUTEX_PARENT */
+static void unuse_gang(struct dentry *dir, bool parent_locked)
 {
 	struct inode *inode = dir->d_inode;
 	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
@@ -187,8 +188,12 @@ static void unuse_gang(struct dentry *dir)
 		dead = !--gang->alive;
 		inode_unlock(inode);
 
-		if (dead)
-			simple_recursive_removal(dir, NULL);
+		if (dead) {
+			if (parent_locked)
+				locked_recursive_removal(dir, NULL);
+			else
+				simple_recursive_removal(dir, NULL);
+		}
 	}
 }
 
@@ -204,7 +209,7 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 	spufs_rmdir(parent, dir);
 	inode_unlock(parent);
 
-	unuse_gang(dir->d_parent);
+	unuse_gang(dir->d_parent, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -483,7 +488,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 static int spufs_gang_close(struct inode *inode, struct file *file)
 {
-	unuse_gang(file->f_path.dentry);
+	unuse_gang(file->f_path.dentry, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -520,7 +525,7 @@ static int spufs_create_gang(struct inode *inode,
 	if (!ret) {
 		ret = spufs_gang_open(&path);
 		if (ret < 0)
-			unuse_gang(dentry);
+			unuse_gang(dentry, true);
 	}
 	return ret;
 }

-- 
2.51.2




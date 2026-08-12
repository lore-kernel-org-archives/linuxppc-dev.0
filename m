Return-Path: <linuxppc-dev+bounces-25776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB9C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:20:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKrHj6fVCz3bsZ;
	Thu, 13 Aug 2026 00:20:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786544433;
	cv=none; b=gFJaq60M42xh/9RBzSuj/NeVe4CDdzfntgSBe+dAuPQCkgMyvJLu5qPeSp+DNErlur/5awZpjeZ7g8e2rydpNIzy6M7u5XfJ13+FP2Pp1bUndfZ6NFE0q2SKmjFimO2rvdntJjsCfr6FPhBtfZXSHfiEKfMoiCXGUhB9Ow+kuuIGiQ0LeUHwQ7p9GAudmsMn9sXv4e6C2DlDLvWdr+N859n//G1mosCsRSHiQGhgfaGewcY4rSSoP5M+eaQHiTMmZlf0o0twhsNubfiVODrf1gj8EehRjR9Gnrxq0OVUZblkLR7FeIZ/RLqbkKjKXjmp4lqODu0tZoFHky6JvE9V7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786544433; c=relaxed/relaxed;
	bh=KfFenigtBlsUpFRETS//72mmdEApLGPYa9j/QhUpp9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N86H1zni5WFt6cewBU55sXoC+rhvQYksI2Kcp8qoRPZMi8FF+NUuHWb10As+TYdKU9G8AGAKT0/Tq15dmg3ebD7yiwpXIo83se5oUQ0edDlZffBHOkKVRInGUG4AbUYyDpp65y5184gZJMM8F3zFDI1XCEE2PBTqOffSXWGK70FfZDlbS3hL5t3ERbXq+4d7t138bgto/VDyboGUg5zYa6CNPKdYt0BdcAppdNB7aoa0FBvNGo+pT9dpjWTuqQcsrLIOLg5NmsCPaYNgJsoiWkY5pE6AO33I/t0R2UHdAdAvY7Z9vMZy++q7M1rLhjeFates2JovcDCj3Im3JewglA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ov4KQ6s7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ov4KQ6s7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKrHh4RCNz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 00:20:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CAE160DB6;
	Wed, 12 Aug 2026 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7541F00A3D;
	Wed, 12 Aug 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544428;
	bh=KfFenigtBlsUpFRETS//72mmdEApLGPYa9j/QhUpp9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ov4KQ6s7XREh3KkEiSJ5ofqlWdsuK0cZBAh+aT0P+rFCzcO9W3DYsSadBhFht/xFs
	 3O7mgAT6TPE6PEAx3tHWwDIJ4hpfU9tnCKwwUfp/z0v7yUDsTFH6TTI9Euy430+ExQ
	 lqOblFV3jsdgUF/Dkbyt5RUn9YdWlm2OQBWQI8537ttymtnhrKoVOBk/xO0XdGSCSG
	 6r7UxiZMQeQpfoW++VcQ3cHoEWIHXCK7SBH/ki47KPym7aXqGEWMpDu+gE71PzqIqY
	 bUoZH+IY8LuoHVqoRlBlYy4cojeZrtssQ9mbKKwALX8Qw2rEEGZUjHNTbXejcFBnbe
	 smD7+u1JNVkSQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9og-00000000ELl-2Bzn;
	Wed, 12 Aug 2026 16:20:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 RESEND 3/3] powerpc/pseries: clean up ibmebus printks
Date: Wed, 12 Aug 2026 16:20:16 +0200
Message-ID: <20260812142016.55136-4-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812142016.55136-1-johan@kernel.org>
References: <20260812142016.55136-1-johan@kernel.org>
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
Content-Transfer-Encoding: 8bit

Clean up the imbebus printks by switching to pr_warn() and pr_err(),
adding a missing newline and making the error messages a bit more
uniform.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 48076fe6ab30..5cfb0565e712 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -207,8 +207,7 @@ static int ibmebus_create_devices(const struct of_device_id *matches)
 
 		ret = ibmebus_create_device(child);
 		if (ret) {
-			printk(KERN_ERR "%s: failed to create device (%i)",
-			       __func__, ret);
+			pr_err("%s: failed to create device: %d\n", __func__, ret);
 			of_node_put(child);
 			break;
 		}
@@ -286,8 +285,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 			      ibmebus_match_path);
 	if (dev) {
 		put_device(dev);
-		printk(KERN_WARNING "%s: %s has already been probed\n",
-		       __func__, path);
+		pr_warn("%s: %s has already been probed\n", __func__, path);
 		rc = -EEXIST;
 		goto out;
 	}
@@ -296,8 +294,7 @@ static ssize_t probe_store(const struct bus_type *bus, const char *buf, size_t c
 		rc = ibmebus_create_device(dn);
 		of_node_put(dn);
 	} else {
-		printk(KERN_WARNING "%s: no such device node: %s\n",
-		       __func__, path);
+		pr_warn("%s: no such device node: %s\n", __func__, path);
 		rc = -ENODEV;
 	}
 
@@ -326,8 +323,7 @@ static ssize_t remove_store(const struct bus_type *bus, const char *buf, size_t
 		kfree(path);
 		return count;
 	} else {
-		printk(KERN_WARNING "%s: %s not on the bus\n",
-		       __func__, path);
+		pr_warn("%s: %s not on the bus\n", __func__, path);
 
 		kfree(path);
 		return -ENODEV;
@@ -452,20 +448,18 @@ static int __init ibmebus_bus_init(void)
 	struct device *root;
 	int err;
 
-	printk(KERN_INFO "IBM eBus Device Driver\n");
+	pr_info("IBM eBus Device Driver\n");
 
 	err = bus_register(&ibmebus_bus_type);
 	if (err) {
-		printk(KERN_ERR "%s: failed to register IBM eBus.\n",
-		       __func__);
+		pr_err("%s: failed to register IBM eBus\n", __func__);
 		return err;
 	}
 
 	root = root_device_register("ibmebus");
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		printk(KERN_WARNING "%s: root_device_register returned %i\n",
-		       __func__, err);
+		pr_err("%s: failed to register root device: %d\n", __func__, err);
 		goto err_deregister_bus;
 	}
 
-- 
2.54.0



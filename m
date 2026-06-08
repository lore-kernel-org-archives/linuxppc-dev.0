Return-Path: <linuxppc-dev+bounces-22187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8018CCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 11:13:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYqDN2QFGz2yCM;
	Mon, 08 Jun 2026 21:13:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0c:5a00:149::26"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780917236;
	cv=none; b=gRiudPTy6wKGlfiKUSTyOIRURS6ukfbg+ktuHCYL20Crfh3wOUZfPy7mp5u5urETBCUWCn6/EAlxWgBEAzCwxJdk+yAr3rcG188JX52MecjQD6qIPw4YzWTA69TtwdaQhqdkJdTB/6w0VnbCYm3qaICRUrrjq0wm/81xcxw+abzCN0C0IDJEOR0Qg3ZsrR8FPFP5IjzQQNx5RbGo+DLZRvUu9GQUg2Dici6lI98UYFwdu0+quNcBW11lY1B9JOju72IxzzXHyF9atlPGVYbur0Sec1xN/ok7XwzbEMz8+y3pdrJ4KROEDENGZSEv4li7Easkxc241LXW+VBs6/u3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780917236; c=relaxed/relaxed;
	bh=WCh9uWNF9SibsB1K3v1cueJAJRBgOsBn5WEx6kVnxVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4Glx4UOP3U1RLGbvRm+OS+lIQR6vk8TmZdzbAFNauV/wbkNNb8Xks9/HTtQXBsETNIa3LhtULQGcjRHv0sxxkPV5SmB1NH8XBhvtREcE4sD/ZXPO4ydZrrwMji12OntP/Q3b+ubabLq4qgXiMqvV3ZSa5O/38LeYc6QU2vW3iBNrDF1xCBXgI18GTvWkfsPl/bor3Qps/vBJ8Y+3uAN9xWuCJIqf8psH3EtuybtP0m0a4O/JBqv/0zDXBKn3UvPeRE2zy2paxb55JcC5StNXm81uM+qcXrjxiLuKdcVkqTLnOFqv3RsdxSZPHA6qTzrEoxfGoxGU++qucwUKcx4Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=OMDJJPlv; dkim-atps=neutral; spf=pass (client-ip=2a0c:5a00:149::26; helo=mailtransmit05.runbox.com; envelope-from=david.laight.linux_spam@runbox.com; receiver=lists.ozlabs.org) smtp.mailfrom=runbox.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=OMDJJPlv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=runbox.com (client-ip=2a0c:5a00:149::26; helo=mailtransmit05.runbox.com; envelope-from=david.laight.linux_spam@runbox.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4700 seconds by postgrey-1.37 at boromir; Mon, 08 Jun 2026 21:13:52 AEST
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYqDJ2JH8z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 21:13:50 +1000 (AEST)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhV-00Br4b-CW; Mon, 08 Jun 2026 11:55:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=WCh9uWNF9SibsB1K3v1cueJAJRBgOsBn5WEx6kVnxVU=; b=OMDJJP
	lvEcPge/2kBbAyfRc91Th6yl1NgRVEnMnJnYvk+H3mnbaPy3+grj91QQ18fzZuIxCJPxlcgraRJ/5
	R7Z2hkMSi0Qm31781jON14mqwVvrz2uiDGPdsn71BT8ubr2TpPoIITicmXUVMsCrWHPob43UEd0GS
	qg80HDOuJlEIk5I355mR4oiH2MI0jTFVRkTlH0Qn4nApJ9uw1q+kSaDR5RfGF/0C1Ivxdy4pimlNj
	o3it2Db4efe91ZOSp+9CSuCMhbM3LeGVs3gQLBqHnPxtTA+rUxPzowISepvrwgHuSgLzFoRnq6JB5
	8bTUIep+H73HyNVhC3sdeWGc09bw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhP-0003ZG-R1; Mon, 08 Jun 2026 11:55:15 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhE-00Afz8-Nj;
	Mon, 08 Jun 2026 11:55:04 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:56 +0100
Message-Id: <20260608095500.2567-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures than overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 221146e4860b..372175fe169c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -903,7 +903,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
-	strcpy(endpoint1.type, mc_dev->obj_desc.type);
+	strscpy(endpoint1.type, mc_dev->obj_desc.type);
 	endpoint1.id = mc_dev->obj_desc.id;
 	endpoint1.if_id = if_id;
 
@@ -920,7 +920,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 		return ERR_PTR(err);
 	}
 
-	strcpy(endpoint_desc.type, endpoint2.type);
+	strscpy(endpoint_desc.type, endpoint2.type);
 	endpoint_desc.id = endpoint2.id;
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
 	if (endpoint)
-- 
2.39.5



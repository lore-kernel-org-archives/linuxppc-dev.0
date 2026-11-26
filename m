Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44314606A338
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyiHL/u2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZy8C02mVz2xlq;
	Fri, 27 Nov 2026 00:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795699786;
	cv=none; b=dSCd++b/G5ccZjIcttciBlaAC+VDlNdp7a48+PAraes87vJssUW6P+W//ocurlrJEoj7JWFeT/Sf+HUtmcpfrdcyPiEfs5Joapi3fvs9gVdan/A8//YHnMG/6EhemOxr+faY2+cBWyNyuqE6ZSq8g/KJduDMQww6CPpA+3/KQ/EBUa3bHbTatdDsTYwGrJaX3D/VctoPlaWef4UN3ony9OjUqJUsrXjFN8NSyTvGT9Mk9hFnH+y77dd73g7GT0lUMQpGpaTVi4troCE1hfu81kXZsm9Q/ylH2TLalFEC2kZg8x3X31mKKtbSEgwu6Uo2T7d3ZSp9E2zUIayDxAtQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795699786; c=relaxed/relaxed;
	bh=ShyJCg0jarTkCTYNxJGu3w2QfZYS/yE1+gZQqjSjk1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lciGyBsCRaSXz72tPOfLMlkVlK8U6vQTZotosFM3z0FL0ZLHY9lmD1Va/vt5wKWRvCPTC38OTGnApWFOBsbYS1anJsMY+TdbgKO0t/9GlXr8vobXxL0yyRPTR1ognGI4nzt03OM5YNoJcGb9gfGyd5jz8hkph8lgzKf7RChTpXtHDwqSrg4UxhrEjKEe1o1I8lssHrLHzduv+1bNVX/VTYqoWvx8IWGWMrV0YvOQyy+w1s6dzCrEqRI+XpxuNcqAqTD2++PqOQwWZJnDbLZiTvCbDiWRPrj6OrPFssdoW0pPICcSaTOeX/+SL4DB/wGZerhKb+NTuQnBKdRgYVP0HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyiHL/u2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyiHL/u2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZy8B329pz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:29:46 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74DBB622B0;
	Thu, 26 Nov 2026 13:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA541F000C6;
	Thu, 26 Nov 2026 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699784;
	bh=ShyJCg0jarTkCTYNxJGu3w2QfZYS/yE1+gZQqjSjk1I=;
	h=From:To:Cc:Subject:Date;
	b=MyiHL/u2B1W0d0IRo4p8zXjHgXI3B5DscpykTUvMZi5PCj+j12n2BkweXVEnA9pux
	 c3hcXhQB0YFLDRWtncEd+WnpoZCQd/2EuPc7lKlzMdkEE0y1ETCDERz/Xq9KTFChVf
	 2vtrMsmWd/p7t+fqtC79Pr+Ua6lXe9LwI03PmIKJL8j1oJTusG4gBKldA4gITbH73y
	 t3/8hDk1KEPzr3IWl7y5WDnhnSx2MWlCZr+oEaD3kYFum4+fLoi7igJu929ybxbcWx
	 gMycIG3T3ln87JqBzfyYdA4SjTf6LxQwQj3qEB35yQ4j9eZgYmNGJWfvhbu1IonxZH
	 IwqQEbfaN1MzQ==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jeff Mahoney <jeffm@suse.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh/macio: Fix sysfs output in compatible_show()
Date: Thu, 26 Nov 2026 14:29:28 +0100
Message-ID: <20261126132930.394539-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=blum@kernel.org; h=from:subject; bh=rvnffw9XSJf2IOUGU5fwvmsyEhkwA0ugKJXFbxZQ3X8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNkcJlZ530o6Ig/wmGVOtltzxJe5erWAVdqHXM0PLx4bB nI2HknsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgInwnGL4K/FBL+PD6f/H99y/ Yuhw+oud1DMtkeYDbqwSJn/r7ANeyTL899Vt/tVz6EziV5Huz/mfDnVF3ehL2PjafSHjKz+7C4x VPAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

compatible_show() incorrectly advances the buffer pointer by the
accumulated output length instead of the length of the last string.
If the property contains three or more strings, this leaves gaps in the
output and can truncate or omit later strings.

For example, a PowerMac11,2 OF dump [1] shows the compatible strings
"mac-io-i2c-control", "k2-i2c", and "keywest-i2c". The first two strings
take 19 and 7 bytes, but buf is advanced by 19 and then by 26, so the
third string is written at offset 45. However, only 38 bytes are
returned, so "keywest-i2c" is omitted from the sysfs output.

Use of_property_for_each_string() to iterate over the compatible strings
and sysfs_emit_at() to append each string at the correct offset.

Link: https://gist.github.com/rokuyama/079eebc318ad9417665f2c023527dac4 [1]
Fixes: b5bf5b6786cc ("[PATCH] openfirmware: add sysfs nodes for open firmware devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Compile-tested only.

 drivers/macintosh/macio_sysfs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 2bbe359b26d9..59fb2a51de2d 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -3,30 +3,18 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
 #include <asm/macio.h>
 
 static ssize_t
 compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct platform_device *of;
+	struct property *prop;
 	const char *compat;
-	int cplen;
 	int length = 0;
 
-	of = &to_macio_device (dev)->ofdev;
-	compat = of_get_property(of->dev.of_node, "compatible", &cplen);
-	if (!compat) {
-		*buf = '\0';
-		return 0;
-	}
-	while (cplen > 0) {
-		int l;
-		length += sprintf (buf, "%s\n", compat);
-		buf += length;
-		l = strlen (compat) + 1;
-		compat += l;
-		cplen -= l;
-	}
+	of_property_for_each_string(dev->of_node, "compatible", prop, compat)
+		length += sysfs_emit_at(buf, length, "%s\n", compat);
 
 	return length;
 }


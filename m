Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA1606EE84
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGhyitu5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXyz41Jfz2xm5;
	Thu, 05 Nov 2026 04:50:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814619;
	cv=none; b=UF6OMioG0/wVrMtmjndbXDMmxKnR8EM2subqYh5R6/CcPZ9I1DLtKrxJjYvERrcR/TLboH5c3fE2K5ID0MoxNYJ3Kk31QA/EJTxryorZ+QH3txvpJNXwX8Vackn4+EnAZhc8Kp4dKrBvfyC3uwV48241+v7UD/UMUgRcDDw2lXP1o5ACFmVttLE1odVPrBJgb/dWXApxXzJn4Q8vsTNrHsUU7D3f6UAKZ/GgFiqzrvO4ZxmELtq5s2KK8mwPie6k5tTKdAxLZeDPfyo6xkAb5dCyWCjbwopCwZsf5tAyNS1FABOzCs/wz1i46hwB8klrGgjERUk7iRnwNL0c/fiDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814619; c=relaxed/relaxed;
	bh=Ayyh3GSY9IX8l/NxmtUwOJrSt8ohKQ1xsnTJeKuAZFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heOLDwdKE83ZBK2apC8llj9HaOtP9AyGrNdBsleWTV3U66+Ra3baSbJ83Wuyrq275K/I3ALbvi8aZx5RhOPnJMTGLKO396YP8NeKJQVAdfAFAnIw2fpoxM1s8N7YZOai2SND0IjYvE7+4/BbFvCXn0BezbvCR+uBbvtDjnabsFJZ0kdiPJOFG8IEybzkUYZrcug0Ft03YjDfNUtA7nF2kjSkhEzSYs9DVVb3GLm1f0/vT07YtpOSTC0FVxae7jZsZZUIv4qUJA4AfOhDxE1ANuKmbh6toDV5buX19csnOqI2Tr8vIHWM0i0ibwlxOZCITcqhR3iMxikZGhTWIOrjag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGhyitu5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGhyitu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXyy59Ywz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:50:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CC9E609EC;
	Wed,  4 Nov 2026 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC531F00919;
	Wed,  4 Nov 2026 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814616;
	bh=Ayyh3GSY9IX8l/NxmtUwOJrSt8ohKQ1xsnTJeKuAZFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGhyitu5c+TLBGkN2ZGwDU5Rsh1w/dzPMJRviHA5R0mqU+LsoYuTVg18Jscu2+6e9
	 Bde/aMBOPoYzdl/OGhbYhq2RMksr0qSkO6OBBKfsIB2QpTbcfD5O1d7DOOn6y0WboD
	 luv6dPR8E2zuVmQwRu6+4E313LCJ0DI7VA+RNwygcTxJ2P+0Zxk4UQl+ViD8uLTSyj
	 0Bj56pQlnnoENGhH5tM4j+e/k88FvtR06w4zxZ0OD2mDGN5+rEvzwyzh17+R2wIXby
	 my99TU5Vz2jDt+TrjxUCacOsyHguhDC7NltTczyRHXx91ZO5qtVY+n6qU6a+sO5L4R
	 ZOW5mHfdcdKFg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 20/51] powerpc/rtas_flash: don't read past the validate message
Date: Wed,  4 Nov 2026 18:47:06 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-20-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=7JHU1Fe1PUKfNakrIeb+3f7MU5rT/9SRwlQjBFg57NM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zru+45fmhHOmCTv0/xXyljhu8Ir9cn6xZ2brsiN/Z jmlm2+821HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRKEaG//GPri/6rCTy5+J8 1kMXe3b3xt9+LRAy/bux8ZXk+aLWoroM//OvT312ZfeyeUVOzxsmOu8P7DVL+ub/7E+HuUjwFae yubwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

get_validate_flash_msg() adds up what snprintf() returns, which is the
length of the whole string and not what fit into msg. If the update
results the firmware hands back don't fit into what is left of the 256
bytes, the length ends up larger than msg and validate_flash_read()
copies whatever follows it on the stack to userspace. Use scnprintf().

Fixes: a94a14720eaf ("powerpc/rtas_flash: Fix validate_flash buffer overflow issue")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/rtas_flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 722dbfb6fbf8..f1cd105f7426 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -448,7 +448,7 @@ static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf,
 		n = sprintf(msg, "%d\n", args_buf->update_results);
 		if ((args_buf->update_results >= VALIDATE_CUR_UNKNOWN) ||
 		    (args_buf->update_results == VALIDATE_TMP_UPDATE))
-			n += snprintf(msg + n, msglen - n, "%s\n",
+			n += scnprintf(msg + n, msglen - n, "%s\n",
 					args_buf->buf);
 	} else {
 		n = sprintf(msg, "%d\n", args_buf->status);

-- 
2.53.0



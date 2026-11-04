Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DF606ECE8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCicy7rM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXXf48qKz2yDD;
	Thu, 05 Nov 2026 04:30:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813458;
	cv=none; b=Zz03Nm0KBp/8yqcyFZuqcLUymoQx14iukeq/f3vJVE2OOLW42Phd163eLs7jhZwv5NN1Mro+mEfXpv2MvEvW5wgY+PYGHLIswwxwzx4nFFTU5lP2YUN5+e+zVt73AmIz4QivoKPctrjNB9rpLUA897e0u1x+0gJ7yHMSbaxOdxqRDbqu0aOg9TJyOH2Ttz7Ce+QMqTXyZ756xSAQjPmEf9v2ID8XfgJ+Pv/LjTXx4BZtmMfqTesh0oqnanlcMgXNbD3U0ultD0eQ1OLaoQmMUo/ywWG3hwk9CjNEdXgOVavhlxfmnQsiETOubF2l/VsmchSERpBL35QtOYJ/92079A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813458; c=relaxed/relaxed;
	bh=Di83VHF6QbwHOpQhBimI2/C2To6SvYozNijzJKB62VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bA7N52ffGAUrNLXEF0X8oZP5r7x5Sp7i86Yi/qY/2tQmmRy6ca7pachPH0dMMkwi33dtEQuZxb6GSXP7+yhwwuZKJL/1SwwNYqmlTLUOo1q0eZjBX7UvPIxKhTrscimxf5rOQnXTz9R17wPn/sjMoKh/CXcfv4SJiQXlXR6OSAsVJZqIF4CiHjsFY2/2M5L3RQYdCW/v3gjdJ2enI80umFkckxKaDSk1iCBwsY3zCrbhLgJHF7u+nVwOlTo9dqmAeh+tUjE+g16RspY/1PS9mO3x8xGNlMolS2xkukWwO7GUgINrzYmig7zyIUxglgm3jWA4F0tt2Gd78l44wWzbhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCicy7rM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCicy7rM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXXd5z52z2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:30:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54FFC4344D;
	Wed,  4 Nov 2026 17:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9536D1F000C1;
	Wed,  4 Nov 2026 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813456;
	bh=Di83VHF6QbwHOpQhBimI2/C2To6SvYozNijzJKB62VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CCicy7rMCCS60ygYj4tSP1y7JHeKnyohxK7RJ1MNcpLuKgx7RMIE9WBSxZSdLDPR5
	 klWdssG6lHnFI4UhtcT2/bxBTP5iwXEnSAAoqSD6pDT2Pane2TS1v3grlrW47TjH1j
	 9xxJKmZvczv/N+A7HlZXgnRiFRlRTmumn3d1q8qc4XOVhwR6AjNsL5hraO3EYgRzFf
	 j2hv3F++yHVgsp3epyVbuoy6NgYxM3knX51OJ5qkY/LQry+yFicpcW82pUIGh7VqAJ
	 QwR2l4cPAGUmHdYKORImPlXf6iJl3BbEIOeaBIzBx0aUmCCMa+g/IRmrE4JNBKD2k8
	 TlAkQuo0eyxfA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:27 +0100
Subject: [PATCH v2 10/51] zorro: size the proc files like what they serve
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-10-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l/jVDuzMOjj8ie0SJoZ9zbu/qnGtbORxwaULd7yJNic=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zmadUZ5+11/xl3DfvxqhE4ceqNydu+rxl9BGo/OLK
 ie/iz11t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiot6MDIu1ajiC3xxb9fnR
 +WcXFsd8u73oyPr694eefAy0U8iPmSHM8L+uTlSf4U3pBv/GqQV1N16tt3wgHZrdlySg93/xMSf
 ZKjYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The files under /proc/bus/zorro hand out a struct ConfigDev and seek
within that, but their size says sizeof(struct zorro_dev). Say
sizeof(struct ConfigDev).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/zorro/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/proc.c b/drivers/zorro/proc.c
index f916bf60b312..4c6f8f1c4d71 100644
--- a/drivers/zorro/proc.c
+++ b/drivers/zorro/proc.c
@@ -108,7 +108,7 @@ static int __init zorro_proc_attach_device(unsigned int slot)
 				 &zorro_autocon[slot]);
 	if (!entry)
 		return -ENOMEM;
-	proc_set_size(entry, sizeof(struct zorro_dev));
+	proc_set_size(entry, sizeof(struct ConfigDev));
 	return 0;
 }
 

-- 
2.53.0



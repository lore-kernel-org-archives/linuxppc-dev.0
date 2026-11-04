Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF84606F692
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTidc3ZG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY0Q2Cx7z2xnQ;
	Thu, 05 Nov 2026 04:51:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814694;
	cv=none; b=c9V8egoVX6wxP7P9vib9lIlSCMyuuXaFamKBmmO8BOgn/6N8S7mRBjb2JbtSY3GkzcTW3en7+ytfKr5RkW1w/l1OZqaGyW+uHHuKvxKZVgf1h7FPxgPEoSNuxfnuNZYuOUvUrmiUlYdHriQ7iysPhK4PrOm80Zp6O7lRR999iBo3owlgRugus3BlgOmUqsAVT7btnb0HklScBdoNpWdpmKkW567SW7UTR8/CHuoqBUbt9qdIp5xDbDydMQH1lgEJr+MrhWptmqHmXKFd9QtjjYKqAuAZ67+bb7T2i4mFAbmqwRSMbi1G9EUSrgLA/ZfqWi0lv5UEj/obx75L+rCcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814694; c=relaxed/relaxed;
	bh=E1vD3O9CKVYh6HjmlrAgiThE5xPMlSXjct4LkBIJ4ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWwhtOJ1sfhlWlufHYJhkULFJrWGek6PzsWig1W4ly81eCyNJS6yUFVr5us1Sy8zFf+Qk0NfeT4wqEQilRoyG646bI1BMO4PyWF7XqP6KboINkwK89qIPxsPMwz8Q1TrN6jWL4ofjEdnRzYFuvXyCooxlsmJyHxJUThrBOyX595Ff48U2LVSW7fLqnAOz6kEQU6TlmTxdaU1KyRnspojcTykDn365+rCau3tIh9cbRoE7HoN4MAKT/q/lFUyFvol842/icasmTzlh/BIzIRPUloQTmuFutq4VDEG3Fqcg+pgbliFUFLLw592emtCU3nFZrNQWF1L1NS3FeP/On5Geg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTidc3ZG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTidc3ZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY0P3lsrz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:51:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 783FD6022B;
	Wed,  4 Nov 2026 17:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80441F00A02;
	Wed,  4 Nov 2026 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814691;
	bh=E1vD3O9CKVYh6HjmlrAgiThE5xPMlSXjct4LkBIJ4ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTidc3ZG6DQkI9Vk+Zr6nZ+0Pv1ariRcKWpOZaHjUB13/k2sNBbs30yiyX6+yiHy0
	 XhLfUtzeKsMd2s14fzVjing8mXsTg9GPVyF+D7HxhM2JOno/05h8QGJ/OpDZLb1a89
	 5iNXriM20a3P8IKms8b+BrHgWU6kuTMh93epfuFbUMMIK8HZeuqdJpXYBJIe048tZu
	 t4MbQPatcoNdgYXUZlH/wZ14ucEumOSXNnrypsHgJpuEpbivjwib5dficqpT+MTkRc
	 eQanYcp7xT94DAQBNNR7JiADvWmbMOHcylJkVfCfUONsNhiW+36Oqtvx1ELJajB8v4
	 nA7YJqJ0gMb4w==
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
	Chuck Lever <cel@kernel.org>
Subject: [PATCH v2 24/51] scsi: ips: don't return 0 from writes to the proc file
Date: Wed,  4 Nov 2026 18:47:10 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-24-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=745; i=brauner@kernel.org; h=from:subject:message-id; bh=M56s+R4IzmhMvI79F+bEsnRzyAX8hD//ktSOts+7Usw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrsjdmyn4qx5nPEffu759zLB8uCtDwzMpk9O5goJN X+S1b3I1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRo56MDM07m/kvz13dEbyc 8YVpQHNuxt6bEwLeph3epTM1uHvJ4kUM/4snuhUu6e/oc1L7a7B1wvUwTdl7eYU5DM2B9etlHzK msAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ips_write_info() ignores what is written to /proc/scsi/ips/<n> and
returns 0. Writers that use stdio, echo for example, take that as no
progress and retry forever. Return the number of bytes that were
written.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/ips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index c7d6c5aae340..85c4fb164743 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1428,7 +1428,7 @@ ips_write_info(struct Scsi_Host *host, char *buffer, int length)
 	if (!ha)
 		return (-EINVAL);
 
-	return 0;
+	return length;
 }
 
 static int

-- 
2.53.0



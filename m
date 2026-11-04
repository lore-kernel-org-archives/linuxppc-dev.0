Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED9606A336
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEOj2YVa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXVY5y8Mz2xnQ;
	Thu, 05 Nov 2026 04:29:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813349;
	cv=none; b=cWvcwzvSurUZSQH764IzmsJritgWZ5Qwqe2AcUf4XgVYMnIy9c1nM3a6/qxYGyR4JCo3pN3h/bcUKpo8TxBcBgkA4OvbdSFup9ZP4W9WcbBEnEnqVDz/WIVK+a178wm+qNQYuvLekwPfDBI1MSkTAgMZGrFXrPwzzMKlAEFWDOJWKbJLSg2Baedx7oTChKUyY83qXyW7gp8hvdu/9bGbu2mGMVGnu35qGjh48vgR+1cr2KXY3lQhIQugguVBL5ycStMB+3oujaVhhS9fMobBvz6c3sP2WOUDmxUByorUzjYnDYZ41KI8aaRQRcN/1PTb0IBTnqxDBbb8Dpgg47EIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813349; c=relaxed/relaxed;
	bh=iSk3nsArFOOtW91DExIIvIg+E3fTnIkI1uYFn4dT7G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B81tTzgrAXzthbb3eA3r9pDvLIcUlUVtq5jxPnsbEihul5CwHxS7gsDdd5/lvM234Rr7F0+nziexFMzZ+vdO30ljjxBKcv4dZymXV2XbxLIj7Qi7knpHoGiJ6w9wUPcxd3OTB1HQs3jWQxfOFVrXIwJR3ILA3EBWP/MJ69oaBuMNLGCi4KVdr7IwDIBRFJx2prni+vOWbkGr5OG0Wi3AxRUJW97Ngu2trz4SR5yywC5yJMRstm61zXDb77o+8GvQVwze9QqiOY8TgD4NnOBCF73FsmbCP3CF+h9AD9hUUGztQmM1692Ep9le4hTMoQIkn5O6XWzY7ZIR0ruLL8+R3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEOj2YVa; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEOj2YVa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXVY0SlKz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:29:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C80C43EF4;
	Wed,  4 Nov 2026 17:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14F1F00A17;
	Wed,  4 Nov 2026 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813347;
	bh=iSk3nsArFOOtW91DExIIvIg+E3fTnIkI1uYFn4dT7G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MEOj2YVa2iIdpw5z2/NDh/nS5/9YiUTydJpsuXgkbKBwIG8vtJQvRf2LpeGPo4QZ5
	 w29MCiVMYZK7VIp0BshBq/zfoff8EDzOUsrS5HBn5xxq3ltk0oB2hX5ygXPEZjrVf1
	 854j45f/iRAVKq/djckCLygA7FB8p1Zjx7psO38vVVq4bUsY5bxXVg/eXgiknxxWqI
	 hhIFdc2uOWPB7MwA+0cdYVBWRsQi/CpTqM6ZnNZzgzc1bKeu5HnQD/VzYrhxCaOFwx
	 QQbgQRnwMpXNmlsB9GdCiLATFPIHwQAd48vJlnM6Cja1L8MMtttR8X5ndAXXSShUjS
	 FxpuymjfsN7fg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:19 +0100
Subject: [PATCH v2 02/51] scsi: esas2r: don't copy kernel pointers out in
 EXPRESS_IOCTL_GET_MOD_INFO
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
Message-Id: <20261104-work-procfs-bugfixes-v2-2-bbf7d5546809@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dmwAod4+27NCncmw2oz8APM07k66EUOhHcJdusbTjjg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zvot03G954L932VP36TuXeTVkvctkvdOUEqnB1ulu
 qr1gnT9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsecPwz3hDeHERzzPPdYxN
 RjfC3XXUD1tofTqbtTjgpUSw4qvK64wM82LMu/+u3bKn+1TBxf0qvr9PTk2YlzJFZyPv1Nw/lcX
 L+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EXPRESS_IOCTL_GET_MOD_INFO fills in the addresses of the adapter, its
pci_dev and its Scsi_Host and copies the whole struct back to userspace.
Nothing in userspace can do anything with those addresses, and the
ioctl is reachable through /proc/scsi/esas2r/ATTONode, which is created
with mode 0444. Only pass the host number.

Fixes: 26780d9e12ed ("[SCSI] esas2r: ATTO Technology ExpressSAS 6G SAS/SATA RAID Adapter Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/esas2r/esas2r_ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 3f7c1d131ec3..c93d9265e100 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1468,9 +1468,10 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 
 	case EXPRESS_IOCTL_GET_MOD_INFO:
 
-		ioctl->data.modinfo.adapter = a;
-		ioctl->data.modinfo.pci_dev = a->pcid;
-		ioctl->data.modinfo.scsi_host = a->host;
+		/* these are kernel pointers, userspace has no use for them */
+		ioctl->data.modinfo.adapter = NULL;
+		ioctl->data.modinfo.pci_dev = NULL;
+		ioctl->data.modinfo.scsi_host = NULL;
 		ioctl->data.modinfo.host_no = a->host->host_no;
 
 		break;

-- 
2.53.0



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE4606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adc5P9d8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZtm40njz2xf8;
	Thu, 05 Nov 2026 06:16:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793819808;
	cv=none; b=JtNRbXoEb2MBXxSAOIfFBZT56jhLO1jt9Cc+I4g7DGVm+gszDJm+WY40m/iTwH8PAya5UYFB3RJ5yT9OdDZjO32vAhGb6RKlm7/Fk3uVRC6eMseAFHINiVN0AFa+A5RD+c7+AwEVHQKpmP+8pWV/6Pbr5fdkP2BwVxYBNNPljv0F09ytBczX4bRH4dvEBxxfjVPyeGFJMjdeJ+IADEWoyUaRGH4pINmp8fKT3oq5jdnt0gDaCsW38wilpJWWqotCtwd5vSuWHLJW7+p7vGf4Za+HFf9fBxEs60jc8yJ1kHKwInHogxHnAxO7S/psfP+TrWFkqbFe/yGvwbBM6pNDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793819808; c=relaxed/relaxed;
	bh=iSk3nsArFOOtW91DExIIvIg+E3fTnIkI1uYFn4dT7G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAq84CUDH4cCE2Pzmtbvmga3UF0/LWIiPYUJ8FQ1yx0CWjwH4jYM6wdyx9COHwP0XmqtZqwPaf2h9efkKtrGEqsRmaIHLfgUEVWcMSmA50Ij8WBTTB6sbg/gUdEhhssBGCHBH9BXBFdU9obo/BVZjyabj5C7sQXGzqjJEpew4DLcBm67fcOJL+Xm2I4ThhMc0lTHLFMshUdykwvqLQXy7GJqd7w3Q60UTq43M3Mit4pDwri8ztZ9Sos2vyPIjmv8XYXYqGXNW4W4lTimPsKDCyNsoRlbyGB6IzsVH0qjh/he4tA++KJG9AkS7zSMd5wlEsaGZTRSd8240A5tS5xUBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adc5P9d8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adc5P9d8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZtl46SNz2xRv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:16:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 94D7841890;
	Wed,  4 Nov 2026 19:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406881F000C1;
	Wed,  4 Nov 2026 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819804;
	bh=iSk3nsArFOOtW91DExIIvIg+E3fTnIkI1uYFn4dT7G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adc5P9d8MahDP5MWnF8/BQZpdhwQF+Ch+DamqvSkAjn9rCUlBnkqECo/i8i5m6rCU
	 r+0D3t4BrnoadvsSIYVAap135Zl9/uPV+3cWE1MIZO02KbRYUYm6qut6Iw4ZTKqOu/
	 6k7TrsWTmBmMQUM3tHfS92Olrwro6VG7uRQk7JNC9KNK3inBXn1gscAHaKpctq+lkz
	 NHgRnuuGNNngzWx7kkuO/bS69mOTmSTRK/+7SYlvkts5zOYpp6/1gj+SaDwhe5nUBd
	 NQB1zsZF5ExMRUSJm8geywWpAxhsrbuzBIhJsIT/iETtc8kHozEESlyxMXTZO60F+g
	 m408MmhemLThg==
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
Subject: [PATCH RESEND v2 02/51] scsi: esas2r: don't copy kernel pointers out in EXPRESS_IOCTL_GET_MOD_INFO
Date: Wed,  4 Nov 2026 20:16:30 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-2-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org; h=from:subject:message-id; bh=dmwAod4+27NCncmw2oz8APM07k66EUOhHcJdusbTjjg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bjzbuC42lkN5rrFaxyvfJQdiNbQZ7W/e2Jquu5RPe /ZM3ftRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpfM3wzy5cJTFdotRbNPeq 5U63fQ+S03+85HippbBf44binOdz1BgZPlpuOyXM5rh4Ucv0N+t5PzZYf39meEdz+QFRtsctyxa 1cQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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



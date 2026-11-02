Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6460A44DE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJsS4rxO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFSn3m7Rz3bjN;
	Tue, 03 Nov 2026 02:08:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632089;
	cv=none; b=OftjukK7i034XY/OZV4/1nYukkmLs/tNKCkxg5aP6ffTNaiESgdmp/ppaA9QdMFYNaqWNNeA7asaEb9h2y862DmxKbdoeC/P8LTET9nJcFS5GB5VUdxXyDGJC+3DY1DOezwb0MwTnu+zy8IVXK1TdyOjq+I+Sqw6lvIm5pnac6g8lz8xWBRqHRcCHa43QFJh0DS/tHrzZSdpHq2Oi/O4tD+cBxGFjvcs4zCxKNABxZubdVrE/hmycf6BmWSOEjAjNh+Tsjr5d5eDmWrWZGoMO3yCWU2IkgU1c1FO84FH30pRueFLNAPo/sG6M5rEZn3uLV/DZZKQwP+Rl4xRl0Samg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632089; c=relaxed/relaxed;
	bh=6VXp+nvPq44Iibfd7M3dnZqyMxw2lTQeTkLffGnpGI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jUBCKO66jNZgJLzu+SlchiPKPo5NuativcJ16URrFBRnMgNYwH96da8OaQlU10/UpwnzVXsduK/5qV+VAWZXYFJ4+SxyZ8CfbiAzLovBCwUlougfdDLTkm+avJjSw9DwR5a6jX06Nq1lBIE27DoL9F33Zi3yFO3KcV1TB6+v4pG/SOG5z9nl6GaDSy3bxy5hWn6yWhMJHlpZ0/UAb5GT6KOuid7HLWLqLkdxnGjfSAkxDHNVF/P6ehLX4lWNaH+pObXQM+GWDkPP112QG/uKigcjAfBQxc+ehD4jOlbO+9mUzoMVuQxacn+l6RMqcT+5n5cAhTDPJj03uvRKsM8Z7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJsS4rxO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJsS4rxO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFSm4FH0z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:08:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18A8C43267;
	Mon,  2 Nov 2026 15:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8D31F00A1B;
	Mon,  2 Nov 2026 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632087;
	bh=6VXp+nvPq44Iibfd7M3dnZqyMxw2lTQeTkLffGnpGI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IJsS4rxOrw0evPnx89c/k4QBxYWHpvmf5bC5nkZvS9heIkdiPMQ9+UGLYAqwXCeRo
	 01xMhphWRq3Aq5SpmzQFwBYXFYqXKEaXV7aEPiCoGMFOQNxw7pWWisGb5yaQPmI5Sh
	 tp1LULK9tthAvY5/hntPoT0wfDOVWswz1/lwzqVDgSpYEcKIVZ8JMYeE0wU54k61kO
	 ToCwYStQ9aor3WEDfPrJ5VAU7p1igwmg/9f/J70vTmuPCQCbfb4H8bgp2jfpfxr9Bw
	 Lja5YKZ94jQYHKXWFN6sFWb+EV8QZMwi+q9qWB4+h7zvBC2rh/ZxyN51W+VcpcOFR+
	 oDn8HTPgDHHnA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:46 +0100
Subject: [PATCH RFC 19/22] platform/x86: thinkpad_acpi: let procfs copy in
 writes
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
Message-Id: <20261102-work-procfs-arch-v1-19-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/acpi/ibm/* before it pins the entry, and hand that copy to
->write(). procfs already rejects writes larger than PAGE_SIZE - 1
bytes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 01e4c980fad6..b4f253da9536 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -881,33 +881,25 @@ static int dispatch_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t dispatch_proc_write(struct file *file,
-			const char __user *userbuf,
+			char *buf,
 			size_t count, loff_t *pos)
 {
 	struct ibm_struct *ibm = pde_data(file_inode(file));
-	char *kernbuf;
 	int ret;
 
 	if (!ibm || !ibm->write)
 		return -EINVAL;
-	if (count > PAGE_SIZE - 1)
-		return -EINVAL;
 
-	kernbuf = memdup_user_nul(userbuf, count);
-	if (IS_ERR(kernbuf))
-		return PTR_ERR(kernbuf);
-	ret = ibm->write(kernbuf);
+	ret = ibm->write(buf);
 	if (ret == 0)
 		ret = count;
 
-	kfree(kernbuf);
-
 	return ret;
 }
 
 static const struct proc_ops dispatch_proc_ops = {
 	.proc_show	= dispatch_proc_show,
-	.proc_write	= dispatch_proc_write,
+	.proc_write_buf	= dispatch_proc_write,
 };
 
 /****************************************************************************

-- 
2.53.0



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175B606A59E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvt3N63R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDZ05lLXz30dn;
	Tue, 03 Nov 2026 01:27:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629656;
	cv=none; b=YhOg2rNHZkTfLp/DEyntacV9zNSk8GCcWRMAJwqoXYCmszN2yIsQpZPAX+CcpWtK9kEFTQIwOO+VjsnF4vJg1j4PLDxP1YOAOQxdGDTCRplIP5fIOrZ/bpjDFms8mc2XNkg90lK1EpNa0wVgQmOrLd5mquYawUFIRc8a+HDnX1pKQ2Esoo1tQomY9FZFlphczSAInvO8Wo88LNV2nQ+/wDnhVxt/NDMfDMhOUBdBYoOIRts/Wqfk4seQQTsnCyycl2MdeSr9SvQJv5p/gnDshOFaH1MEmP20rB3GEUDFBXmc0owq541fm7Es7m1FEEWYV/tiP21FsbhrTXRTM+c+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629656; c=relaxed/relaxed;
	bh=v5t8qKNo68SCWoforDimF8hL2ZYL+p0Okj8bWoZ1JT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8PF9OZpC0Vc9F+MZMmsLp5pv5WElENMuAat/oYXBK2NaVIJV19I+Dd/1EGwD1sZQb8szwno8NHgNzs9tD7Bj6+uIVCtp/9mdxJmJSesBKRZqr9z2jATCK2xHJV+dEBjT+Dn956QmTsRywXfBp/sqOsbS4YJixz+mTpIUIMBRX935rTviN0qQCRoXuz8/2wBNFmH07E2B3a7l6TkxBPkRgOgozTGtST7uzvb83ne8JUsQI9JoLhJ+xFLIeR/+zmsGLdSrGDCFNLy3JCEzz4qunYpr+hoqbNzaq7cCnPk/z6368I0KUmwBkMVlzrg/oSGIH7iZKmn72JHuJaXDJwKqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvt3N63R; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvt3N63R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDYz6NZjz30dj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:27:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D7D6A60238;
	Mon,  2 Nov 2026 14:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFDE1F00A1A;
	Mon,  2 Nov 2026 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629653;
	bh=v5t8qKNo68SCWoforDimF8hL2ZYL+p0Okj8bWoZ1JT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hvt3N63R16p2fDZtChXjcMwdKVbvtxfkoL2k4OxbkJ9NXiN3sUvoI90Anz8tghLzV
	 tw7TRLB1mJI+ndKzKgYA8EusdDfCEFHDNDNB81AIW3QjjgCwg/TU6I079wNwJuekME
	 GgYfwUhSITW0rfvdsRQDJf8rj9zB05fpKjF8xVxdybjPcer/CH1qH37gxEgqe+026Q
	 OuFUuk+WcD3uSGWDc90qsgO7GgFfaxkgSrLrqyeXVxjbcarjoj5jc97EhboLO3/3O0
	 KcAvyFsBb08Hf5sOjHYp74WBf8FtRIs604ayotkQgHKNOSX4SCmldQ2ODja09nMv8N
	 2p+DzdlRSt69w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:40 +0100
Subject: [PATCH RFC 25/38] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
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
Message-Id: <20261102-work-procfs-bugfixes-v1-25-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2dbZnDPFapx3dAW5qeN54CL6hHWBvjsrs28L3h6tsIk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJOT3t4mUyCor3Li661vsa/yObLOB7XeUji6boXCC
 secScIdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh7WFkeC/LwqiVxiMX6PN4
 IXM3/4WNlnf/rlkw4SVrp5CBfEGgISND+4Gm4KSDXU7MDmLZHq5y5z4dYP+8p+ODD1PYa4mTduu
 YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_oldmem_page() maps a page of the old kernel that isn't in the
linear mapping with ioremap_cache() and copies from it without checking
whether the mapping worked. If it didn't, the copy reads from an offset
into the NULL page. That oopses unless the copy happens to be a user
copy, whose exception table entries turn the fault into a short copy.

Return -ENOMEM like the other architectures do. read_from_oldmem()
turns that into -EFAULT like any other short copy.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 103b6605dd68..1543917bd3e1 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
+		if (!vaddr)
+			return -ENOMEM;
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}

-- 
2.53.0



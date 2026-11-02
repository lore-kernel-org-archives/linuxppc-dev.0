Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB868607E0F8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVwyyj26
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDZF4YCFz3bfF;
	Tue, 03 Nov 2026 01:27:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629669;
	cv=none; b=Fdez7Ndi8NBzDDFD7kJ3PQhHJ2iOjZRaiqi070PmvhE1p6WAoaPJjrzCqzIy42o+7of5z9umjxYPxaZykYX7TY90XrfipTuX3Q8gqBC/9o8ocHxVv4LZtqxRPrJHQwu9ELWHbli1TILPKCO2WimCghs51SNiduxJRyN0+3nh36BizHvZ/eVsma8IARL5RUarM1TYjOgXG2GQtuDxeFOcvjBYP3RaUhAeOaliGKqwKi3gpvFNNBVTBiFXWXMMKhEV6qJM+rL18IMX8a6YwQrPDm1M/OKARyPKOiCGQyvMILzj1p5nLU8YHjZu0e71bNz+V/6vmYqY+hpYwz3F6OkXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629669; c=relaxed/relaxed;
	bh=a3x3EcOd04d3k5+O3dMfsGmWB77s9fU2q2h860UaVdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GK0F0G+3q64/pdkfHwqkFEPDmtR/JzomQWu/MjmZW3DwqjLI0BxeeDIxhhJ9n4sZqTusXWRs50Gw2BBSzFMzxOd35f5ouehh0hIc+KalpY7b5Qg2S9sw83bj0Z0ytSQJOeHmnhSSADDltcSkG2Q5swEsBTWp9YLcMe2unsTTODp6c/bHpO53ivdipz9ussPVgYgx5zBy1hXASabt/Yqr8r8pquX7GdyUZrasLZ2o/59vHKafOf8r2p9wgFhEjUca4jsb3GGznGBLw8AAPFbBczlwMJxoSFmPTqJ72cYxBm/ZpZoq4XYsSDEGbGqsr30KX/mxZoaUbxckmAaHERXReQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVwyyj26; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVwyyj26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDZD5nWWz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:27:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2296601F1;
	Mon,  2 Nov 2026 14:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5CA1F00A16;
	Mon,  2 Nov 2026 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629666;
	bh=a3x3EcOd04d3k5+O3dMfsGmWB77s9fU2q2h860UaVdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RVwyyj26nRGz0YAa3qJjLMbMcY59GFv7k2/Yo4WgpVWb59sfMb8Zl9naRaGYP0rou
	 MMpo/iaTuwZ+wi6sRL6CWH+xBh8p8Hh0LzLpasPr6e/4udRG/oCcZ29xKchnIx3/p+
	 B3Jo+wFAlApWU/ThwP5etPS2jmB2GKh3nFbyeKDeBWGAaYO2fqeijfiRa42kJVjmo5
	 eE8+TH9zCGeavvC5T8ODN/DYi8pcd4vmfSKYG4AUNTrxGouYTZAQo3PNclBsTunvuS
	 i1W58HX+mcpImcnTaTchfOLoReuEjUSRmdexvU8N4yNjatMl7C5uOyxR6YUyGiu2Qj
	 eJ8cshD06UL+w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:41 +0100
Subject: [PATCH RFC 26/38] powerpc/crash_dump: recover from a machine check
 in copy_oldmem_page()
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
Message-Id: <20261102-work-procfs-bugfixes-v1-26-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=46QTFCl18GYq9rYmjhc3/nfnECuPknUgrDKXTEluZq8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJNjfd/SLtTaSr/hcs8Or+rV/z323q+aevR7v4GS5
 AXFwhMXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyv5Xhf9Ujn1e//n02s36h
 97fg8AGx5+WqXD/VJ1+ZtszhE6fMyz2MDAuiVhYyzznyU29ZeOz86L3bl/VWxVxten6I87kdz7q
 Q9ZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A capture kernel reads the memory of the crashed kernel, and that memory
may well have uncorrectable errors. On powerpc a machine check in the
kernel is only recovered from if the instruction that took it has an
exception table entry (cf. mce_common_process_ue()). copy_oldmem_page()
copies with copy_to_iter(). For a read() of /proc/vmcore that is a user
copy, all of whose loads have exception table entries, so the machine
check turns into a short copy and read_from_oldmem() returns -EFAULT.

But since commit 4a22fd20379c ("vmcore: convert __read_vmcore to use an
iov_iter") /proc/vmcore can be spliced too, and splice(), sendfile()
and copy_file_range() copy into kernel pages with memcpy(), which has
no exception table entries. A machine check there panics the capture
kernel. The same goes for the reads of the ELF headers and notes that
vmcore does itself.

Copy with _copy_mc_to_iter() instead. PPC64 selects ARCH_HAS_COPY_MC
and there it uses copy_mc_generic() for kernel and user destinations
alike, which has the exception table entries. Everywhere else it is
_copy_to_iter().

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 1543917bd3e1..ca7e019ae3e9 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -83,12 +83,12 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 
 	if (memblock_is_region_memory(paddr, csize)) {
 		vaddr = __va(paddr);
-		csize = copy_to_iter(vaddr + offset, csize, iter);
+		csize = _copy_mc_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
 		if (!vaddr)
 			return -ENOMEM;
-		csize = copy_to_iter(vaddr + offset, csize, iter);
+		csize = _copy_mc_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}
 

-- 
2.53.0



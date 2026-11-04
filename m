Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F316082088
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkCvPqeJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb4c0Dssz2yHD;
	Thu, 05 Nov 2026 06:25:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820319;
	cv=none; b=cZ6jrYLp0ij60qgriH7EwHzwe9yBzRs3UvidA6ZTsGPDNxmamY2dnjjAm2Acbcnvu7eZr74EWXCbPUGKGgr8cRb7OTI3VAzlrQYJnNMVmuS2jANfw08lAGh/YlwOzR9hn4JGXfZLI9CoYs47e9JXF3hILHASiO4Q3l5ALUXmyxbb0yqobbxz3pxIVFbna96oreSbqS1nKdkzslGVaqEPjgzooLpXdM7yzDjJDbd9NGxsDqT84YA6HKvUwuxuZbNmpT5TNHS/aSpP3NJMu6WpaNeeinmNPUNYe2bHwTt6oIf9sHul5l8ef1xnofiRNJLUM3xEc6FClGcCGckv+pcG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820319; c=relaxed/relaxed;
	bh=xlRe6ByN3zpYNOlJQq83OVbC6fU3d9RayIfuGISBpLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxvPxtkDCCemyLDrgaXDBBzhzT6xvCe+0UBd/rRZJbDkNPD+BLXMruzzYl/KWx9cn5BSV9NF1TZ3261cqIXvCHQeP6+KxzEqkncfYNQY6LixVDyDmt2pFq+aiwHyv7Mlg4+WGXRMixZ8O9R+gsrUrXcT1qFG6QjeVTNrpCAORUjMuhLkD2kZnJ/ffLDnO7AwWXHfW81AiZIYjG+q1er9evvwlc/Qm1ihOhmBo2b2Bm2KZNG0VpsUHtJ4L5DU/TiMgqdbLh5i9D55lax8gp4jZRUogAu9YwxIfp8cIXkoyR1AnQXdhGUgZxgjY1wE1teCvdiq5TbRVWKT8vCumhKONg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkCvPqeJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkCvPqeJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb4b1hNYz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:25:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5ECCE60DA4;
	Wed,  4 Nov 2026 19:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76511F000C1;
	Wed,  4 Nov 2026 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820317;
	bh=xlRe6ByN3zpYNOlJQq83OVbC6fU3d9RayIfuGISBpLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkCvPqeJt9hXEFyti3iJ1FwuLHxmLXyjHHLihOfXAuh24SOvF5m2sIXA2UBAh8zQQ
	 tsZTpgZBpzYwBDlu66b4vShl+NYAJTi7OGk2wP7Ucha8AWhX9jcDy7R8S9N5GjeOby
	 MOJMhwZqq5jk1LHpQtOrhu5TAJznkDJyCPku1XJuUlWnmjNp6Lg/pIqjCYjb2E9pRw
	 PlIWcj69apuPJIahs9+j3NJIIhvqdlJy8k5li84RC/zXcbSfahqzG08MO06TAxTgGD
	 MsdlO68zHBsAVPP5uOrOJ4ggSIX4Lm9icnN+egX0bDbSKuctAZGL1q6hKv1U57BXdn
	 DGKynIt51Y7WQ==
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
Subject: [PATCH RESEND v2 37/51] proc/vmcore: don't let vmcore_cleanup() run twice at once
Date: Wed,  4 Nov 2026 20:25:02 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-37-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=brauner@kernel.org; h=from:subject:message-id; bh=gmON/Vwu30bm66aR7FLjt15bWl4pslPspuVjwp92LoI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bvzZL8Hl33wxMMfFJ8kjYsv9ztuaxT/NbubGcJp7u i+Umj2lo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIcnxj+2TzZ/6BE4al+9D+l /+ZvBS6e1/KbqBD6LzUpOUjjyhHN2YwM69oa4jcaTUuZdOZNvK/7ramu9j/M3Cx9f4RUnOD8bDu LDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmcore_cleanup() has a single caller, fadump's release_mem_store() on
powerpc. That checks fw_dump.dump_active without a lock and calls
vmcore_cleanup() without one, and kernfs only serializes the writers of
one open file. So two tasks that write to
/sys/kernel/fadump/release_mem through different files run
vmcore_cleanup() at the same time.

The first one removes /proc/vmcore and waits for its readers in
proc_remove(). The second one finds the entry already unlinked, returns
from proc_remove() right away and frees vmcore_list, the ELF headers
and the device dumps while those readers still walk them. Or both of
them free the same lists at once.

Serialize vmcore_cleanup() with a mutex of its own. It can't be
vmcore_mutex, removing /proc/vmcore calls release_vmcore() which takes
it. The second caller then finds nothing left to free.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserved memory for general use.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/vmcore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fe70c4ecc54..ccb795b85509 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1764,6 +1764,11 @@ fs_initcall(vmcore_init);
 /* Cleanup function for vmcore module. */
 void vmcore_cleanup(void)
 {
+	/* Not vmcore_mutex, removing /proc/vmcore calls release_vmcore(). */
+	static DEFINE_MUTEX(vmcore_cleanup_mutex);
+
+	/* Two writers of fadump's release_mem can get here at once. */
+	guard(mutex)(&vmcore_cleanup_mutex);
 	if (proc_vmcore) {
 		proc_remove(proc_vmcore);
 		proc_vmcore = NULL;

-- 
2.53.0



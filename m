Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B360A383E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzlwkTf1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDS943txz2xjQ;
	Tue, 03 Nov 2026 01:22:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629353;
	cv=none; b=VckX+p4Wp5LdQ2Pf1LhyOmArxU+tFRbz+Qa76zr6BU5CttjfS4NJIYNGf7BPapyPuYsqvXFSpar8ivFE9EH2HNEjqnGpVbEFs1N+eB690Ul/XjFWBVWmBNn/ohDzpvONqYU1GH08GFst/ejCFLNpEiWmkM8SiKSqPc+u8IQ05hw3DnXiwejJqBPPfzuDt/U5+JrcSUBpqn7tfFjJXOULJh3IwoTreYJbjIzVb0QQLCIiZZs1KbBpyCfem77u8GDP8lB2HwFzaxdl0mXaUlhX+IQCW+ngC6kemT9BALsCYoOc9V3jPJpBH3fBK6XdXvqB6eLJXOs/TtvnL87j4HTl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629353; c=relaxed/relaxed;
	bh=PBbW9vd5orssW5wPAFhy4fJ1NNWUPnjkdaOH9xfStLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfa476fjh7SZRgZ7oV8WOWCR3pOta9YqGQWcWxbBvrh/sjyULcngcVJmFDHsZJLnopwkiQnnTWuxcYNx1/yxXPoAGrc5qI4CljLrpAF5ohdUHdaCSKGYoCPgVTvUkFj05Z6R8E00Y6ZO218s1qxH6Qg8nIn57/Qsx8OvpIsr8efCrEzf/+MtRiU6LmGKBEh8fgH77Hh0dtNEjkQNWRxnolS8ZOTd5fng7Spvb59WHGRXkHU2moKt9P35xcCV1e+ctLRVE1ku7bROo1s9vC2zCWRDcQn0vrfqeIQxuRmjG39TMKCSAHCTpknMCx/1idbB39wFynjE/9QvDScvn2TrHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzlwkTf1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzlwkTf1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDS85ndwz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:22:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5059143C6C;
	Mon,  2 Nov 2026 14:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95AB1F00A16;
	Mon,  2 Nov 2026 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629351;
	bh=PBbW9vd5orssW5wPAFhy4fJ1NNWUPnjkdaOH9xfStLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nzlwkTf15kz/wAHmBv8TBSldFi6uEzRKAH35yysNrDb/8c4TQ0GCZP0ASoI6HN4b+
	 ehOxeihtKt2HTRVjPCKuuAHd7Yek+ODFrF9sc7qm/JijqtRdS5y2myAabKFf6nxaRY
	 9Pas0GKbkNwOm8LlfgjzjeZcMkMcrZUeHJnggcdEQMEsZzosFpVfMgmLvRZKouwlv7
	 JAi2ZqGrZot0jagbs1UODwU5a1zpC6WH70gNu4gGQL2YE+NPG7eToPVeRi3etVDvtY
	 UcK5AZNwgPpnQ1ESM5OY+AU4XnwA5+oNTxzQWf3Lr2JUxoYKEPM809nyjile28GSz9
	 DmBqBJEb70aSw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:18 +0100
Subject: [PATCH RFC 03/38] netfilter: xt_recent: don't remove the proc
 entries under a spinlock
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
Message-Id: <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=brauner@kernel.org;
 h=from:subject:message-id; bh=boUkBs9MzJMgPbYDfsAEaTT4QAw3bhdvazLBbZuX36o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJP1dtcCf06Gp9u3x217c+fnxNyHHy8FLGAsr+cWj
 t0U+GBRZEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBFXBgZOrZozFPorf+h0Kmk
 8bQ8/Jz+9tqixhUCbka+M1baPWjgZ/grk3zOPFaz+iTnzmKxIH+uEl0pWY3mLRIpLJ96Q+YuEGU
 BAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

recent_proc_net_exit() removes the proc entries of all tables with
recent_lock held. remove_proc_entry() waits until nobody calls into the
entry anymore, and reading one of them takes recent_lock in
recent_seq_start() while procfs has the entry pinned. So when a reader
gets there while the network namespace goes away, the exit path sleeps
with a spinlock held and bh disabled, waiting for a reader that spins
on that very lock:

  BUG: sleeping function called from invalid context at kernel/sched/completion.c:116
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/u16:0
  locks held by kworker/u16:0/12: 4, last CPU#2:
   #2: (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xbf/0x860
   #3: (recent_lock){+...}-{3:3}, at: recent_net_exit+0x3d/0x170 [xt_recent]
  Workqueue: netns cleanup_net
  Call Trace:
   wait_for_completion+0x8e/0x400
   proc_entry_rundown+0x1ab/0x1f0
   remove_proc_entry+0x1ab/0x530
   recent_net_exit+0x9f/0x170 [xt_recent]
   ops_undo_list+0x271/0x8d0
   cleanup_net+0x3f3/0x860
   process_one_work+0x946/0x1820
  BUG: scheduling while atomic: kworker/u16:0/12/0x00000202

  watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [rloop:252]
  Call Trace:
   _raw_spin_lock_bh+0x7a/0x80
   recent_seq_start+0x86/0x1e0 [xt_recent]
   seq_read_iter+0x26d/0x1230
   seq_read+0x2a9/0x560
   proc_reg_read+0x1c2/0x3c0
   vfs_read+0x176/0xb40
   __x64_sys_pread64+0x191/0x250

Tables are added and removed with recent_mutex held and that's also
what recent_mt_destroy() looks at ->xt_recent under. Nothing that runs
with a proc entry pinned takes it. So take recent_mutex instead.

Fixes: 665e205c16c1 ("netfilter: xt_recent: fix namespace destroy path")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/netfilter/xt_recent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 55f1f2d89952..11acb9a50d4b 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -652,12 +652,12 @@ static void __net_exit recent_proc_net_exit(struct net *net)
 	 * that the parent xt_recent proc entry is empty before trying to
 	 * remove it.
 	 */
-	spin_lock_bh(&recent_lock);
+	mutex_lock(&recent_mutex);
 	list_for_each_entry(t, &recent_net->tables, list)
 	        remove_proc_entry(t->name, recent_net->xt_recent);
 
 	recent_net->xt_recent = NULL;
-	spin_unlock_bh(&recent_lock);
+	mutex_unlock(&recent_mutex);
 
 	remove_proc_entry("xt_recent", net->proc_net);
 }

-- 
2.53.0



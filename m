Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E204606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0H9lG0B
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDQS2y8tz2xjN;
	Tue, 03 Nov 2026 01:21:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629264;
	cv=none; b=HDZ15rm7WWMb8Z7vMtKPr8Adz0LqnACS6QKxyNbfFUuIC9KROMgKwzSxKzASBg1oUOzhFWVwifBTeDFgzHJAaR7h/OR6zyEXwRLKJVurpPKiPwVbm2EupecOUt06LJvUR+AvcOVSioAxjpwF6hskU/FMsqaz1nBnMHYAYzS3Kb4bKGazPWvfR0kkGxLDHSKlUkfqG6g4afIh4JB3YnA4UslS+ZMb/OTj53f7vQVTfhGYi+yc5HO4W4TJVnY/PrBIp3cUMf4u/30IBYtut2oStiz8nKDnMlIA2b8axb3aDv7jDWNbJJvV5xCks3BguBtw2V4vwdQDqKOYxpl6GtIGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629264; c=relaxed/relaxed;
	bh=AMQhAUoLjC1OsRhPIF0X/aZZvhoGLtnfpHmE2nV4Wn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MR/DPLA0ys8DM1RU1MjCQsrGBhZsZNZJAMak82lN5Ke7EdIhlN+G/A0HxS6n+C89lnUiZf/+CkakmDugg3XduthCdGZUUE1fgWP2ja4gVK6IhGEjKZvSlwcdlygC2BPiOm6X8IUbMG3bMr9ijDP4rlg28GpWxnPtJ4JCyZnKY6maMU48cv6SclCH5lpc61u9ncRibJHIL6rG4VBi8IEnVVI2OiKN07ZSGocGzgcD+KX+hiIaYJFoMzAfnaF5YJGyltW7TW5BdVC3CLwG/ah3Xt0hy0FCb+/JwiHXmgCnxoHlyVaAn+RItpSXBftwn9kuUX0gogQF8fw6sbuo8yaCXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0H9lG0B; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0H9lG0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDQQ63kgz2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:21:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 34216406CA;
	Mon,  2 Nov 2026 14:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED4A1F00A24;
	Mon,  2 Nov 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629260;
	bh=AMQhAUoLjC1OsRhPIF0X/aZZvhoGLtnfpHmE2nV4Wn8=;
	h=From:To:Cc:Subject:Date;
	b=i0H9lG0Be05TEfu/3sSSx1mNu2tXsbt81HU4VhWr1YaNjWqP1nbmV2PU6N9fCZNuw
	 nivi01r4yhBVK5q6ZZ/2sNWNfeS1/SVvtod3GB/cMk9XHlaJxrROzU9uNyaCbwueWN
	 AE/rw/aIukHRd/bUpfVF3u6Oo+d1/1nWu8xicACG8hfScuBzUWJR1oSKGUI3TT1yza
	 I6qw7gNhliBS+HPnhAgAxa3M/VUpvB8uzbr6ovyo5O6M56NbveIxMw0j6pJhZqxruk
	 pALxbTScur8TNXplk3A0Y4Q0gW4y8sE5l288k+10HrKs8+OO7WmnOZctFatwni3om7
	 HzOPbsKYJ2AYQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	Chuck Lever <chuck.lever@oracle.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org
Subject: [PATCH RFC 0/7] proc: move procfs to what kernfs does
Date: Mon,  2 Nov 2026 15:19:15 +0100
Message-ID: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
X-Mailer: git-send-email 2.53.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6321; i=brauner@kernel.org; h=from:subject:message-id; bh=DeFgfcqlv/TY20j7H/EH1gPUF0B7m3TaniK1kcChAz8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mGNqL7pz+vPzk4KWfT6wfNmBh/f/+az2dnquniC7r OfbdVtpkY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJLNFkZJi9z+Wc51MV9sWG KyZ0i3EcLl3135Rh1V/p2TenWEnnPCln+F99gMWOyX62xk4Du399RQ9XTQsXMmEy4ArfuSn16RK 3R1wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ok, as mentioned off-list I have an RFC version of getting rid of page
fault induced stalls in procfs when removing entry which plagues
networking devices among others.

There was a hackish very narrow AI solution to a part of this bug class
that was floated off-list. It used a second buffering mechanism on top
of seqfiles which was really nasty. Plus, it didn't fix the whole bug
class, it only eliminated a small portion. If we want to get rid of the
whole page fault issue we need a bigger hammer. So I tried to work
through that over the last couple of weeks. The series in a shape where
it's not totally insane to have someone else look at it. So here it is.

I understand it's big but I thought it's probably nicer to look at the
end result than just making a promise of what it might end up looking
like.

It's not super polished yet and I haven't gotten into sorting out all
the warts as there were some really gnarly bugs in there like the whole
readdir mess that repeated entries or terminated early. I think we could
go a lot further there if we wanted to but I think that blows this out
of proportion and at some point it becomes difficult to grasp the scope.
So I'd rather delay that until I have a sense of how acceptable this all
is.

remove_proc_entry() waits until every call into the entry has returned,
and most of those calls copy to or from userspace with the entry pinned.

A reader or writer can make a page fault in that copy take as long as
it wants, with userfaultfd or by punching holes into a memfd over and
over. And the callers of remove_proc_entry() like to hold locks while
they wait. addrconf holds RTNL when it removes /proc/net/dev_snmp6/<dev>
and xt_hashlimit holds a mutex that all network namespaces share.

Every network device with IPv6 gets a /proc/net/dev_snmp6/<dev> that
everyone can read, and addrconf_ifdown() removes it with RTNL held. So
any local user can keep RTNL for as long as their read stays stalled.
Until then no device can be registered, removed or renamed and no
network namespace can be created or torn down.

Without privileges a FUSE mount in a user namespace whose daemon never
answers is enough to stall the copy. Killing the reader ends it, but
until then whoever removes the file sits in D state.

xt_hashlimit removes the proc file of a table with hashlimit_mutex
held. Every rule insert in every network namespace takes that mutex and
so does network namespace cleanup. cleanup_net() runs on a single
workqueue with pernet_ops_rwsem held, so a stalled reader also stops
every later network namespace teardown and every module load that
registers pernet operations. xt_recent does the same with recent_mutex.

And it's not specific to networking. remove_proc_entry(), proc_remove()
and remove_proc_subtree() have over 200 callers and plenty of them hold
locks. A stalled reader of /proc/fs/ext4/<dev>/options holds up the
unmount of that filesystem with s_umount held, and every sync(2) with
it. The same goes for PCI hot-removal, for freeing IRQ descriptors,
which CPU bring-up waits on, and for unplugging a USB sound card.
syzbot has hit removal under locks before (cf. [1]), and the xt_recent
deadlock fixed in (1) below is another one.

Stalling the kernel in a copy to or from userspace is a well-known
exploitation primitive. It's why unprivileged userfaultfd can't do it
by default anymore since v5.11 (d0d4730ac2e4), and FUSE has been used
the same way.

kernfs doesn't have that problem. The code of a kernfs file only ever
runs with the node pinned and never touches userspace memory, kernfs
copies in and out itself. This moves procfs over to the same scheme.

sysfs has only held its active reference around ->show() and ->store()
since v2.6.23, the same release that made remove_proc_entry() wait for
the entry's callers. A copy to userspace couldn't be stalled for long
back then. userfaultfd only came in v4.3 and FUSE in user namespaces in
v4.18. configfs moved its copies out of its active reference in v5.3
and DRM copies ioctl arguments in and out around the driver's handler
the same way. debugfs still holds its reference across the copies,
ran into a deadlock with wifi drivers because of it and grew an API to
cancel operations instead (cf. [2]).

That touches just about every ->proc_read(), ->proc_write() and
->proc_ioctl() in the tree, so I've split it up into seven series. They
go out as replies to this mail:

(1) proc: fix a few old bugs in /proc handlers (38 patches)

    Bugs in the handlers and in procfs itself that are a lot older than
    the conversion and that reviewing it turned up. Most of them are for
    stable. They come first so they can go there on their own and the
    conversion doesn't have to bother with that crap.

(2) proc: let procfs own the data path (16 patches)

    The procfs side. procfs owns the seq_file of an entry, copies in
    writes, copies out reads and copies ioctl arguments in and out, and
    only calls into an entry with it pinned. proc_create_seq() and
    friends and the plain seq_file users are switched over here too.

(3) proc: convert the arch and platform entries (22 patches)
(4) proc: convert the driver entries (23 patches)
(5) proc: convert the fs, kernel and mm entries (27 patches)
(6) proc: convert the net entries and the kfifo samples (11 patches)

(7) proc: drop the __user methods (5 patches)

    Drops the old methods for every entry that can be removed and gives
    the new ones the names kernfs uses, ->proc_read(), ->proc_write()
    and ->proc_ioctl(). This needs all four conversion series.

The series should all indicate cleanly what dependencies they have so b4
should be able to pull it for review. But I could be wrong.

With all of it on a KASAN and lockdep kernel the removal selftests of
every part pass, the proc, pktgen and allocinfo selftests behave like
without it and the bugs from (1) that reproduce in a VM are gone. Every
patch builds on its own on x86_64 and i386, and with W=1 on the
architectures it touches.

[1]: https://lore.kernel.org/r/000000000000f24f4705b6988f3e@google.com
[2]: https://lore.kernel.org/r/20231109212251.213873-7-johannes@sipsolutions.net

-- 
Christian Brauner <brauner@kernel.org>


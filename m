Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1946606D3E7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DudqRbSQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMLcV0pvVz2xrC;
	Sun, 08 Nov 2026 03:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794067834;
	cv=none; b=ITZqvpqO7VdefdencOkNsPIoXP1OIyMzuCbZjJ20ZBaT8KEhPfUgYJ/xGuY1EDNyHW9RLXMQNuMkPcKuzyucXE1W7q6E6Zo57+q02x0PAfH79Ep91Uf/ClD4NeZueQlWNTZ+3QKjYwmsyfSFtkP7F+F/h216zuKytGnUszywidFS8+iI9En3WqlIkPetYTsnCMzCgjZBddLom/oz4nckfCqY0jEiJbdr67Z8EUDMtqh/9wyN5/8kiZYxjGWFZBUcosfVhrq0KiF41Znk4mIvr6kJaYjpitLzknoK7PjIqlU62bzkv1JF7TODP005fSFd6j/1kZOhRQB8/PFOmT79Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794067834; c=relaxed/relaxed;
	bh=yrl1fDgvB8SejpyA+O0u1vRjlm41/COeTHtKBCR1yZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YggKBpeTH5nU9rRYiKDd9lAXw+y17tPFWBQzD+Ib25L2B1xP8Laq/t796Lde+ONdnrWgzwYt2vrpErBUh+20C4xgpinYtrcfikBzPQr7RfqFnA/zfV83gyfEYGloGMWu/0zrW4nZS9iPb+QKZwHvjJ+7abLC6JUbzf/5oznpL+odfL1XG+gEmM213Ij2Pzucj3xf83LO/qiGJdm+y4lFHQouxNsK7dpehQRoBaDhF5rc6dAQYuYOmo++ZdO7vBylSqwstUGkFlHFOEye3m7CNQC2tWHl8mOImNOj/zjRwzeecnylIbtG0wgWQI09y3RKYdrYOYTNqogMDMI1vnlawA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DudqRbSQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DudqRbSQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMLcT32KKz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:10:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8275861877;
	Sat,  7 Nov 2026 16:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1758C1F0089F;
	Sat,  7 Nov 2026 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794067830;
	bh=yrl1fDgvB8SejpyA+O0u1vRjlm41/COeTHtKBCR1yZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=DudqRbSQXCpr6NhdcgkB28/OJ09fv/xb+ZGVAY2ZZcm0NtXYxKjH24XfLPv1YVH+1
	 N2Smc+eQQaJmUtmHSjIuIOHPbXtdHkwnaUWqwn18l1Zgme7MhVjd/tmwPXx2sHiZmJ
	 bVG7HcpDVP0TwBfdMqAH6zxIyHwUkaCeHOVhR2aYppt91bZLwCTiFYtodZA1aRzQhT
	 JFzXQc4CJvaSMHUeBSzyyst4sJaPobtuTL08pUib1PO2/6JKi1TR0Oc7vVJSOMiTRg
	 di9pOtOgBcjQKNqN/zgV0r2ojSo7IUXfYme+kVAZvSpJolvZJtmmOXjKLjiXPaiu1m
	 qPutBKIcKy2tg==
Date: Sat, 07 Nov 2026 08:10:28 -0800
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>,
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>,
 Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>,
 Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 Chuck Lever <cel@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND_v2_07/23=5D_proc=3A_let_pr?=
 =?US-ASCII?Q?ocfs_own_the_seq=5Ffile_of_seq=5Ffile_entries?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
Message-ID: <8A21EE2A-F392-40B7-9152-CBC440FDDA70@kernel.org>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On November 4, 2026 11:30:58 AM PST, Christian Brauner <brauner@kernel=2Eo=
rg> wrote:
> [=2E=2E=2E]
>+static int pde_init_seq_direct(struct proc_dir_entry *pde)
>+{
>+	struct seq_operations *ops;
>+
>+	if (!pde_is_seq_file(pde))
>+		return 0;
>+	ops =3D kmalloc(sizeof(*ops), GFP_KERNEL);

Please use the new style typed allocation calls for objects:

ops =3D kmalloc_obj(*ops);

(This happened to jump out at me, but please check the other patches for t=
his pattern=2E)

> 		dp->open =3D kzalloc(sizeof(*dp->open), GFP_KERNEL);

Same, etc=2E

--=20
Kees Cook


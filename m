Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DD606B1E4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF5N5Lcsz2xlw;
	Tue, 03 Nov 2026 01:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:237:300::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631080;
	cv=none; b=nt1dlUMekxXXTOeAOGCROueEtB5S+mCbeoUNIxd3pHC+Ua1cWkdcZGZhNirZCSCEhKcyIjutmrgz+QyZWDB0FBmbs6Xpse1rwF4sLU25AK2NuV0uCFJlrCXd6ZzRhROCxU+awx5YPJw9X95aT4B9A+ik/IgunVeiAnY08uCgtPhdfF86eKGuMredrLSJ4kVJ6X44OhMjrThnfzpkulZd7m1MnEr5fgeq4xiF+pgQt7F3F472kgbjAZbhvczFshROzjDE2XGTgMgm2KS4K9SZZRlRWm3V5DiSMspUEAQecUWAvindCZLPnsY+cQHjEjwKoMlpBefcaLWmhBsiVQkYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631080; c=relaxed/relaxed;
	bh=OMjVTvjZtZrTjrcI72ExCzD1i9afB7DwzHLxEXPZD7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiv74VWfZEvOqxpO/fOxrR4c3Yj9GB6e+JBNSGJCXCabZsqt94+xfQyz1g8zEOOB0KhX2EEct4Yp3BsOMGiosaSv11hU+2ZE/EruFyp9Ag3opQpRui4XAFlCL6BkjNmeNJaz1JEv80xG7nObqK0SeryW3R98EZnW7eW0KeDQKihjy6l7MeZNsJYc+LpCxGtmUeV1eeal+PmrdRVuiUHN8glndjPA4eKsl2Q/HjTFjcUHFW2CvfH1i8y2Mv8OWdiNKAxlVnRl6mnEqoNXUwRCXWXPOlDKnxbaJW/ZVafFZ0jLcvVJ6OjfMB8j6oGaYqvI8OebeixihqHGYMQfIKMVew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass (client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc; envelope-from=fw@strlen.de; receiver=lists.ozlabs.org) smtp.mailfrom=strlen.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=strlen.de (client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc; envelope-from=fw@strlen.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 602 seconds by postgrey-1.37 at boromir; Tue, 03 Nov 2026 01:51:19 AEDT
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF5M4BgSz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:51:19 +1100 (AEDT)
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B65DD60342; Mon, 02 Nov 2026 15:41:04 +0100 (CET)
Date: Mon, 2 Nov 2026 15:41:03 +0100
From: Florian Westphal <fw@strlen.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
	kexec@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org, linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 03/38] netfilter: xt_recent: don't remove the proc
 entries under a spinlock
Message-ID: <auig_zhd3L0HEis3@strlen.de>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-work-procfs-bugfixes-v1-3-59422ed3e465@kernel.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian Brauner <brauner@kernel.org> wrote:
> recent_proc_net_exit() removes the proc entries of all tables with
> recent_lock held. remove_proc_entry() waits until nobody calls into the
> entry anymore, and reading one of them takes recent_lock in
> recent_seq_start() while procfs has the entry pinned. So when a reader
> gets there while the network namespace goes away, the exit path sleeps
> with a spinlock held and bh disabled, waiting for a reader that spins
> on that very lock:

Yes, but note that this change is already part of a pending nf -> net
merge request.


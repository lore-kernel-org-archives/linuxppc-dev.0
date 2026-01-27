Return-Path: <linuxppc-dev+bounces-16329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72161D2FED9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 20:13:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0xRt5MYsz2yGM;
	Wed, 28 Jan 2026 07:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769544810;
	cv=none; b=ECtXrq+NNRyD3OpgOBe3S1rtWOhX6J9F2Cic/YFqLgIgsWQjnMoUMaYa0R8ptiQ5C2VjzG/pVhYQHvYS+nNoMsY5W3tiV6o7ihtlvpdiz0Q5qyXx6Dh5F+gX7GiMZqY1XFknEA8vLCeHdPNuLDYL1xbxxLaoHP/peOPI61pCKAxjEkVvx1AQ/+0v4t8LhTFEhaGIbIKl9kzgO1PXxCktacJYWjqTBdwkxxB8WP002UraE/bcyeGvr7Aj1PQIxMum4po4sKUuiFx4iKJanEUdIU9yJ7lD0q/EpplWtBKso9Pi2jreiVhWKJTWvjaYK6ibQfrC1cmojExPBxYvJWE7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769544810; c=relaxed/relaxed;
	bh=BThmTYQxvIJzQkA/L/WO0umKgcoH0NckbPSOFRkaDt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqYe/mutqBHPBirE2IcdYYKfBgN9YgAae1rboZIdw9MVzJT2eDw+/IugnLWb0haGwx7NqOhb7t3dAoEONYwa2f1mHoLeQoTtwMCYdkW1cSpWHBT6jDxx5M+l3J2TAIxZWbjCj8PprrplbbRmNeLSE74a+JpyQWsccJxRgjWZgYt41hyuRtEyUWil1Xru0LrgEDuidi3JMPIC5HtSyAFnhNCZn6QG9tGqwZFyBj0Nv/4c6ZuVWJtr3NYEAKD+2rivUemx+n7ZdXVmzAJxxufa7paKx5O1fMtBS5Dl7yimuVISzbkk5AjNv4leZbWEQIn1w1o90KjV5uBwR7zw6QvtzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=HEJ8AHlZ; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=HEJ8AHlZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0xRp6wl3z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 07:13:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BThmTYQxvIJzQkA/L/WO0umKgcoH0NckbPSOFRkaDt4=; b=HEJ8AHlZg14JJPbg8QtNWS1ji2
	tJT/2Fs1T5x5ADAyCAF83hSNvt9o3z0K3RSxk2gUB8Da5/tSbaBFKwqw22nB9KSBEdLXuDL7FqPew
	7Y+0P4xYkRhvZjXTFdCSvNynNniJgE6ZN0ESEh44Vc7Ehkj50lCswNvXEYERPQvdfeH75yQduHjQN
	Pq05K/lmA3+K8RokHDK11A0sXSW/FfXFcjSMTd9/8b2Gfp8Iz6ORbZwkKjtp/91tEjK8DcKs1Smzh
	pMHt05iiq6RxHZG8nxYrYmxa8r2p827g4+Rly5OrSWZkh9CWcaNv1tRLRrbeWiJeWu+s2oV5wvc/f
	Bx+2nTwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vkpSg-00000001D3Z-2Fqa;
	Tue, 27 Jan 2026 20:14:54 +0000
Date: Tue, 27 Jan 2026 20:14:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Samuel Wu <wusamuel@google.com>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260127201454.GQ3183987@ZenIV>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 27, 2026 at 10:39:04AM -0800, Linus Torvalds wrote:
> On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> > open/removal races") from the stable backports, as it was causing issues
> > on the pixel devices it got backported to.  So perhaps look there?
> 
> Hmm. That commit is obviously still upstream, do we understand why it
> caused problems in the backports?

This is all I've seen:

| It has been reported to cause test problems in Android devices.  As the
| other functionfs changes were not also backported at the same time,
| something is out of sync.  So just revert this one for now and it can
| come back in the future as a patch series if it is tested.

My apologies for not following up on that one; Greg, could you give some
references to those reports?


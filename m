Return-Path: <linuxppc-dev+bounces-26564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E91C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc1YQ55JGz2y2b;
	Sat, 05 Sep 2026 02:06:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788537994;
	cv=none; b=mJ8wimA939nk9uPHjNi2neygWrVF062HtNQGFEmWnQojGQT7bwWIhkhX0SlstdZElt54Dk+QHoXHRJC2IPO6dAm8EP/lhqIu2BHumi7YubyFevrPaPDMX/kLv4A2tOFmBgJALe5p2HYF9/IoMjBWax6GEtWQvj9VmZy/rWKhQ/qsXV2NPXi/ONBYtIx2g9brVMTsmY/HpbB78/SnI1GKGzHSi1kdiQ6lLIA4lY2ouKp49HFf5juLrNaFinKmfOCO79cSOhjWr2kQnvEnjxUuhf0S+QqWkofktWv0IkqwagyByZebjC4QI84+vVZO1xA5BGOkCxJxr10WPKdx6AtPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788537994; c=relaxed/relaxed;
	bh=89DU0GapqiOZlaA7jU9CQs5/T4ZZ4b0KeYVQAFryc+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOR1KD7e6k+NnvIdUhcKr49kDqRlticiz0wJ5epy4zm6YsEqf4bKyvSFN83rvwat8SbJ2FYpegBxjpX8p9HEyNNZ70zUud9m8/OvWAz8iX9FhhUVBSbMhspKd1zyBEKyR/HgyWuo8wXH0xOv0kxHo2sLQwswple6UIeOuglnQAZF1Pb/yp5nfvlVkPytSZDNc+dfpKJzHiqr7t3YSq2xQr9lYpdH+j0FAv6cGqMo47nk1cRAJgMMnXvgR5CggR4VeyxQHt+Ke4PY0x91ngb6PVKCAEFsqqqpRnKnjATv2T2XksrHu3XYJUPb2c2jhQuu9+mlnlHj4+dohzvtWD/wdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFVs81Nr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFVs81Nr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc1YP491sz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 02:06:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 016A460210;
	Fri,  4 Sep 2026 16:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B31E1F00A3D;
	Fri,  4 Sep 2026 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537990;
	bh=89DU0GapqiOZlaA7jU9CQs5/T4ZZ4b0KeYVQAFryc+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CFVs81Nrix1xWs3kup1P05Krc0JJYYhS/ViPHckidBWbZUUGJsinV0OpG0P2Yp0BM
	 Yi+nMeESljaXeDglpK+m7DNQxDrSYy8UGDgOQoERJShk9RAc41+SjMQlXp7YkTY/cs
	 KX7Zc2qg+zrln15rB1FL9dhfPpQNrATWQEC0mVvJPFKr8EUGnQG1Al5bkXiPq+CkAV
	 8ASReE6E/YXuMju48gmLyNRm35+cwsjDqveHmTZAEelBBwGoMRCiXvPw2ZAyXgeW7s
	 FNu/myp6GFkUNY3kus7xr2P0HhWcShI8J6dlb8+vBIMclZAmORFzAg8TXYBEMMFa6n
	 RwUUxSxh+CnkA==
Date: Fri, 4 Sep 2026 17:06:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, David Howells <dhowells@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Theodore Ts'o <tytso@mit.edu>, 
	Catalin Iacob <iacobcatalin@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Andrew Lunn <andrew@lunn.ch>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Andrei Vagin <avagin@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bhavik Sachdev <b.sachdev1904@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Wang Yan <wangyan01@kylinos.cn>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, 
	Malaya Kumar Rout <malayarout91@gmail.com>, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <aprr9xUwEmjA1N5T@gremlin>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>
 <20260904151054.GG6047@frogsfrogsfrogs>
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
In-Reply-To: <20260904151054.GG6047@frogsfrogsfrogs>

On Fri, Sep 04, 2026 at 08:10:54AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 04, 2026 at 12:43:09PM +0200, Christian Brauner wrote:
> > On Fri, 04 Sep 2026 01:29:19 -0700, Ethan Nelson-Moore wrote:
> > > bfs: remove the filesystem
> >
> > I agree.
>
> At the moment, I don't.  Nowhere in this thread does anyone mention what
> someone with a B(oot)FS filesystem image should do if they want to
> extract whatever's stored in the filesystem.  Are there userspace tools
> for that purpose (ala efs)?  Does "binwalk -e $bfs_image" suffice for
> that purpose?  Or is there solid evidence that there isn't even a single
> user (ala freevxfs) who strongly wants it to stay in?
>
> I'm all for getting rid of old cruft but there still needs to be a
> documented offramp for users.

Use an older/downstream version of linux? :)

It's like the museum piece arch stuff - people argue vigorously in favour of
nommu (which btw is a variety of linux that _doesn't implement forking_ :)))
gesticulating at talks given at conferences etc.

But then never quite answer the 'why not use an older version of linux' or 'why
not just maintain it downstraem for the 3 people who need it'.

Also worth consider what the Venn diagram overlap of bfs users and people
running even-vaguely-tip kernels/likely to ever upgrade is. Quite likely zero I
expect?

I get the desire not to lose people their data, but the code's not gone away
forever :)

>
> --D
>
> > ---
> >
> > Applied to the vfs-7.4.bfs branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.4.bfs branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-7.4.bfs
> >
> > [1/1] bfs: remove the filesystem
> >       https://git.kernel.org/vfs/vfs/c/e36781a626b2
> >
> >

--
Cheers, Lorenzo


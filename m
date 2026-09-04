Return-Path: <linuxppc-dev+bounces-26561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC8CC624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 15:11:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc0KN2dbXz2xpn;
	Sat, 05 Sep 2026 01:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788534664;
	cv=none; b=kzLNAGPaAjgtaXA4DjzMKjLm09iCt9wYASQREo5wdwnqrFHXrKZN28Whm3FAUAU5wEUm4jLDeGsN8jzf84oeTWpRar9FDuIqG7X93J7uzRB6coA4gOQdkgE632gHi34T5pDGEvd9BWPNDJeGl+YjZLCEGz/kIwncHqJ54Jaqk2VGtqvzFed24RdVxHeFXXQeVH/vkOIYAG4DMYhH2AAxmlhiIPe561c3yJthpPsL42jt/yKibn2SkztjvIWF8UpCdQK6UjJvD9oCcBsexxuBP85gsoduCkrz0sua2AT1TIOlmvwFWFXglIBxioij9MXRAR+oQYMOXxlpyxveCpkqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788534664; c=relaxed/relaxed;
	bh=41xaUrJ1lAeNQeQ/qi/93VPU9j/VGLCqogvprDRRNhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU+7Gx2tuMaAbDk7hxrYVyPcxwf+ar8G/hzlA0rHBC99TmxbtyPzyl8NVH7IyRNTE5TpkW194Duh1MNJicJOztE/on53h5GdU+0PsqCN0rfluedlOGeKofmpxJORs+XfbEtLMnbaE+KAu8thTWvq1oy6Pu4bxTGHUj0O5X1HS7xZDLTceIu2G0aeK/wjJr0tTXHgu3uHkDx1TbftMf2uld7US1dwLRWwWuft54jxQB8dIeBwAvZt/21B9FH+0i58QWwt0/jGxZHd+k8e4X7E5oIrEyBJfBfA2FFVZPX/L/kh+f6m9vV1L0Yx6FB3lCYE0QEsfNPLN0JBz7CRfmNGzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB3Gp389; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB3Gp389;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4hc0KL6w6fz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 01:11:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 54C676020A;
	Fri,  4 Sep 2026 15:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EAE621F00A3D;
	Fri,  4 Sep 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534655;
	bh=41xaUrJ1lAeNQeQ/qi/93VPU9j/VGLCqogvprDRRNhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VB3Gp389hUiJzqvsLNBiOxo9AiBTn02To+KR9uXQbCTwnr1MfN9K/mfYWPpkTQYoi
	 YkSwXqdiH4MVDRmvZayz5DTTmd7tsTIJhqEsiBQ3VlBGcQBtX7Q6V0d1qqBAGbutA4
	 YBaPGJLRz8WvCU8m9I5oOD/6mQhQWDsfTzAs+Re6PhaN8sHtYH9UTWU8n/vsjGRzma
	 YwTvxKJ6eQC0djlK9jHVUYb/cXNutoS9zDShgIfepZ+JjJGdx9OMIEewirFY6jcTaF
	 yD2lEjdL0GwoSgI4JISCTQdxtXsBn9k9OJn4pclMED29mV+rIlc390GxVcXiR5xkzZ
	 F3nGaY5o8zg9Q==
Date: Fri, 4 Sep 2026 08:10:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hisam Mehboob <hisamshar@gmail.com>,
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Catalin Iacob <iacobcatalin@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Andrei Vagin <avagin@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wang Yan <wangyan01@kylinos.cn>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <20260904151054.GG6047@frogsfrogsfrogs>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>
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
In-Reply-To: <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>

On Fri, Sep 04, 2026 at 12:43:09PM +0200, Christian Brauner wrote:
> On Fri, 04 Sep 2026 01:29:19 -0700, Ethan Nelson-Moore wrote:
> > bfs: remove the filesystem
> 
> I agree.

At the moment, I don't.  Nowhere in this thread does anyone mention what
someone with a B(oot)FS filesystem image should do if they want to
extract whatever's stored in the filesystem.  Are there userspace tools
for that purpose (ala efs)?  Does "binwalk -e $bfs_image" suffice for
that purpose?  Or is there solid evidence that there isn't even a single
user (ala freevxfs) who strongly wants it to stay in?

I'm all for getting rid of old cruft but there still needs to be a
documented offramp for users.

--D

> ---
> 
> Applied to the vfs-7.4.bfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.4.bfs branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.4.bfs
> 
> [1/1] bfs: remove the filesystem
>       https://git.kernel.org/vfs/vfs/c/e36781a626b2
> 
> 


Return-Path: <linuxppc-dev+bounces-26538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1543C79F83
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:15:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrRY2Rhxz2xlY;
	Fri, 04 Sep 2026 19:15:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788513353;
	cv=none; b=cnsE8GXLGNG/IUEQRHDNXCK1IY97DEa7U1Ms0/WWanIJNp5Xm+He86BWebuNUWtzIztNutfkunvmO/BVWqOcj5CE4binL6GCjdx+IwDaat7Uo7oN6EY4ZYl8Y5VF/usWZRu4gFr5lFlXZtmxIQpom9rQKOr7Ln51oSBFNFTmW0bYBtf8ITVL3rMOioPYhBSsP4DOnDF/T+6VIqBpkRIZa2TFPObaMTdJlqn+63URwei0Gb6khYQDT8+q1LMR1bXnSpRaQtNOBU1QxdX1SalO6JNx0ky14XZXPOgC9e4xkL/F2I1gw5mLOzqqtR2FhOi4qlMQr28UqCL95uQ15tm3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788513353; c=relaxed/relaxed;
	bh=0Kjz+wSEcdot/Kp+frqf0GhQv33OLZIVvwXtWAhVB5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaPcl+mLZEpr46m4D8YwxKM44ouSwh6Tbdon95hPKd5YB4i654MmaH3TEA88gzF6omt1ptKBq32IZn4yC8arEdKr2a6EAA0UoHYkCWEMYDjhrwipoFsBD6YtZdHSZ8moM+srrbWbbPnMscUWESsHUvbHd59Vpnb6EMm7m6nx0BXg/vc4ls4w2l6GaSGUHxwOLwyPtP9kW5K9HVSoe36qzMEZYCGxBDdbY+mio71mKZBVulczEYF0x8nADc9jrAYzKc2B0dgO2Ky5VXL7F4jax2izKTknzolUnpd5wcipw9tKLXusfHDVhEtN+uan1ut9HoDIHEUQvwyiaHr/PuL6Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VufFzf3C; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VufFzf3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrRX1tF5z2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:15:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 20E6D60211;
	Fri,  4 Sep 2026 09:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031B41F00A3D;
	Fri,  4 Sep 2026 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513348;
	bh=0Kjz+wSEcdot/Kp+frqf0GhQv33OLZIVvwXtWAhVB5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VufFzf3Cilbm8QtKx3NZr5yYaHyhMTKVokK/7JAundphZYwRJZyAo6texlJnLQJqv
	 0fvCDCCOIVb3jI6uaP0ILqKvLG9T78RTOyIAFsuMHsgnyPijzHoRFRRH6DQ2StiC/3
	 sH7vQ+ZLgzYJDgBDjOKSkfPwiqGFsosDZvbfmwZCP7Si+SvxBLGIojDr0IlwCbKulZ
	 f9zPR8PI9gm1tbspmiVQz4qHraB1WqCV60hXJT0rY4w4G/8lUxsiwseP80Cg38WaQz
	 P/s+D4hWHjAkILDLihL2QiXOz1ytOJPa+YYlmRwU+mUvvetZVXXljSRz0hn9gYQry6
	 sOBg5ihVyDPaA==
Date: Fri, 4 Sep 2026 10:15:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Theodore Ts'o <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <apqHhmRD5rAeLivO@gremlin>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
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
In-Reply-To: <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>

On Fri, Sep 04, 2026 at 09:51:10AM +0100, Tigran Aivazian wrote:
> Hi Ethan,
>
> On Fri, 4 Sept 2026 at 09:30, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> >
> > BFS (not to be confused with BeFS, the BeOS filesystem) is the
> > filesystem UnixWare uses for its boot partition. It has extremely
> > limited functionality, only supporting contiguous files and no
> > subdirectories. Even though the bfs driver is very small and is
> > unlikely to cause future maintenance problems, given that the only type
> > of data stored on such a partition is likely to be kernels and
> > bootloader settings, there is very little reason anyone would want to
> > access it from Linux. Other old Unix filesystems (efs, freevxfs) have
> > been removed recently, and bfs is highly unlikely to have any users, so
> > remove it as well. Retain the UAPI header to be safe.
> >
>
> You are right that probably no one would want to use BFS for storing
> the actual data today.
> But some things have didactical value, rather than mere pragmatic
> usage. It is the didactic
> value of MINIX (and its limitations wrt making use of the wonderful
> capabilities of i386) that
> has originally triggered the creation of Linux. But back to BFS: it is
> actually used in Steve Pate's
> book "Linux Filesystems" (2024, unfinished yet), which is a sequel to
> his excellent classic
> "UNIX Filesystems" (2003), as an illustration of a particularly simple
> filesystem implementation.

Oh wow! :) Nice to hear a new linux book is coming, as a fellow author [fighting
my way through the editing stage atm :)] that's good to hear.

(I also learned, the hard way, why people don't tend to write kernel books these
days - the modern kernel is too damn big! :)

>
> I remember when Linus accepted my patch with BFS on 28 October 1999
> into 2.3.25 his comment
> was: "this appears to be a particularly simple one".

:)) nice!

We shouldn't be afraid to remove stuff that is less maintained or that
causes maintenance overhead or other headaches (e.g. blocking things from
being developed), as I have often pointed out re: older architectures,
nommu etc.

But I'm not sure if any of that applies here or not, so really one for
VFS maintainers I think.

>
> Kind regards,
> Tigran

--
Cheers, Lorenzo


Return-Path: <linuxppc-dev+bounces-26558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C2C624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 11:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbvjg2gZ9z2y2b;
	Fri, 04 Sep 2026 21:43:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788522199;
	cv=none; b=RHEV95xuGQohq/pP0HPPAcHVlj1Li2pRzxH3/qIqW4KOYKtX0a9L0KvQ9I6+ffAALGP2CS17Q41L/drxEozxywJK7oD8fHPfzC665thhtRC500wrcdpeKodnux5NzKzwYSp9afDVcZP+efPMzveBB0G7mIniYoFIxuXGbuQnFV9i3CDONJ9W08YFiPq3RfhqMnNw3AjaLRHepvSZk3qQtcRXUOeBndvWjNiqBenGZqD1794CHdoM8gka25y70AW7sxJgDvilhnXI0zGy7WNDagdY4ufB6NJtiyR9QWzkMIxKlIorCaQJUt5Q7z/OrtwjB0I+fPJsUJdRZfPA3nInOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788522199; c=relaxed/relaxed;
	bh=GgWGA3tRFjwasRcdaTq8NFprGOZYrgriEgoqozAWbas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIRyS9hJ4McBoOmHQzLHtV48r0MCoFMYb06FK9J+BN22WB3YKEK8WzEXDqD0qMhaBjY9Rbhe53Hzidoo5ovbIFFFizKGDQzH4EjzlHu/Pozswtn5oW248gk+WtbeJkwjXzzOMYCBaHaL2ZnfiVT4ocC9PH+BK/heDEtOWxPM353+x4ojlVH3OKFJvgMPW7HyQB1eg56Jh5Enzkp/SHhSEJJGaals+59oVbp3W2IJnQ1KJJ4ZDHCSmtbLUQBSSqBr+i+4z9BgLS8uCA3mhfKHQRV5wMvDetyHfiT4yUXC098IWFb3v7hSUsATJ6FBF4QDYY2VS/KjadGSQxQoayMcig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efkQZLkq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efkQZLkq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbvjf3HLQz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 21:43:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 642056020A;
	Fri,  4 Sep 2026 11:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D921F00A3D;
	Fri,  4 Sep 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522196;
	bh=GgWGA3tRFjwasRcdaTq8NFprGOZYrgriEgoqozAWbas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efkQZLkqO4RDG32p3HDB8moibYfGgFtd8IwObc9ULUb9uy4aZBXv2JOkJtTz9C6li
	 KtIg1q+pF0wM/bOMpHN5Oh6qCpbIIaKAacLSD1Uq/WWlqNTeUbJsr2QW6E02nVhp//
	 uG4KoC9KTlJs8Ioscr39heJ6S+2Psr2BSfhULVwhom8MQbfXkgDA3BZ2tfDe7IabKh
	 BLoNMIVmNnCWY8HYpaL9rlMkrbwoBg0ErSuHzN6dluM8l37m5k1GTlhxmdNqCetxP8
	 zaZdI7hJn71deW1GZadBBQ7vdgi2JMIpmEQkTK6Wl9nMhlLrkPJcrkb6u1dX/r56sG
	 nGCPs3n+Zs5rg==
Date: Fri, 4 Sep 2026 12:43:04 +0100
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
Message-ID: <apqtweK_abU7IsUc@gremlin>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <apqXNCL4X_i6xy2Z@gremlin>
 <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>
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
In-Reply-To: <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>

On Fri, Sep 04, 2026 at 11:18:10AM +0100, Tigran Aivazian wrote:
> On Fri, 4 Sept 2026 at 11:05, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > Based on Jan's feedback at [0] that closes the loop (it is indeed a
> > maintenance headache):
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > [0]:https://lore.kernel.org/all/35dsgpk5dsh6bm4xoblrq6hdslfvtuibl5grzag37cye2hgepk@rkrtkjxdyk5g/
>
> Ok, I won't cry about it :)
>
> In fact, if I may, I would like to say that it is a pleasure to be in
> your (pl.) company once again. Looking at the list of people included
> here -- some familiar, some unfamiliar -- I remember the younger days.
> I have done my tiny share of contributing to the Linux kernel as best
> as I could, but as I now grow older I can no longer maintain BFS
> (older does not mean inactive, just active at other things), so if it
> does give maintenance headache, by all means -- remove it :)
>
> Acked-by: Tigran Aivazian <aivazian.tigran@gmail.com>
>
> PS. This reminds me of d'Artagnan's phrase from the Soviet version of
> "The Three Musketeers" -- "my consolation is that if I am to be
> killed, I will be killed by a true musketeer" :)

Well I think that is the classiest response I've ever seen on-list :) huge
respect for that!

--
Cheers, Lorenzo


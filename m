Return-Path: <linuxppc-dev+bounces-25067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8FAC531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:04:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dvZ321qz2xnp;
	Thu, 30 Jul 2026 16:04:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785391482;
	cv=none; b=hnVOm7r6s/+0WMM7w7UAlUDURjEDAWNR6APV9OpoXaTjrvobs4e2uS3LApsKzDIL7UnN4PGm7cK6W87PF8f262N5K7HTva3RzeHbuQdSduTq5IQ/auBWLdwDLDDtKLq1vPx/0nb2TlD6iEbfIbzoPKcvZOt94uGF7K4h63AUQ/qQZZF3RzcIzTuTK/1J9pH0WfW/3hUbZRQ7/Gcsa+jYVqwbBlTtAUfT1GxXU7b0NXG9ka+zpl6P+RliKTU+DjN56oB5ExBxq2KUguGWOLvwkEicXY1fFpfDvSTjE6i+BPWWDG7HjObfqsxuPJUcLslWKe57oZmBLVvR9/K+erus9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785391482; c=relaxed/relaxed;
	bh=RJOUU3f5HHUpp0IWlSSSvB9JbMcATWvPM7PlycBrVKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqiHapPUEZaU3S6O7hrc3aDquibQMZ0ZotZ0XYfGIhLcuifHdKS3N2b+EeGxSSlWZYosp3Qnw97BVRAbdVB4YzwDSOIiL+WEsd+WD7q1kq38l2kOGvFhkyYKhRIldI4rf0YJ70IsPepW5EVL05Sx9696AeMIEjYZqHQ0ZQaBac/modUexilc0PioghIYNadCACeX1addylFjKT17xLxkHKgp5DKJ7GS8M8R/H8aTIZ2Uk8rOQa055tX0XWqm0tArdh5Gl+Nw19NHvTsvLIPr3M7AImnwVoBhkLhhY4lgwYzqHsfMkEzJ8+EvcarGg4SbHwjT6Cta6kaiZrO4RXkndg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dvY1M3jz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:04:41 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 2546870992C0; Thu, 30 Jul 2026 08:04:38 +0200 (CEST)
Date: Thu, 30 Jul 2026 08:04:38 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
Message-ID: <amrpdv0g__ELifId@desktop>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
 <5c140099-4448-4091-979a-6f6fe7d92ce8@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c140099-4448-4091-979a-6f6fe7d92ce8@kernel.org>
Jabber-ID: linkmauve@linkmauve.fr

On Thu, Jul 30, 2026 at 07:51:40AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 29/07/2026 à 22:49, Link Mauve a écrit :
> > Two local variables were only set but never read on 32-bit PowerPC,
> > which causes an error during compilation.
> 
> Are those errors new ? This series and the one from yesterday on ppc64, I
> have the feeling that the code is not new. Has anything changed in the
> building flags or does this pops up with recent versions of GCC ? If it is
> the case it is worth saying it in the commit messages in order to clarify
> the reason for the fix.

I think they started happening when I enabled Rust support, but I’ve
been doing that for quite a while and I don’t know if the two are
linked, and when I disable CONFIG_RUST it’s still erroring without this
series.

I’m pretty sure someone has built the kernel on 32-bit PowerPC since
650b55b707fdfa764e9f2b81314d3eb4216fb962 or
930d6288a26787d2e7f633705434171a506db9c5, both commits introducing the
two variables which are then never used.

I couldn’t follow the maze of Makefile enough to determine where
-Werror=unused-but-set-variable is set, if this is specific to recent
versions of gcc or not, if this is enabled by a different CONFIG_
option, if this could be disabled already.  But I believe fixing this
issue is good anyway, the compiler is right that without __powerpc64__
these two variables are never used.

> 
> > 
> > This series first makes the 64-bit guards consistent by converting all
> > uses of CONFIG_PPC64 to use __powerpc64__ instead, and then guard the
> > two variables rc and suffix behind __powerpc64__ checks.
> > 
> > Link Mauve (2):
> >    powerpc/sstep: Consistently use one define to check arch bit width
> >    powerpc/sstep: Don’t define variables we won’t be using
> > 
> >   arch/powerpc/lib/sstep.c | 26 ++++++++++++++++----------
> >   1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > 
> > base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
> 

-- 
Link Mauve


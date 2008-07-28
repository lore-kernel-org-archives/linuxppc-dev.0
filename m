Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95CE5DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:06:44 +1000 (EST)
Date: Sun, 27 Jul 2008 20:04:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH] powerpc/ibmveth: fix multiple errors with
	dma_mapping_error conversion
Message-Id: <20080727200426.c290f14d.akpm@linux-foundation.org>
In-Reply-To: <Xine.LNX.4.64.0807281101310.19550@us.intercode.com.au>
References: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
	<20080727122414.cac4e336.akpm@linux-foundation.org>
	<20080728103253.5256e6c0.sfr@canb.auug.org.au>
	<Xine.LNX.4.64.0807281101310.19550@us.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jeff Garzik <jeff@garzik.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, FUJITA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 11:07:40 +1000 (EST) James Morris <jmorris@namei.org> wrote:

> On Mon, 28 Jul 2008, Stephen Rothwell wrote:
> 
> > I hope that we all can discuss procedures for API changes at the Kernel
> > Summit ...
> 
> "all" as in, whoever was invited (the only transparent aspect of was a 
> silly count of # of commits for the initial shortlist), or was on the 
> committee, or bought seats via sponsorship.
> 

Yeah.

We do all our work via email.  If there's some particular issue that we
feel cannot be resolved effectively via email then I'd really like to
know what that issue is, and why.

> - James (co- maintainer/author of several kernel subsystems over 8+ years 
> and apparently not invited, because ?)

- Andrew, who asked everyone two years ago whether we can justify
annual kernel summits, and who still awaits a convincing answer.


But for this particular problem I don't think there's much to be
discussed.  It should have been implemented as
s/dma_mapping_error/dma_mapping_error2/g with eventual removal of
dma_mapping_error().  But I failed to appreciate how many
dma_mapping_error()s there are and I failed to predict how many _new_
dma_mapping_error()s would turn up across the -rc phase.  So I suck,
what's new?


otoh, I don't reeeeeeealy worry too much about compile errors during
the merge window.  People get all hot under the collar and shout at
each other, but they're trivial to find (the compiler tells you!) and
almost always trivial to fix and they are almost always trivially
worked around via config if you hit one during a bisect.  Shrug, fix
them and move on.

It's the runtime errors which are far, far, far more of a problem for us.

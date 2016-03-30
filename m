Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZhWv3JQdzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 20:03:39 +1100 (AEDT)
Message-ID: <1459328613.23987.1.camel@ellerman.id.au>
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 20:03:33 +1100
In-Reply-To: <56FB6464.4010609@ozlabs.org>
References: <20160329175944.33a211cc@kryten> <56FA435A.5010804@ozlabs.org>
 <20160329210639.12136fd5@canb.auug.org.au> <56FB6464.4010609@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-30 at 13:30 +0800, Jeremy Kerr wrote:
> > > Do you know why mailman would be re-writing From: there? It's confusing
> > > patchwork, as multiple mails are now coming from that address.
> >
> > Yep, Anton posts from samba.org.  They publish a DMARC policy that
> > breaks mailing lists.
>
> (╯°□°)╯︵ ┻━━┻
>
> This also breaks git-am:
>
>   [jk@pudge linux]$ git am incoming.eml
>   Applying: perf jit: genelf makes assumptions about endian
>   [jk@pudge linux]$ git log --format='format:%an <%ae>' -1
>   Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Indeed.

Personally I only apply patches from patchwork, so if it could get the sender
right (which I think it needs to anyway), then I'd be OK.

> > The best thing we can do is to do the above rewrite of the From header.
>
> OK, it looks like we're stuck either way with DMARC. Could we make this
> a little more tolerable by stashing the original From: value in a new
> header? I know it's already in Reply-To, but that could also be set by
> arbitrary other (non-mailman-DMARC-rewrite) sources.

That'd be nice, or even just an X-did-DMARC-Rewrite: True.

> Alternatively, if there's some other way to tell that this a mail has
> been rewritten, we can know to use Reply-To in preference to From.

I think checking for mails from the list address should work in practice. And
it has the advantage that it works with the existing versions of mailman. If we
need a new mechanism then we have to wait to get patched mailman in the wild.

> Otherwise, I guess we could require that *all patch submitters* put
> their From: line in the content of their mails, as git send-email does
> when user != author. But that's a little less-than-optimal.

I had a quick look at git-send-email/git-format-patch and there doesn't seem to
be any way to force a From line. So I think that's a medium term issue that the
git folks will have to look at fixing. Maybe they've already noticed, I'm not
on the git list.

cheers

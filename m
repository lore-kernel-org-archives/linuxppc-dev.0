Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZdjt5sRPzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 17:57:06 +1100 (AEDT)
Date: Wed, 30 Mar 2016 17:57:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
Message-ID: <20160330175705.2c4c64e6@canb.auug.org.au>
In-Reply-To: <56FB6464.4010609@ozlabs.org>
References: <20160329175944.33a211cc@kryten> <56FA435A.5010804@ozlabs.org>
 <20160329210639.12136fd5@canb.auug.org.au>
 <56FB6464.4010609@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeremy,

On Wed, 30 Mar 2016 13:30:12 +0800 Jeremy Kerr <jk@ozlabs.org> wrote:
>
> >> Do you know why mailman would be re-writing From: there? It's confusing
> >> patchwork, as multiple mails are now coming from that address. =20
> >=20
> > Yep, Anton posts from samba.org.  They publish a DMARC policy that
> > breaks mailing lists. =20
>=20
> (=E2=95=AF=C2=B0=E2=96=A1=C2=B0)=E2=95=AF=EF=B8=B5 =E2=94=BB=E2=94=81=E2=
=94=81=E2=94=BB

Yes :-(

> This also breaks git-am:
>=20
>   [jk@pudge linux]$ git am incoming.eml
>   Applying: perf jit: genelf makes assumptions about endian
>   [jk@pudge linux]$ git log --format=3D'format:%an <%ae>' -1
>   Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Of course :-(

> > The best thing we can do is to do the above rewrite of the From header.=
 =20
>=20
> OK, it looks like we're stuck either way with DMARC. Could we make this
> a little more tolerable by stashing the original From: value in a new
> header? I know it's already in Reply-To, but that could also be set by
> arbitrary other (non-mailman-DMARC-rewrite) sources.
>=20
> Alternatively, if there's some other way to tell that this a mail has
> been rewritten, we can know to use Reply-To in preference to From.

Well, as Michael pointed out, the From header will have "via <list
name>" in it ... and also, the address part of the From header will be
the list address (unless people get even more creative with that
address).

> Otherwise, I guess we could require that *all patch submitters* put
> their From: line in the content of their mails, as git send-email does
> when user !=3D author. But that's a little less-than-optimal.

And hopeful :-)

--=20
Cheers,
Stephen Rothwell

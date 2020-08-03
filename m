Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF51C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 04:12:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A4E206F6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 04:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aXXvr3Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A4E206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKkwv5mBXzDqDd
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 14:11:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKkv01X66zDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 14:10:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=aXXvr3Nk; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKktz1RXGz9s1x;
 Mon,  3 Aug 2020 14:10:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1596427820;
 bh=YhI2SWaVaWNDumeeexvmrh3MFFyaXPRDfwzsb+cIWZI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aXXvr3NkybheAI34Dh7/+ZYft4PAnsJ9hBV3Er1bpQgKdYY+VNpQ85ZcrDUaptjPq
 dqw969Pb+4MTgV7/WPK6d4U6f98juepVfJnHumwGi9JqyIYJhHmnwq0Vo3va8voCZI
 4+40cqs39L3FDHHodiy8TS7DQkm1XXQVux0O+6N3vJBIRH+x7uv4LuWB8EFpOPSCum
 I9eV9NBXdHYBbmV4LImZ3YzqdLoKYliW6M+cLj9novevfxDEYU0M9yCit+xLS1SHJN
 cSTWPoOEUgfh2jXdEIq7rZrL5DRD/QIhK8G5Sq+okOev1VP8P7slN4XLTfOpgS72St
 /cpqkqfbGBgKw==
Date: Mon, 3 Aug 2020 14:10:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803141017.55dd6cc7@canb.auug.org.au>
In-Reply-To: <20200803034547.GA15501@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu> <20200803034547.GA15501@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Mon, 3 Aug 2020 05:45:47 +0200 Willy Tarreau <w@1wt.eu> wrote:
>
> On Sun, Aug 02, 2020 at 07:20:19PM +0200, Willy Tarreau wrote:
> > On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
> > >=20
> > > We are getting build failures in some PowerPC configs for Linus' tree.
> > > See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
> > >=20
> > > In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
> > >                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:1=
3,
> > >                  from /kisskb/src/include/linux/random.h:14,
> > >                  from /kisskb/src/include/linux/net.h:18,
> > >                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
> > > /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown typ=
e name 'next_tlbcam_idx'
> > >   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
> > >=20
> > > I assume this is caused by commit
> > >=20
> > >   1c9df907da83 ("random: fix circular include dependency on arm64 aft=
er addition of percpu.h")
> > >=20
> > > But I can't see how, sorry.
> >=20
> > So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, w=
hich
> > includes asm/mmu.h.
> >=20
> > I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
> > to be only used by the #define __my_cpu_offset but I don't know if anyt=
hing
> > will break further, especially if this __my_cpu_offset is used anywhere
> > without this paca definition.
>=20
> I tried this and it fixed 5.8 for me with your config above. I'm appending
> a patch that does just this. I didn't test other configs as I don't know
> which ones to test though. If it fixes the problem for you, maybe it can
> be picked by the PPC maintainers.

Our mails have crossed.  I just sent a more comprehensive patch.  I
think your patch would require a lot of build testing and even then may
fail for some CONFIG combination that we didn't test or added in the
future (or someone just made up).

--=20
Cheers,
Stephen Rothwell

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8njikACgkQAVBC80lX
0GxI0ggAgFHUOVKcLiTKMUDyziwTW2zq4UM2G950FogluMsm24YrfvOYeb3+u8H+
8lsdLMcfs/IDXHTIRLa5EXmCqOwF4kQrWq0N4UDCxT3xnOUxCqDEFk/3C8XhLa1V
dLn8YRzz6WRoaDYDdv9A+X69aBViuxfKZiuOJebL+qLvHtHjXDKtAgY+IntYaBy9
YalXdqYVzTkFmwncatLOXcnbi4UMgHpJhWCdQv1MvA8/iPU9aJSOW0MV2auHv0Qa
Ehwb55Mg0wBW9Nt8/A0UUSxZoacz83tS8uIwl5mebIfhkgq+xWLKOaz2LS5+UgMn
Z+NLkYZ6JAo6qkNFiYJ0E+zRhhfTuw==
=AS/6
-----END PGP SIGNATURE-----

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK--

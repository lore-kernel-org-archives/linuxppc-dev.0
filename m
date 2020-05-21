Return-Path: <SRS0=dcvz=7D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD60C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 04:53:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D2A2070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 04:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A/WHOQ4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D2A2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49SHLn29xgzDqSp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 14:53:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49SHJl4gKzzDqjT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 14:51:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=A/WHOQ4G; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49SHJg6pG4z9sRK;
 Thu, 21 May 2020 14:51:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1590036695;
 bh=Vvjbw6Q5rxtxSmTSpphFOU/PwAYYBFFB40vqqXq++1c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=A/WHOQ4Gh5Q6ACmyswDHgE6Cva2c1JIxTmXl24lnY5DMA/IDX8TAE4q+75ZHcD8Bp
 KyrX856ksyYk6lEeNko/P3s2ox5fx4QKtHRrbMqEMr63nlvn7jOGMMJsxaAbsVRHXR
 rXM4BdfdN4Z8QeDyiS3jWr9q0RFO6IX7RSYsQcyPXM5rbRpKcZ3nyB27AuRxiintBf
 7AGWw1YgDhKwQ/f6yMcnMkNVDabwBJAxmiHhRxX7307OsWrah5sSxCFwYukRGp/Hrf
 qvdODddKGdEfINH9SX2gRo8PthC2AYkzYkvTlOIXK4+exk6VML7oZBvch/aR2yn4+z
 JqyiZm/uQhvfQ==
Date: Thu, 21 May 2020 14:51:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: linux-next: manual merge of the rcu tree with the powerpc tree
Message-ID: <20200521145124.48ae408b@canb.auug.org.au>
In-Reply-To: <20200519172316.3b37cbae@canb.auug.org.au>
References: <20200519172316.3b37cbae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CQMfjLSTVZpJuWvNZ/.x1qE";
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/CQMfjLSTVZpJuWvNZ/.x1qE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 19 May 2020 17:23:16 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the rcu tree got a conflict in:
>=20
>   arch/powerpc/kernel/traps.c
>=20
> between commit:
>=20
>   116ac378bb3f ("powerpc/64s: machine check interrupt update NMI accounti=
ng")
>=20
> from the powerpc tree and commit:
>=20
>   187416eeb388 ("hardirq/nmi: Allow nested nmi_enter()")
>=20
> from the rcu tree.
>=20
> I fixed it up (I used the powerpc tree version for now) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

This is now a conflict between the powerpc commit and commit

  69ea03b56ed2 ("hardirq/nmi: Allow nested nmi_enter()")

from the tip tree.  I assume that the rcu and tip trees are sharing
some patches (but not commits) :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/CQMfjLSTVZpJuWvNZ/.x1qE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7GCMwACgkQAVBC80lX
0GxDgAgAjBhkbXjQw6c4H9zUJ/eMzz46ZhGjxATiSVcRL9djbp+Vc/KpQO1tkjif
bJ0tP19uatDYyD/6eEzPotCk+htDR/rVSJv1kEQlOILCXxWxR6EmccmJryRyIeAc
ARG/q+iSSPQrCzT8bPRK20ToK6FQEoX0wAE+c9eScTlI2OO6x6LbeYwKPphzLvZj
FjNiUZffxnOJrCc/ru7++ga/YIhNn8YVXKjdk9dNzlS0G5LH87wz4syI8f4T8Pks
CK0aH65PfcV+F923TsGDB3+r+GQD5zAZDxhsY2T1moDbVloNx9Cab3EHj1/djDQ6
Y/EBDv6+GEF5EV/D49ExqoET5sa0XQ==
=wTU9
-----END PGP SIGNATURE-----

--Sig_/CQMfjLSTVZpJuWvNZ/.x1qE--

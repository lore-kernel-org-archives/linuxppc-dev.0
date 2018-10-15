Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB7FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:54:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB10720866
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hGOOFobd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB10720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YwKX2Dg4zF3Sp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 10:54:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hGOOFobd";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YwGw74H6zF37k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 10:52:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="hGOOFobd"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YwGw5Lfjz9s8F;
 Tue, 16 Oct 2018 10:52:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539647560;
 bh=btU8Uy9R7DaclMFysZ2Nrk6Rk1bPqxI8mS1r5SJHdHM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hGOOFobd/To9b8j8ki07ZLVhA/RKdzbH1nPay/Itzs5F+trOYxhUvw108bCiH74dc
 /rkDdwMa+oxvX3Ldu2b+h4a4xw5i3BY+LIVAXUJx6+bHA/1BcmxD8hr1NyCEceex7h
 oQP6SKuBTRGPoi94AGKNMq0NtHj/jJ/gVyQfdxUssIhHbHEiV44GO6lIhpehFsmyNp
 AbqfWftFKC6IIiE9b0D+pO+UWs3CspV9movhlnpVT2+5Mxnl5PX07QaJPT7XM7O6jD
 p/GOyp4tT79d+EL6bbO0P64+cdKgLQKRU0h74DDZjGgg2Vyik6ceRO8+pVY3KxD/Gg
 mBM+nNjCRG43Q==
Date: Tue, 16 Oct 2018 10:52:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: qemu boot failures with today's linux-next
Message-ID: <20181016105240.70369b98@canb.auug.org.au>
In-Reply-To: <87murfz8dl.fsf@concordia.ellerman.id.au>
References: <20181015191859.2f600de5@canb.auug.org.au>
 <87murfz8dl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ofMVVG.UGOBjDEohDHL+3SX"; protocol="application/pgp-signature"
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/ofMVVG.UGOBjDEohDHL+3SX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 15 Oct 2018 23:45:10 +1100 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> > Preparing to boot Linux version 4.19.0-rc7 (sfr@ash) (gcc version 8.2.0=
 (Debian 8.2.0-4)) #2 SMP Mon Oct 15 18:53:28 AEDT 2018 =20
>                                   ^^^^^^^^^^
>                                   I assume that's wrong, this is actually=
 linux-next you're booting?

Yes, it was just before -rc8 came out and I suppress the extra version
information to save rebuilding things that depend on the version.

> > Booting Linux via __start() @ 0x0000000000400000 ...
>=20
> If you git Ctrl-a-c you should get the qemu prompt. Then you can run
> 'info registers' to print the regs and maybe see where it's stuck.
>=20
> And/or build with EARLY_DEBUG_LPAR to get early console output.

That gave one more line:

[    0.000000] printk: bootconsole [udbg0] enabled

--=20
Cheers,
Stephen Rothwell

--Sig_/ofMVVG.UGOBjDEohDHL+3SX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFKEgACgkQAVBC80lX
0GwexAf+MFS71cjMU/23VwEAs7GbNie6yHMgHEebYSJhw86kMKxjg9+Dg6Lqr8Ui
7xsPfqKvAhX6NG9VFIL+BHZMZnR8qc3k12vcQ+Pgp37UlxfvV2z36TMVnnjn4vm9
LXAtLM2SNwLcEDUTwvgx8LFZo2pQ4T5DbdOeJJKZMHJ/z0b4lTzOmlXMN+sJ4Y7x
eIrjas6om+58MJBII554klUD2TBm/wqQE602j8ho+z2IdZqYy19WdX5Ea7n+O689
U43s6uWLUlmD4LY3+XW6IW8z0okJMJuwy2BL5EoLDgdqal0iW17K1d/hKkskCZ18
2ugto8inlzslS0vay9mBb35cE2pxnQ==
=UqkH
-----END PGP SIGNATURE-----

--Sig_/ofMVVG.UGOBjDEohDHL+3SX--

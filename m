Return-Path: <SRS0=q90n=DN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB243C4363D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 13:09:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BE320760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 13:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z3LhaWQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BE320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5Hqz12KDzDqDJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 00:09:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5HlK0y1rzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2020 00:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=Z3LhaWQ6; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4C5HlG0kH8z9sTK;
 Wed,  7 Oct 2020 00:05:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1601989546;
 bh=q9mpa/0KffrcwWOYPGlh8L15Eanc/pISr+9iZYcDjTA=;
 h=Date:From:To:Cc:Subject:From;
 b=Z3LhaWQ63AkrZnv4Ays2nvFojIu78WkcEqwEcpcfR2TpahT2qxQhpUeye3fY6EV/W
 osa/GG+0YVOV7nTv71lQZslfZSiQj6Ptm5zkmYzVXW0G8D0fU32eGtOhJXQCJ8x4cC
 iW6wsPBN1sQPBlCtshTpUXjOs3jl0FAMqObGTLztYreYUUDHt0ApWTOKAxDcUeFgai
 b/piRFkgtm508Jj4P+V+R6DUoyMr9hLRvMdJyO354YFVzzULJlmvGf37Vn68q5Vt1y
 HvlVXnrPEHLjJ61+L03NVCKirVfH77NscHYP02QJK4C7C2iOIXsoef37YGJregrNXD
 rfWJPGT2vmbmA==
Date: Wed, 7 Oct 2020 00:05:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: Fixes tag needs some work in the powerpc tree
Message-ID: <20201007000544.48aabc91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F60SFxaoty6HOU9ZG//eX4x";
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
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/F60SFxaoty6HOU9ZG//eX4x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3b6c3adbb2fa ("powerpc/perf: Exclude pmc5/6 from the irrelevant PMU group=
 constraints")

Fixes tag

  Fixes: 7ffd948 ("powerpc/perf: factor out power8 pmu functions")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

Since Michael doesn't generally rebase his tree, this is more to be
remebered for next time.

--=20
Cheers,
Stephen Rothwell

--Sig_/F60SFxaoty6HOU9ZG//eX4x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl98a6gACgkQAVBC80lX
0GyhGgf/dKuWO59GS1sTLc4QQFWvP5GchwtYC0M3p6TOGGoofD6TtCvxmxR4DPG8
DcOvgvWF5hMq4LOE0Ts2fUpGpps4HdYewvgi4SiCBr7VWYZHWNEVhSO/VQZ66gn5
vEMVEozGw2JOwtSHvk/oNmT6sLeqpbYLzsQtdG32I5Oe+gh/odT6Eaz23T4NGW7J
r/TINbteFZezngchveOIGyN0lb4cOuHMbu3LClivARydqzHFhftgEnh5JHhOWSAY
ORrEHC5XkGPSv+OOTtfsWHYI6y4bjt1KkQ7vJ4IVbjxuYmQJcE7sNYy9Ku5/9kA3
/aNNq1R8B5To65aFGwfPHxroB/uYoA==
=oBxs
-----END PGP SIGNATURE-----

--Sig_/F60SFxaoty6HOU9ZG//eX4x--

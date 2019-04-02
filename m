Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC11C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 05:16:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6A52075E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 05:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="c3GIf+NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6A52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YHVf5ry4zDq69
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YHSZ6ryRzDq69
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 16:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="c3GIf+NZ"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44YHSZ5ZQ3z8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 16:14:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44YHSZ55BJz9sTS; Tue,  2 Apr 2019 16:14:22 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="c3GIf+NZ"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44YHSY5yWHz9sTQ;
 Tue,  2 Apr 2019 16:14:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X2u9oqRsEaAuQVXF2Wpq4Ocm5o+1E/B+V/Q2GGD21eo=; b=c3GIf+NZb/k/NQoA+eoUba3kb
 DXsmA8M4ZlEPE92aZR4ZLBFbkyP+uYjTmDgQHpKTbTRNo9U+4yqVP8SPmdxLXzZScKRB1YCIPlXeY
 qjLqIrB34As3EQFTszRgj+cXCfjbAEPvD7nmsEWQ6qFj0hToepE80SY+U6UFjuWFA+F/M=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hBBkQ-0005rr-Tv; Tue, 02 Apr 2019 05:14:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 59221440082; Tue,  2 Apr 2019 06:14:07 +0100 (BST)
Date: Tue, 2 Apr 2019 12:14:07 +0700
From: Mark Brown <broonie@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190402051407.GX2059@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
 <20190326131550.GB10898@sirena.org.uk>
 <87pnqdndmk.fsf@concordia.ellerman.id.au>
 <20190327115745.GA11404@sirena.org.uk>
 <87tvfiou8f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xd9y+pRso0hzCdjI"
Content-Disposition: inline
In-Reply-To: <87tvfiou8f.fsf@concordia.ellerman.id.au>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Liam Girdwood <lgirdwood@gmail.com>, Annaliese McDermond <nh6z@nh6z.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, Linux Next Mailing List <linux-next@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--xd9y+pRso0hzCdjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:11:44PM +1100, Michael Ellerman wrote:

> Anyway I think what you've done in next, make the code depend on
> COMMON_CLOCK, is the best option. If anyone cares about that driver on
> powerpc platforms that don't support COMMON_CLOCK they should speak up.

It's probably fine for now for this one driver but it's going to cause
issues going forwards since we're trying to make the framework's clock
handling more standard. =20

--xd9y+pRso0hzCdjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi754ACgkQJNaLcl1U
h9BMxQf/VrR/8FAWEVz+p5IAVWhEp/5r8gGBQzY33Bg6n8m4Wx0mFHVfDDxORd/L
SYSWqWbDGTk1AwbZ59dzTXaGEhh/9YX9/g5v6INunPhClb7NMBIvddfzvFv8pDTd
nI6DbaUyOnQzFtXTMF+ClhtKHxRBVbT6MwFKFOLcoPRjkhU9ebaiaVmBrzOoaq6N
dqDF7ukc0T15k/qvZ38kKczZA6m4DsGhVoSvpXxe5MucSHe7wphRFwyaJ8+S2AFR
AYvOQJNcYPi4pJYpcQ8i6cX4lJecezofZkVbj+b8WBCjndlieq5CZtB76qLevleN
WB8m8oAwM1GH+wdKRlWDmJWIOgRb3A==
=JFD3
-----END PGP SIGNATURE-----

--xd9y+pRso0hzCdjI--

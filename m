Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9FC33C9E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A171D2187F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OfpfFDbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A171D2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xwk01VCCzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jan 2020 03:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=sirena.org.uk
 (client-ip=172.104.155.198; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.a=rsa-sha256 header.s=20170815-heliosphere header.b=OfpfFDbw; 
 dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xwYq2TlvzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2020 03:16:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TnevzhVUZF4pyGCopDfMXcwhuhw/gLXqKk9L1QZKo8Y=; b=OfpfFDbwC+s7nxwz+wOkEdDGR
 pRZxN38c9nl2FWne4V8pximq6dGeG1L3rFOGWY3bz8QR3EpC7b55OK/qApDpSmeRwglL5ACd/Xjxp
 DY1Qz6Dbr5/ywscSBhqCrLy7KHZbvbEwBeAoNNiAhQvhUWNXTjzQORNayiNpx+u7N3aWc=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1irODk-0000DR-LB; Tue, 14 Jan 2020 15:35:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 48FC8D04DF5; Tue, 14 Jan 2020 15:35:08 +0000 (GMT)
Date: Tue, 14 Jan 2020 15:35:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 2/2] spi: fsl: simplify error path in of_fsl_spi_probe()
Message-ID: <20200114153508.GY3897@sirena.org.uk>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
 <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Content-Disposition: inline
In-Reply-To: <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
X-Cookie: Programming is an unnatural act.
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
Cc: devicetree@vger.kernel.org, kbuild test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:17:16PM +0000, Christophe Leroy wrote:
> No need to 'goto err;' for just doing a return.
> return directly from where the error happens.

This doesn't apply against current code, please check and resend.

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d36sACgkQJNaLcl1U
h9C3zQf/cMvkTc+QF3yMKYXxlmxQDKATcaQNF7uNysSG2s4+eOCqDd8drWV92HRz
AM7/spEm4cUKbeKJNtl5fXAnxI89PdE/e0bDH316EkA5L7NOJAI2dGjHDVJcgKMu
azrTo4dbu1+bt2JXOtHrTO9nIU8IRbQL9QcuLG/52cqD0wB3xWb4LE6ToQftfMoC
+96ALK3iJyYK8dhJI4Ip+oXBQGE2Fu2YU/C1lTvHnsrgqwnolt2u9z+HEXGu8rkE
DGmxnns+uSmLrCbSETb5ooxW3GVnis5IlROQKGBXZ+LDdTA41owEQLdqXIaeaIDu
Fiz2D//oT5xGwJgH7rM8LpEcSnodNA==
=EOzq
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--

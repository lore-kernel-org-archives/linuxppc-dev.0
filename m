Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC65C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3B82087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FYX93jVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TnFS2fMmzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 23:22:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TnC55JBDzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:20:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="FYX93jVC"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44TnC43cH4z8wRT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:20:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44TnC439gkz9sSV; Wed, 27 Mar 2019 23:20:32 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="FYX93jVC"; dkim-atps=neutral
X-Greylist: delayed 1352 seconds by postgrey-1.36 at bilbo;
 Wed, 27 Mar 2019 23:20:31 AEDT
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44TnC336jRz9sRx
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Mar 2019 23:20:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9d69b/QXfoYGWqfguLUdUfQSZItwCRrq/XtCINmWXYA=; b=FYX93jVCfRd7RO4wRhrB6O2YT
 pRhSmq6t+a3H90iCB0S9mT65yjY/hBj7rgiX4dfWvC0iUtvjp/WAj+IrnND2mzKlllPyMMkE9DVUU
 3dYiK/mTbaOb5Lz0c80P4CbXXix5Gxa4ZJuW6isc7NEHCoNTxmCcxbkRLJjr/vmQNgAk4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1h97Bi-0006TP-Bq; Wed, 27 Mar 2019 11:57:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 9F93511288FA; Wed, 27 Mar 2019 11:57:45 +0000 (GMT)
Date: Wed, 27 Mar 2019 11:57:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190327115745.GA11404@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
 <20190326131550.GB10898@sirena.org.uk>
 <87pnqdndmk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <87pnqdndmk.fsf@concordia.ellerman.id.au>
X-Cookie: May be too intense for some viewers.
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


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 03:29:55PM +1100, Michael Ellerman wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Hrm, seems PowerPC is still not using the common clock API - is there
> > any plan for that?  There are some ASoC PowerPC uses so it's going to be
> > a bit of an issue as we expand our use of the clock API.

> I don't know anything about the common clock API. What would it involve
> for powerpc to use it?

It's what's in drivers/clk - you'd have to provide clock drivers for all
the clocks that are current supported by arch-specific code, make sure
that those drivers can be instantiated and then remove the custom
implementation of the clock API in arch/powerpc in favour of those.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlybZTgACgkQJNaLcl1U
h9B1Swf+PbhuOweQKwnnpdgGWrrDdszCdLjzP1NdPdjWVhB1B+Y8gm8uA2CbgSCQ
FHCL9GmY1si64Jg2+W+uD7o+rdg3neUXfZ3rmQ60mdvdmg8O+iz6ngwn2iJIbGy2
5zuQoky3maZLgElEQMKWlZ8A3nHQpk6BkWra83M7tZJJnU5SOQ69vE2oKK6sGfTf
Xu7R13qHpVeRNQU2baIRdbkhgQFl01wiRswA8JbJSAQmeMX3XcjwrDakT10USHNy
PnNPllnXLAE9brC8AeYr9vNQj7vTL5fjn94Gz9P0yX2dWbnVSy2Yc2QASwiKB4P+
2qblx6/w3O4uBa8dTNx45qHwObNlHw==
=kXyA
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

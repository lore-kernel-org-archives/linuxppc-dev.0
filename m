Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72158C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 16:23:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68532085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="acsDHO/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68532085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qFG66Gl7zF3DS
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 03:23:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="acsDHO/i";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="acsDHO/i"; dkim-atps=neutral
X-Greylist: delayed 1991 seconds by postgrey-1.36 at bilbo;
 Wed, 07 Nov 2018 03:20:27 AEDT
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qFBz6HN8zF3Cs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 03:20:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Gzg/Mh0FJV9zuoQQNE0vpXPiiaXO+vW2e4XFXcasVk=; b=acsDHO/iSrWrKPtpveAOwCd30
 UFvA+DkTCECbvm4eB9w5piZM477NH7UK7RR/2kUdUmvfGC2gdfiZES7Tm3xfS3GeYqhEx+B9NZlSz
 K03ayXvkgywEvDH9eI2EERWy+umviKurxqe9U8WJLPGvWZRfBuh+bOCNTf3rEXEQoLNP8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gK3ZE-0002fp-CM; Tue, 06 Nov 2018 15:47:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id DA670112266B; Tue,  6 Nov 2018 15:46:59 +0000 (GMT)
Date: Tue, 6 Nov 2018 15:46:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
Message-ID: <20181106154659.GA31950@sirena.org.uk>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
 <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
X-Cookie: This sentence no verb.
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
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 08:56:39AM -0600, Pierre-Louis Bossart wrote:

> > However, looking at what else can enable SND_HDA, I think it should be

> >      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

> This codec can only be used by the Skylake driver (and the upcoming SOF
> one). For Tegra this module will never be used unless they follow the same
> path of enabling ASoC to deal with the HDaudio codecs instead of the legacy.

> Likewise HDAC_HDMI will only work on Intel platforms for now.

_ALL_CODECS is a build coverage option, not a useful configuration
option.  We should be building things in as many different
configurations as possible so that it's easier for people to get build
coverage when making subsystem wide changes.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvht3EACgkQJNaLcl1U
h9Deagf+OnHg8fBz8mKu9ehkKNp8xTUnAUdpPtoS0edsuI0QuH1I5WbIs6F3Ro58
cxf6scOiMI7R0/qne0h0ReQbOudbh0mT0aCBL1UP77FGvWhkgpJF8CkJP5Hwl+MB
eFtQe4CE0IfCXtzbfhg+RZ22OkUmJ4Rgdue5yqS7fPHswqQb/7zMGXZpKYGHuJx5
T1Dhj5dnKqI7pS8lThDzcA/ZtkBbST4aN+Zv1RvI9ew6pVMrYWq30QSohmx2+qTs
A9ESsst56DEvX8RSIZcsqMNejmuXFIQ4L7dqyIjS/9FjLoG1fp5SUkSOd4p6NHoo
BBLuGM/ddEXdoSs7PJGNuK+CihZHtA==
=wMGV
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

Return-Path: <SRS0=Y17X=YK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3BCA9EC8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 23:58:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AF121D7A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 23:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WqZCRkRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AF121D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46vR2g2S7dzDqn1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 10:58:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46vR0W1xyvzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 10:56:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="WqZCRkRh"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46vR0V3b79z9sPV;
 Fri, 18 Oct 2019 10:56:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1571356618;
 bh=K13U+AUFHnw6L6dQYDvLcinbUAJeMsLlIuOy4kBBer4=;
 h=Date:From:To:Cc:Subject:From;
 b=WqZCRkRhp4/4inRmp5XtNf0tPg2jyec1xXylhSZRn9Wsne5SxbSgl/Nb4LXBx0JaH
 Z+Zh6TF+8FF8t9VRCqeCFWobHD3WbNq+zyfZkGJfJKlBI577JsOJKoY9Mp3UPQ6Od/
 B3p60GrUGlgINtu3mkun9L5CvytijQQ4/QZ/vUgJ5UBwZ/GfyJMk8A8ywouB2Pk3uo
 wxMggGCi+CPQe6NXYbdTU1SioRl+LzD5oGuQ35IC0lXU8UOgIy/4pXe6B9kHtNse73
 rYs2vyNuLcm0w5mufm3n6PY4d8gkka1KBl/SU2H9jpohSGcIurx2jXIt46ioY2urc8
 rcfH+UT2sX38Q==
Date: Fri, 18 Oct 2019 10:56:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20191018105657.4584ec67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RzygGg_XqUDEQwGIY_nGvDE";
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
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/RzygGg_XqUDEQwGIY_nGvDE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

WARNING: 2 bad relocations
c000000001998a48 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
c000000001998a50 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end

Introduced by commit

  8580ac9404f6 ("bpf: Process in-kernel BTF")

--=20
Cheers,
Stephen Rothwell

--Sig_/RzygGg_XqUDEQwGIY_nGvDE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2o/8kACgkQAVBC80lX
0Gwzvwf/eU6rk1Dlj9jbIO6m14+31QNvZjmfiYayLy62FobBqj7lD6s86RJ5XdrM
kOTNRDsf/bC5mVwZKVS3daTojZX3xXl0RHe1JCV5fzagL1Mxfmlw613dyRqGBSXp
Vz7ToIV63qXfPmqPxf19LbQhwtDOFprKi1fPV+TyKJRyp/DFiNI2b+Lm+KkBt9R6
VTFai3eBNCWjJCnZmYfQ6w/B0yX1Hkn/DQ1I+OBm4lYOjEjLhf7NCliEAYSEOiM0
9JiHhQ2iOcHhRm++ykqMvPSGTHuC7+mxglYfrFI0SsjrWrowIo9Wy8bc44V2LKnL
vKxuVTQNsm8SW1FS9fRFbt9xs4dYJg==
=Ajn9
-----END PGP SIGNATURE-----

--Sig_/RzygGg_XqUDEQwGIY_nGvDE--

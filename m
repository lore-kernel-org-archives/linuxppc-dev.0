Return-Path: <SRS0=uvk8=DP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E42EC433E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2020 21:00:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9908B22227
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2020 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E5jxrI87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9908B22227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C6k9q604pzDqHV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 08:00:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6k7Z48rwzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2020 07:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=E5jxrI87; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4C6k7Y3zKsz9sSC;
 Fri,  9 Oct 2020 07:58:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1602190698;
 bh=9c1Til4Y3UBbGWRrIquuN5DFOYAZEZAYupyZq9Fi8gM=;
 h=Date:From:To:Cc:Subject:From;
 b=E5jxrI87KzDCdl/PkOEPlDk4jDzArGl+ZINhFsuHiQwuJE27/bb7MPSjotXbgGrtM
 B8wtOPr5tsXmZaNJDxZ0+ym/i1k0r7cUsKf1cGyREgjAY3ibY8R8ye8J3SJ6W+jizY
 pYMtjjjVhORPd4YDgI69oqYQTMjqCZqOskTOLFpblzvSF+1A8M/7Ih6kPT3jNvRVVU
 hhuJG1UYna9IEUGg6Qof7rPS2Gyam3oyoVIXfF2KMSoWoxX0mv179sfGsOcz+CHJY7
 8el7f2QtJUFm0DkF1LBjgPhBmFj7ikWX5VOqLieZqRlP3mkA2Kykdeci7WOzq0rUK3
 uEyXmRc35YyrQ==
Date: Fri, 9 Oct 2020 07:58:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: Fixes tag needs some work in the powerpc tree
Message-ID: <20201009075816.0cb5a86f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//dl+c07CTYJmvMsmyJW1Iqc";
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
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_//dl+c07CTYJmvMsmyJW1Iqc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a2d0230b91f7 ("cpufreq: powernv: Fix frame-size-overflow in powernv_cpufr=
eq_reboot_notifier")

Fixes tag

  Fixes: cf30af76 ("cpufreq: powernv: Set the cpus to nominal frequency dur=
ing reboot/kexec")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_//dl+c07CTYJmvMsmyJW1Iqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9/fWgACgkQAVBC80lX
0Gxr0gf8DYBDjl0ngETwLLLd7UDYnOunr5gO7MKaHqpeUtqlvXTRCfJNBerWqCNL
qTh8ni4Ud9JclJiAy1Mjxb3ONdmlzccgWYr7kXELlElWvcxrNhRknEuOMQpIhx7n
zmR/lsy+yRcu+oDBWUw+CK/tuRs5iN9CTdBmThbkPx8EL++Ee4NpgrThkNHPUbqS
mNl88leOb13ENKxcyHm1c0a5TopoHlRQgBj/xnXDnFJDuLmHki1SOJfApzvqvNHv
dRoZ0K51dLeT5b+pd+e0SD4miMjMEP7GWHGE1aBVtkKPsMb9mF9M8TOxRQnHDJlu
tnWDes8v/IKZPtA2jhP7Zw2KKlG/9A==
=9V2B
-----END PGP SIGNATURE-----

--Sig_//dl+c07CTYJmvMsmyJW1Iqc--

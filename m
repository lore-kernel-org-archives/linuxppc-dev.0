Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D62B91400AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 05:20:56 +1100 (EST)
Date: Mon, 31 Mar 2014 19:20:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140331182038.GB2269@sirena.org.uk>
References: <1396265962-19343-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pI6hLdwVzam1XFuA"
In-Reply-To: <1396265962-19343-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix buggy configurations in trigger()
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pI6hLdwVzam1XFuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 07:39:22PM +0800, Nicolin Chen wrote:
> The current trigger() has two crucial problems:
> 1) The DMA request enabling operations (FSL_SAI_CSR_FRDE) for Tx and Rx are
>    now totally exclusive: It would fail to run simultaneous Tx-Rx cases.
> 2) The TERE disabling operation depends on an incorrect condition -- active
>    reference count that only gets increased in snd_pcm_open() and decreased
>    in snd_pcm_close(): The TERE would never get cleared.

Can you please check that this against my asoc-v3.15-4 tag - it doesn't
seem to apply there?

--pI6hLdwVzam1XFuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTObHzAAoJELSic+t+oim9jC8P/1D0ToGXczPF/Cd/uG/SghaO
KFNuNCBog1/3FOc1Zqkwh2qDtg131MNxdehZuJcCFIVEE04dIpoCTU1QaUCGyWMH
56YydIpokLPC1DrrVgEC41t9Bbhgu5BtnLh13bXD6jDXswAgaMxf20jKs5vZlvS9
wNQ/C4RqmXDNuSi7qUSI0J1sYOxVT/b7mW4SKt/v1Kn5hCx7Mw7MioRys77OYYHf
KwPN7m5UjlNJvjnkL6leSV85NiWXp828vDRDOWSVECX9qXJK+YHVqlyEzrXCUFcb
V6N0nmcNTW0cwqaCdaq7bQ/qNsUBlWz2tZkAzK145blkbV1BiyCSlG/FDulYit3P
4wQha6CtjlMftjTg70fT9Y++BZH8DXYSCxAQg/ssuQXUyEG5hDbfRE2KEhzGPBM3
w3X7Txp+qmqiUn6b5cPWy3nuVqDTroSbcnB5CAGWXwA1v+ZaE8fjucCCb02wCL+R
XN8nuUsLQWbykz+kaS+iMNhDv3ujG+vPbXrVOwmrL5KWQnadAJ18P0EDTEkYBjRG
s38A/g1DpQIXfwj41am10evjLOSBX/q47UU7LR23nFQdCGEJS2qERgOpMqMk0CVS
H45wAprtl3ZXZbGQOeO3vq4qmim2GYj9ta4HfYXvg4D2+h3MJcv6bBfEYptUhHa7
7id8Y+GUdtVHa8xMuqGx
=vQbh
-----END PGP SIGNATURE-----

--pI6hLdwVzam1XFuA--

Return-Path: <dja@axtens.net>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A3271A05F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 11:40:48 +1000 (AEST)
Received: by pablk4 with SMTP id lk4so92961746pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:40:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 29/32] cxlflash: Fix to double the delay each time
In-Reply-To: <1443223157-10039-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223157-10039-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 11:40:32 +1000
Message-ID: <87wpvat33j.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> From: Manoj Kumar <manoj@linux.vnet.ibm.com>
>
> The operator used to double the delay is incorrect and
> does not result in delay doubling.
>
> To fix, use a left shift instead of the XOR operator.
>
I can see that the patch is correct, but this commit message is a bit
confusing. What delay? In what circumstances are you doubling it? Why?

Regards,
Daniel

> Reported-by: Tomas Henzl <thenzl@redhat.com>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index ab11ee6..be78906 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -303,7 +303,7 @@ write_rrin:
>  		if (rrin !=3D 0x1)
>  			break;
>  		/* Double delay each time */
> -		udelay(2 ^ nretry);
> +		udelay(2 << nretry);
>  	} while (nretry++ < MC_ROOM_RETRY_CNT);
>  }
>=20=20
> --=20
> 2.1.0
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWCewRAAoJEPC3R3P2I92F7xQQAKxvcnUpB/xLeq6CyB3LwsB/
cqFMP7OwDRfmQZG5ld5uqfXsjCCW4c0BaVknMgpD5gAdHbrwbc5gFgYuC0kIDUrH
aEwTyXwaH7+o82agjxf7TRrsh2NtLzdSB6NN1UNL73aPVXJFKWITajIKUAnYF5d1
AvB3yb4KtX0qklo205igVceuLbBBaXY6Lz3V58XDSG2JAtVlVkamJK7M8zySrNTY
Y627zTVkbopOGaBMLmu0q92dWDk2saU2wqKolo+pRy1NpOmY2XOU9hSRqCqAhnS4
xOWj7Bdrh1HdnQX26EC+f485nOijf0zddpJ6LsgPWMElJ04N4siQwmrwG55FbOs4
QDFKPdsVdZ8qmVueGCLRdTsMNAxcobi44P1/QXxGTmsn9xqyQBgZUzbd5oRUVswI
md21qir3xjRN7g4R78084I88dM1yrHpJ6NuHDxFeXbtrw8087lKgU05Ys6m+ebuC
7nPnYRJ54frAi6a7mmBq+Xc4IbVnaGl9IZi1gujM2mkTaAk7/wl7oRMYyUTKlblp
BeoQN0cdG1fChP1yLHzZV6G1JXwSw7nP6otf7YfUIrmjbzeZ5zWovSqJjnvNYBCT
zgW681gIF3GwaN9z9I+XY9BO1P6EkYp+dgAQM7PqdR00GjFjTJO0yn8WHh113lmE
L2sC0Nezuq8V4/qtspmh
=3DKm/z
=2D----END PGP SIGNATURE-----

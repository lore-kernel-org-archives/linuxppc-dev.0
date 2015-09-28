Return-Path: <dja@axtens.net>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5AD1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 08:39:24 +1000 (AEST)
Received: by pablk4 with SMTP id lk4so89060139pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 15:39:22 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 07/32] cxlflash: Fix context encode mask width
In-Reply-To: <1443222847-9190-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443222847-9190-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 08:39:07 +1000
Message-ID: <87k2rauq2c.fsf@gamma.ozlabs.ibm.com>
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


Looks good to me.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> The context encode mask covers more than 32-bits, making it
> a long integer. This should be noted by appending the ULL
> width suffix to the mask.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/superpipe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/su=
perpipe.h
> index 72d53cf..7947091 100644
> --- a/drivers/scsi/cxlflash/superpipe.h
> +++ b/drivers/scsi/cxlflash/superpipe.h
> @@ -87,7 +87,7 @@ enum ctx_ctrl {
>  	CTX_CTRL_FILE		=3D (1 << 5)
>  };
>=20=20
> -#define ENCODE_CTXID(_ctx, _id)	(((((u64)_ctx) & 0xFFFFFFFF0) << 28) | _=
id)
> +#define ENCODE_CTXID(_ctx, _id)	(((((u64)_ctx) & 0xFFFFFFFF0ULL) << 28) =
| _id)
>  #define DECODE_CTXID(_val)	(_val & 0xFFFFFFFF)
>=20=20
>  struct ctx_info {
> --=20
> 2.1.0
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWCcGLAAoJEPC3R3P2I92FJ1kP/juiS2a5hBDOGjVliW6KlWK6
pb9yRZ1qmvgiL1xtMO/rfSEEb/kwO6QSbDcKqLtKwI24DBkVF2eDAOo9mOKKNhBI
EF/AwZsvG1DE3o0+AAx3mY7+AO1rP+uZSvCJf5GvDDdSfYXfq5f49+aM6HJ0n130
ewlQmOnwwGDpO2gehccrDSmSbUB1CwKY1uQ5KtczGqdtfkgSu7YVRHKiNiid9Nop
uJWDE452NBm2dM5Jf2hXFXwMSzx9bbmM5Ue27gf1HES8CGw3Z2BQtYIx6tjHLYH/
Rj4dPSLBjuBeEI4YZHqxkYs3ipBV38wRwuG0O5o+YKUD6TczeYtwwCVAmma8pTm2
tYT8xrY19Ng3oQ1P68zxP4D5uYbdFhIOyqLhss9Lnas0VxzZUbdfiuF4V8ABSGTz
L8WFw2ff/73LtVaSr/KGyt1RvfLpoEFxkYd3+sGwsfqM/HyC2K3g4RZucLct1oeX
PPPKz5ZQF9K/R/mKJEIAG+Fh0usryj97Wgf+r3Ie0QQDorOoG+8itGg0OJ0o1ojV
wjduJiwsoD+2HwnTw85TwSp6PPY+8o7Gml1PvfGUFWJjPgSUkcQ6L3lrispE4twt
hgrWSsRE/GO5+JD9KNSYnKr8dRxD6iDFefppZv64nWJKi11PZoz7z09Q+dE1KAng
jpNUi5wyGph2AwD7E9I2
=3DM1UV
=2D----END PGP SIGNATURE-----

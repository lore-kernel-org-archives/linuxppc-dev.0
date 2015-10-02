Return-Path: <dja@axtens.net>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376C41A015B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 11:00:31 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so90382978pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 18:00:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 17/34] cxlflash: Remove dual port online dependency
In-Reply-To: <1443715001-18110-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443715001-18110-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Fri, 02 Oct 2015 11:00:15 +1000
Message-ID: <87egheaxuo.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> At present, both ports must be online for the device to
> configure properly. Remove this dependency and the unnecessary
> internal LUN override logic as well. Additionally, as a refactoring
> measure, change the return code variable name to match that used
> throughout the driver.
>
> With this change, the card will be able to configure even when the
> link is down. At some later point when the link is transitioned to
> 'up', a link state change interrupt will trigger the port configuration.
> Note that despite its void-like behavior, the function was left with a
> return code for right now in case its behavior needs to be altered again
> in the near future based on testing.
>

Thanks for updating that.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index ed9fd8c..c25efc3 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1030,7 +1030,7 @@ static int wait_port_offline(u64 *fc_regs, u32 dela=
y_us, u32 nretry)
>   */
>  static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 wwp=
n)
>  {
> -	int ret =3D 0;
> +	int rc =3D 0;
>=20=20
>  	set_port_offline(fc_regs);
>=20=20
> @@ -1038,33 +1038,26 @@ static int afu_set_wwpn(struct afu *afu, int port=
, u64 *fc_regs, u64 wwpn)
>  			       FC_PORT_STATUS_RETRY_CNT)) {
>  		pr_debug("%s: wait on port %d to go offline timed out\n",
>  			 __func__, port);
> -		ret =3D -1; /* but continue on to leave the port back online */
> +		rc =3D -1; /* but continue on to leave the port back online */
>  	}
>=20=20
> -	if (ret =3D=3D 0)
> +	if (rc =3D=3D 0)
>  		writeq_be(wwpn, &fc_regs[FC_PNAME / 8]);
>=20=20
> +	/* Always return success after programming WWPN */
> +	rc =3D 0;
> +
>  	set_port_online(fc_regs);
>=20=20
>  	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
>  			      FC_PORT_STATUS_RETRY_CNT)) {
> -		pr_debug("%s: wait on port %d to go online timed out\n",
> -			 __func__, port);
> -		ret =3D -1;
> -
> -		/*
> -		 * Override for internal lun!!!
> -		 */
> -		if (afu->internal_lun) {
> -			pr_debug("%s: Overriding port %d online timeout!!!\n",
> -				 __func__, port);
> -			ret =3D 0;
> -		}
> +		pr_err("%s: wait on port %d to go online timed out\n",
> +		       __func__, port);
>  	}
>=20=20
> -	pr_debug("%s: returning rc=3D%d\n", __func__, ret);
> +	pr_debug("%s: returning rc=3D%d\n", __func__, rc);
>=20=20
> -	return ret;
> +	return rc;
>  }
>=20=20
>  /**
> --=20
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWDdcfAAoJEPC3R3P2I92FDxQP/0iGrkh4a2/Kxn6ebn8SLlE3
ynw1wzxoG7aLSqGnjM3fp1BA/OrLEdEPaRMxjHH7I7REwJq6HPtrJvxjRmfT3+ZS
LxY5YIzWVqZN4WE/9hLXlDzDmH6QWvL/019BNvP/qq9tSOvrFQqQCynxqnpXktC4
fEpdFgPiwLnO4lfs9P4B81VM29Fc2rJNz2rMy6uTuVfMueCNM8RXC541aXyDhXya
iaLnjgrArxXqdtKAoVHIrKxn7hqtSMgx8ZrcPIjoduefl7PI5Q/vgPsUv04kZ7Ns
/H6lkeiK/FszfTIANu8ySbvAfx1TMpEO9y8Er8qw7WkSjUPXVkelI5R5A918obtq
TL5SxqB6lHkrXnZqYSqJ8OWwiii++RY5LrrPOtVd+yXr3X2OQGZvPx0lOMQxRl+6
cJUq/5/rKgw9GLnYlfNNHuxl28O+sWaOhxgtccmbHFzTCJQlw5naJVJs14YyM5DM
nUfe5Ifn+rZXOTqn9Y2Tz/+cpk36Tdk08xXX8WhCBmZqatVGfWdziN5D+aTTYmLh
onJ23rAqiVoVYda4O0d+TM6+mYzhbZv4GdSqSCJpFmlYpFVzKwrlqR34vryqJ8/1
wS/Bsdtc931hD9Bi9nPr2VrSkPNtUBS/c2JpNdiP8bNDy5UYrvxOxvnr3Q1nqK6E
IVGL3lQiIFbPpWvPR8qu
=pYQ3
-----END PGP SIGNATURE-----
--=-=-=--

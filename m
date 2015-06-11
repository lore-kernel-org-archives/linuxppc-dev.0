Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1580F1A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 11:20:45 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1DCF01402AD
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 11:20:43 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so47723296pdj.3
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 18:20:41 -0700 (PDT)
Message-ID: <1433985583.31423.4.camel@axtens.net>
Subject: Re: [PATCH V8 09/10] powerpc, perf: Enable privilege mode SW branch
 filters
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 11:19:43 +1000
In-Reply-To: <1433763511-5270-9-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-9-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-HQ8QxVTbMpV5AA4pghBY"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-HQ8QxVTbMpV5AA4pghBY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 	if (sw_filter & PERF_SAMPLE_BRANCH_PLM_ALL) {
> +		flag =3D false;
Would it be possible to use a more meaningful name than flag? Perhaps
indicating what is it flagging?
> +
> +		if (sw_filter & PERF_SAMPLE_BRANCH_USER) {
> +			if (to_plm =3D=3D POWER_ADDR_USER)
> +				flag =3D true;
> +		}
> +
> +		if (sw_filter & PERF_SAMPLE_BRANCH_KERNEL) {
> +			if (to_plm =3D=3D POWER_ADDR_KERNEL)
> +				flag =3D true;
> +		}
> +
> +		if (sw_filter & PERF_SAMPLE_BRANCH_HV) {
> +			if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +				if (to_plm =3D=3D POWER_ADDR_KERNEL)
> +					flag =3D true;
> +			}
> +		}

Is there any reason these are nested ifs rather than &&s?

> +
> +		if (!flag)
> +			return false;
> +	}
> +

> @@ -700,7 +710,6 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_t=
ype, u64 *bhrb_filter)
>  			if (branch_sample_type) {
>  				/* Multiple filters will be processed in SW */
>  				pmu_bhrb_filter =3D 0;
> -				*bhrb_filter =3D 0;
>  				return pmu_bhrb_filter;
>  			} else {
>  				/* Individual filter will be processed in HW */
What's the justification for the removal of this line? You added it in
the previous patch...

Regards,
Daniel

--=-HQ8QxVTbMpV5AA4pghBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVeOIwAAoJEPC3R3P2I92FRvEQAKkXdrYltRPrfUkpLVD5o6wo
xLEqKozdIp3Y4XZmRhqm3RmbLrrdX1IkSXvoKNFwufVY9V3W1LKmGoUKT8bakKQc
sNqm7LMaZ+RSIVC47i2Q7GsW3v6lZmZUEGwMdfhEsoQHjXTyFgmeyJfgHl4bs0Ir
MxVKmzQdql/cGhjJp9PQDBgMzfxENbNbjlX/v+Z3zXM6ADwQlden4YhbxN4Z9HQR
LdiAby41FlQ6r69UrTU7RbvkAV4rGceAfoFGrTOJqRSwCVEh3mAO+darpsfTXOQP
trPvNWxuPMinc/dvR+gVuuhyHJxCSfnvahe2J1xciTvZlw8KqBvTHfcXFrFxHMql
P7XNe7h1gNsGTSYr54cUAWDQJmBJiS7SYysAh+tD3dt8u1bAFJebUFHuuXH164eS
j01HCmC8HQQam5Lapx9vBP7PuXk58JdTg5m4Dm2rzSjjrdhUn+dDb1aOg/OJqHrv
c7wSjs2AA76yTvP2D462G1RrBu/9kNp3DStGvoUacpoHJDDZ+d//4hYZcEe+l9a0
8x0yxK06Cji3tBd3eQsFUxqszWdS0QzelRbufBUVDS+xzb/OB2lz4AzkBm3yD0Lb
eTN35ljsn7UuQomrzxyzZL2zicjpSiFBDSGgVa+Jc+Rw090df6dyBpbQPrBdPSGC
SGsDUXff5NVQXM/TQMem
=t6n7
-----END PGP SIGNATURE-----

--=-HQ8QxVTbMpV5AA4pghBY--

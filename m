Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EA5A0DE158
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 10:33:53 +1100 (EST)
Date: Tue, 30 Oct 2007 10:33:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] [Powerpc V2] fix switch_slb handling of 1T ESID values
Message-Id: <20071030103350.20023fef.sfr@canb.auug.org.au>
In-Reply-To: <20071029183218.19914.51410.stgit@farscape.rchland.ibm.com>
References: <20071029183218.19914.51410.stgit@farscape.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__30_Oct_2007_10_33_50_+1100_X=fJzkL=riTZqp5M"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__30_Oct_2007_10_33_50_+1100_X=fJzkL=riTZqp5M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

Just a trivial comment ...

On Mon, 29 Oct 2007 13:32:19 -0500 Will Schmidt <will_schmidt@vnet.ibm.com>=
 wrote:
>
> +static inline int esids_match(unsigned long addr1, unsigned long addr2)
> +{
> +	int esid_1t_count;
> +
> +	/* System is not 1T segment size capable. */
> +	if (!cpu_has_feature(CPU_FTR_1T_SEGMENT))
> +		return (GET_ESID(addr1) =3D=3D GET_ESID(addr2));
> +
> +	esid_1t_count =3D (((addr1>>SID_SHIFT_1T)!=3D0) + ((addr2>>SID_SHIFT_1T=
)!=3D0));

Please use spaces around binary operators (as you have elsewhere). Even
if it pushes the line slightly over 80 characters ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__30_Oct_2007_10_33_50_+1100_X=fJzkL=riTZqp5M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJm3jTgG2atn1QN8RAtXSAJ9K7hzJ40tGL7vPf+apAW/DUIH+BgCfSzsj
AFOYHDanHZLwVfKD2a7IAMI=
=Xjc5
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Oct_2007_10_33_50_+1100_X=fJzkL=riTZqp5M--

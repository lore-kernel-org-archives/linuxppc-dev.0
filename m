Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26B3F1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 10:11:43 +1100 (AEDT)
Date: Mon, 8 Feb 2016 08:33:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, thuth@redhat.com, aik@ozlabs.ru, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 6/9] pseries: Add hypercall wrappers for hash page table
 resizing
Message-ID: <20160207223338.GA3702@voom>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-7-git-send-email-david@gibson.dropbear.id.au>
 <56AF0523.60902@linux.vnet.ibm.com>
 <20160202005820.GB15080@voom.fritz.box>
 <56B331CE.5020806@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <56B331CE.5020806@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 04:41:10PM +0530, Anshuman Khandual wrote:
> On 02/02/2016 06:28 AM, David Gibson wrote:
> > On Mon, Feb 01, 2016 at 12:41:31PM +0530, Anshuman Khandual wrote:
> >> On 01/29/2016 10:54 AM, David Gibson wrote:
> >>> This adds the hypercall numbers and wrapper functions for the hash pa=
ge
> >>> table resizing hypercalls.
> >>>
> >>> These are experimental "platform specific" values for now, until we h=
ave a
> >>> formal PAPR update.
> >>>
> >>> It also adds a new firmware feature flat to track the presence of the
> >>> HPT resizing calls.
> >>
> >> Its a flag   ....................... ^^^^^^^ here.
> >=20
> > Oops, thanks.
> >=20
> >>
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  arch/powerpc/include/asm/firmware.h       |  5 +++--
> >>>  arch/powerpc/include/asm/hvcall.h         |  2 ++
> >>>  arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
> >>>  arch/powerpc/platforms/pseries/firmware.c |  1 +
> >>>  4 files changed, 18 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/inclu=
de/asm/firmware.h
> >>> index b062924..32435d2 100644
> >>> --- a/arch/powerpc/include/asm/firmware.h
> >>> +++ b/arch/powerpc/include/asm/firmware.h
> >>> @@ -42,7 +42,7 @@
> >>>  #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
> >>>  #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
> >>>  #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
> >>> -/* Free				ASM_CONST(0x0000000001000000) */
> >>> +#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
> >>>  #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
> >>>  #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
> >>>  #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
> >>> @@ -66,7 +66,8 @@ enum {
> >>>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
> >>>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
> >>>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> >>> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> >>> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> >>> +		FW_FEATURE_HPT_RESIZE,
> >>>  	FW_FEATURE_PSERIES_ALWAYS =3D 0,
> >>>  	FW_FEATURE_POWERNV_POSSIBLE =3D FW_FEATURE_OPAL,
> >>>  	FW_FEATURE_POWERNV_ALWAYS =3D 0,
> >>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include=
/asm/hvcall.h
> >>> index e3b54dd..195e080 100644
> >>> --- a/arch/powerpc/include/asm/hvcall.h
> >>> +++ b/arch/powerpc/include/asm/hvcall.h
> >>> @@ -293,6 +293,8 @@
> >>> =20
> >>>  /* Platform specific hcalls, used by KVM */
> >>>  #define H_RTAS			0xf000
> >>> +#define H_RESIZE_HPT_PREPARE	0xf003
> >>> +#define H_RESIZE_HPT_COMMIT	0xf004
> >>
> >> This sound better and matches FW_FEATURE_HPT_RESIZE ?
> >=20
> > I'm not quite sure what you're suggesting here.
> >=20
> >> #define H_HPT_RESIZE_PREPARE	0xf003
> >> #define H_HPT_RESIZE_COMMIT	0xf004
>=20
> Just little bit of change of name of the macro like this
>=20
>=20
> H_RESIZE_HPT_PREPARE -->  H_HPT_RESIZE_PREPARE
> H_RESIZE_HPT_COMMIT -->  H_HPT_RESIZE_COMMIT

Oh, I see.  Actually, I'm trying to standardize on "resize hpt" rather
than "hpt resize" everywhere.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWt8ZBAAoJEGw4ysog2bOSvJ0P/R0LU9+dRpXPlZUqKZE2Urbz
CZOrrIqoQdaw5AVtQcwCvWmVHzG2GgpjfpSldsadi+IZiUTTnbT+rmn1yzTym8BG
xj4WqOvu0LcUXU7YqfISFOx18Ae8bnNIG+dkBxf07cmfAhTNhJ6kb7IsTW3OudXb
S34o8TvzKezMYge/R7S3SLJe1g4+8xiGhp/dHGsRa/SuZSvcsmwEX2uuIwGHXkG9
Qi/5WotWs21T3YoHhxL64brTLE0pc32fwEuRivQIcatfYw9jPQw4i2uaZzYxeks8
zO7/FWOMj1bh/lqCj02bqCq/miQjy79F02YBqOxkG6HxaYaYzQL8jDDqFUqFBBF+
LoqpIjlTuDtnqrTxjQRND+RfGmbh2DlY04/4k7aeKM6lWVfjf+lXY/W1XQ7DxI58
2JmzuiWA2Q+AJiX/L9gdpnxGvHOMC6mH9xXWWjk7K1ocFtD1VDAaf7hks0KBHBEI
gMNiHYtB82FGVGK868xAR/mKc/U30VPJXqcLI6/8arwJ0mqphPyFdbaeIv5l55qg
KEo4qap3GvPfsG+Ql9lqg1/ViyIWqPc8Vq6GtugLzcOuIkKyadT4ik5BIYORq6NF
mDv4YLHxWiXXIjBHeRrmi8XjiHhg3bUJr22orsU9k7yBcgcLjYv22mSxEB9Z7oWR
sUtBW3r/AcLB4h0sk+eC
=P8M9
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

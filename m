Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 70D942C0401
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 08:41:34 +1000 (EST)
Date: Tue, 10 Jul 2012 08:41:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 03/11] arch/powerpc: Convert virtual address to vpn
Message-Id: <20120710084128.6fe4a4347719f4445dd12b4f@canb.auug.org.au>
In-Reply-To: <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__10_Jul_2012_08_41_28_+1000_nZUHk7RIXYgmMost"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jul_2012_08_41_28_+1000_nZUHk7RIXYgmMost
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,

On Mon,  9 Jul 2012 18:43:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.v=
net.ibm.com> wrote:
>
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include=
/asm/mmu-hash64.h
> index 1c65a59..1c984a6 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -154,9 +155,25 @@ struct mmu_psize_def
>  #define MMU_SEGSIZE_256M	0
>  #define MMU_SEGSIZE_1T		1
> =20
> +/*
> + * encode page number shift.
> + * Inorder to fit the 78 bit va in a 64 bit variable we shift the va by
> + * 12 bits. This enable us to address upto 76 bit va.
> + * For hpt hash from a va we can ignore the page size bits of va and for
> + * hpte encoding we ignore upto 23 bits of va. So ignoring lower 12 bits=
 ensure
> + * we work in all cases including 4k page size.
> + */
> +#define VPN_SHIFT	12
> =20
> +static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psiz=
e,
> +					     int ssize)
> +{
> +	unsigned long v;
> +	/*
> +	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
> +	 * These bits are not needed in the PTE, because the
> +	 * low-order b of these bits are part of the byte offset
> +	 * into the virtual page and, if b < 23, the high-order
> +	 * 23-b of these bits are always used in selecting the
> +	 * PTEGs to be searched
> +	 */
> +	BUG_ON(VPN_SHIFT > 23);

Could/should this be BUILD_BUG_ON()?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__10_Jul_2012_08_41_28_+1000_nZUHk7RIXYgmMost
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP+14YAAoJEECxmPOUX5FEI94P/iBLdkAAcycdj6aQoJozRTBa
U+aEsHvZIfEcxzjktkP05qwxwA8dxUssEsZYegnTFNJP8w+QIMyRQSvIuKu8YCM5
aAWmrLaQyIFRewygYmVBbVV+q9nhOJWCRCfO+oTJ3LaDSNV4KKZZbyhrKAgAKyAO
4z5+r8iTe5UJX8YmGzLp2mJ7dyaNCpbYk0oar7mHLFuaJiIphZ+PSj0hUQYH+axg
h6GY4DbGhOLnU742PxYbXcmIf6Tyo0dnKu098PVmA55i+4qQHkT4SsUYGf1giLq3
g+PTR8UN01j7Aki568oDUOpa6dIDXSmBUGaoH5ctPbae2LfpxQN9kA6OQabcHDC0
b8J6wdcxp2WgIJlJptDot3JTKFKmkVAG9T3n94ictBYiIlZ8mVBEW9EYGY8XJ77Y
vJSJLHhrYyqIFPmWzDx1rowl8sVS0JQWH44S1lgWeQ7emHAXijibxarVuAwxP2hd
rASRQpYmuztAMzEPoxTR0UOpcBZFBgjR7Vn3eOUh1wwihQX4KZ5in1kRLjT6X6DG
naWLenXBwQ3J6f5cJJYZxuPT7r0qJi+ACktqLRehbUWSNhfjvYF8vABzDrE8MiGC
VrxfR2rY4v2mUDA2GHf8DajhNjvjuRu4Uhz4/CzQ/xfqYQ0kHx41H4wsAMrFycLu
BAtPHu9E2oDYaKCc6lZ4
=fsgr
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jul_2012_08_41_28_+1000_nZUHk7RIXYgmMost--

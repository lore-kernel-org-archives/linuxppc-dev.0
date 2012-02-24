Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 32EBDB6EEA
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2012 00:01:43 +1100 (EST)
Date: Sat, 25 Feb 2012 00:01:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
Message-Id: <20120225000141.73c0de577597e675a0fb5021@canb.auug.org.au>
In-Reply-To: <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__25_Feb_2012_00_01_41_+1100_w47A9HzlpmU6Vcr6"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__25_Feb_2012_00_01_41_+1100_w47A9HzlpmU6Vcr6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

On Fri, 24 Feb 2012 17:38:17 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> w=
rote:
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index 1310971..226c9a5 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -98,6 +98,21 @@ struct eeh_ops {
>  	int (*configure_bridge)(struct device_node *dn);
>  };
> =20
> +/*
> + * The struct is used to maintain the EEH global statistic
> + * information. Besides, the EEH global statistics will be
> + * exported to user space through procfs
> + */
> +struct eeh_stats {
> +	unsigned long no_device;	/* PCI device not found		*/
> +	unsigned long no_dn;		/* OF node not found		*/
> +	unsigned long no_cfg_addr;	/* Config address not found	*/
> +	unsigned long ignored_check;	/* EEH check skipped		*/
> +	unsigned long total_mmio_ffs;	/* Total EEH checks		*/
> +	unsigned long false_positives;	/* Unnecessary EEH checks	*/
> +	unsigned long slot_resets;	/* PE reset			*/
> +};

If this is used in only one place, there is not much point in putting it
in a header file.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__25_Feb_2012_00_01_41_+1100_w47A9HzlpmU6Vcr6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPR4o1AAoJEECxmPOUX5FEfdMP/j3v2oG4cUfhT/rNJ1nIs3sD
lYFXvznLvjmlwzYWkogAY5Zs8qlZQcS9YJgjM4IuU0qSagcMg/9j0bEKGf3eSOWP
JiuD6buLLvWYH2Pp/60X0BhIsp1KIUE9OacPWyYiLskOx8RB8kHBOVuL1SIlvk4J
7vS/snaJXBMQGP3HAIKxR/7GtqopLKcgKXLfxXYYQMOEv+V/ul5Bpb8GsG3cG3ky
9iSSNyGVdkc6yBn3SZigEEilnNBhMUVogZE6l0A+frXywIZwPfPYZI4VQRacdR/V
1gIYf2YenpJ7d3M22PCd3UAEy4vbz0qKakAeMrvpafBigm4T7MKdxH0imyS+ZE0v
VwprHqj59VNKMBQkrvVOR7w9Qz+ut5aGQlLxdEZFeyAR8dLW8umb/g7sVamjfsMX
zNhyIVwuoqnSZEq7gDMlCBZqs8TPErARuwr6H3cdidfBCQDCZn04Bz0RIJy1cyF4
EVKu1ghTKwCs10Re8Pv16pmVHwY1edMwnc9YHSIJcgjCb5cLCJsRFUrQ004dx8KF
tqm8xIVXGXoonH20BWDKnZJ6xYThhy7Vxn5Wen5V+4S+dN4dOtXuB3pOrVaIHNBP
zOQqr19gnqYXvtp8ZlX7M5ar6DX2mupwDIYbn5+QbIpKQ9Dfq3j0L4T4CZ6+alLp
oi+3xS+JQJOyvYMgpQAH
=H6v4
-----END PGP SIGNATURE-----

--Signature=_Sat__25_Feb_2012_00_01_41_+1100_w47A9HzlpmU6Vcr6--

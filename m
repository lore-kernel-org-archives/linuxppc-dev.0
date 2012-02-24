Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D8B6EB6EEC
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 23:50:19 +1100 (EST)
Date: Fri, 24 Feb 2012 23:50:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/21] Introduce EEH device
Message-Id: <20120224235012.63b01e51749cb09bc0195d38@canb.auug.org.au>
In-Reply-To: <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__24_Feb_2012_23_50_12_+1100_7=QtrWHYX1iyf7ND"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Feb_2012_23_50_12_+1100_7=QtrWHYX1iyf7ND
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

On Fri, 24 Feb 2012 17:38:11 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> w=
rote:
>
> diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm=
/device.h
> index d57c08a..4668344 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -31,6 +31,9 @@ struct dev_archdata {
>  #ifdef CONFIG_SWIOTLB
>  	dma_addr_t		max_direct_dma_addr;
>  #endif
> +#ifdef CONFIG_EEH
> +	void			*edev;
> +#endif
>  };
> =20
>  struct pdev_archdata {
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index ad8f318..1310971 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> +#define OF_NODE_TO_EEH_DEV(dn)		((struct eeh_dev *)(dn->edev))
> +#define PCI_DEV_TO_EEH_DEV(pdev)	((struct eeh_dev *)(pdev->dev.archdata.=
edev))

If the edev fields of dev_archdata and device_node are always going to be
"struct eeh_dev *", why not declare then as such and avoid the casting?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Feb_2012_23_50_12_+1100_7=QtrWHYX1iyf7ND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPR4eEAAoJEECxmPOUX5FEJNkP/Rzpo8/DrJ6aoBgn3Zfb1eC2
Ccg0PY5p6SDO6P09AqhkX776Alh/y2EgNUdwvS8Z8dVrc4mEru5WhLHabO27cy8K
u2M73nlOLPevn+KQ7+TDtem9YT6ajKxKXVyTvmOPVhTy075dIvNI10mTjXKbC3bs
XivzIms76+846j1OvQsjSJoE8RmiYujbuUGQfvIiu4TswqB/f/PNq7Z+B5RErQXr
7Tw4mjYgoIInqU47+Ola7ae5ViiKRjZt/GlB28NM3by1apEsIL5AWX/6reqMafme
lctMMa6nlTWZpLpH8r0ctbqrt5G7FM4VDOze7YEaTtVp5w40xy1oPPsKnXDeF4by
3li6IWTydKaw1ZhMQURSoBhXqj+K3QDCFzTdKKg+ujQ+2/HLfNWiL2vlHaMutuq7
0/nSZJDQcy2vNI9EgDJ6LSsqdurwiN1rSbydFAofi+qFx+LCVwHGQu5zWvP1vtcZ
7OsckXQ3aAHluantOEv/S0pDNOq6u2ogkcQqjqOfKxn9KrjlU3l7DF0/WtyjGOPD
703Mow1DSLGGF+P9lZWrz5YrnYrx5Cf5Fkkerq73RHWAPqZcfi5jv2Ar4B3rjLuy
phE5qLd/JZ2Z5NqzMMUR1fjrj9YMLHlQzrGRpZjF1Owjv3BcBd8a7W/aI1ij8Yrr
9WKgdx3VSDWV37yAmDIV
=/RjC
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Feb_2012_23_50_12_+1100_7=QtrWHYX1iyf7ND--

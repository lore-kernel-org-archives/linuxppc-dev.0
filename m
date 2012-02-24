Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 36830B6EEC
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 23:46:12 +1100 (EST)
Date: Fri, 24 Feb 2012 23:46:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/21] Introduce EEH device
Message-Id: <20120224234610.922da1a3a2523ee5b6319390@canb.auug.org.au>
In-Reply-To: <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__24_Feb_2012_23_46_10_+1100_pbzVMIsh4r_xE7jz"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Feb_2012_23_46_10_+1100_pbzVMIsh4r_xE7jz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

On Fri, 24 Feb 2012 17:38:11 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> w=
rote:
>
> +#define EEH_DEV_TO_OF_NODE(edev)	(edev->dn)
> +#define EEH_DEV_TO_PCI_DEV(edev)	(edev->pdev)
> +#define OF_NODE_TO_EEH_DEV(dn)		((struct eeh_dev *)(dn->edev))
> +#define PCI_DEV_TO_EEH_DEV(pdev)	((struct eeh_dev *)(pdev->dev.archdata.=
edev))

You need to put parentheses around the use of macro arguments ... or,
even better, make these into "static inline" accessor functions (with
lower case names).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Feb_2012_23_46_10_+1100_pbzVMIsh4r_xE7jz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPR4aSAAoJEECxmPOUX5FE8ycP/15ZKhBGoIfim4Errzw64sl8
mtxKtWNJhfILV2B5ISaBpREYZRDdnnKmPFF7WEqkYG+jC82vXItlnXf6KH/IWi7g
MxuUNpVvh8wvsrJbezpf5fGupe/fHB6IiP1mGNyO75ocs5JWiIB4ZellaC6OtX8M
Asxr6lCMFa5oexzp+7gg+UMTRWGQfDjcQoEIv8h7zxtY1bRpKhIsiUxqppuqAMNX
m4XS0iIVZtjuLvgywlJi9uX6uR7x0AYoU5fxUdIudT8WdD1oyTbUla2ji4Y3D460
9oxN6r0dnXZx+tZL8rxFJ/OmP6TcwgbbEapbzlFa4nvzF9nGb4W1fq+A0gHNyE1x
EgWQkNwUqOlAtI3hqIDOn6kVxXH4UCbI5C5HHR/9aOc8NlIu0xtUWT8OHw64+Ret
JqxI22Za4/JE3HSu5qwNA+bL+DAddCXwjKjIesIlY6iE9QHGJjTFsVpaDFgBc/T5
xRSgcqZvbyHRG76hpBNWbacM+HQP8tmOOEVZ28xdJt+1y9h90d6bcZz5iV9bF1IX
wceF2ShNMXtjNqLdha7K90EdwR4SzJhHRENkcytcFS0LiaARVIdPR+aQZAysPU64
9TR4DZvzy+AVtN2xg1h1zTK8OaWLKg17UYkw4rajVKlBCcxZ/RIImnbKzigrkbOP
3EQzrew1G5y2qnAibeNx
=uj7m
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Feb_2012_23_46_10_+1100_pbzVMIsh4r_xE7jz--

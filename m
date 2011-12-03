Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 465F01007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2011 02:53:47 +1100 (EST)
Subject: Re: [PATCH v3 02/10] powerpc: Consolidate mpic_alloc() OF address
 translation
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322843287-2745-3-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Sat, 3 Dec 2011 09:53:27 -0600
Message-Id: <6AB1179B-FB0B-4E43-AE94-43D3D6FF80CE@kernel.crashing.org>
References: <1322795058.3729.48.camel@pasglop>
 <1322843287-2745-3-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 2, 2011, at 10:27 AM, Kyle Moffett wrote:

> Instead of using the open-coded "reg" property lookup and address
> translation in mpic_alloc(), directly call of_address_to_resource().
> This includes various workarounds for special cases which the naive
> of_address_translate() does not.
>=20
> Afterwards it is possible to remove the copiously copy-pasted calls to
> of_address_translate() from the 85xx/86xx/powermac platforms.
>=20
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/corenet_ds.c  |    9 +----
> arch/powerpc/platforms/85xx/ksi8560.c     |    9 +----
> arch/powerpc/platforms/85xx/mpc8536_ds.c  |    9 +----
> arch/powerpc/platforms/85xx/mpc85xx_ads.c |    9 +----
> arch/powerpc/platforms/85xx/mpc85xx_cds.c |    9 +----
> arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   11 +----
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    9 +----
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   11 +----
> arch/powerpc/platforms/85xx/p1010rdb.c    |    9 +----
> arch/powerpc/platforms/85xx/p1022_ds.c    |    9 +----
> arch/powerpc/platforms/85xx/p1023_rds.c   |    9 +----
> arch/powerpc/platforms/85xx/sbc8548.c     |    9 +----
> arch/powerpc/platforms/85xx/sbc8560.c     |    9 +----
> arch/powerpc/platforms/85xx/socrates.c    |    9 +----
> arch/powerpc/platforms/85xx/stx_gp3.c     |    9 +----
> arch/powerpc/platforms/85xx/tqm85xx.c     |    9 +----
> arch/powerpc/platforms/85xx/xes_mpc85xx.c |    9 +----
> arch/powerpc/platforms/86xx/pic.c         |    4 +-
> arch/powerpc/platforms/powermac/pic.c     |    8 +---
> arch/powerpc/sysdev/mpic.c                |   61 =
++++++++++++++++-------------
> 20 files changed, 55 insertions(+), 175 deletions(-)

What about cleaning up:

arch/powerpc/platforms/chrp/setup.c:    chrp_mpic =3D mpic_alloc(np, =
opaddr, MPIC_PRIMARY,
arch/powerpc/platforms/embedded6xx/holly.c:     mpic =3D =
mpic_alloc(tsi_pic, mpic_paddr,
arch/powerpc/platforms/embedded6xx/linkstation.c:       mpic =3D =
mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC
arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c:      mpic =3D =
mpic_alloc(tsi_pic, mpic_paddr,
arch/powerpc/platforms/embedded6xx/storcenter.c:        mpic =3D =
mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC
arch/powerpc/platforms/maple/setup.c:   mpic =3D mpic_alloc(mpic_node, =
openpic_addr, flags,
arch/powerpc/platforms/pasemi/setup.c:  mpic =3D mpic_alloc(mpic_node, =
openpic_addr,
arch/powerpc/platforms/pseries/setup.c: mpic =3D =
mpic_alloc(pSeries_mpic_node, openpic_addr,

Seems like we should be able to remove the 'phys_addr' argument =
altogether.

- k=

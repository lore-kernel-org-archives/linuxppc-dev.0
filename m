Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 572391007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2011 03:05:20 +1100 (EST)
Subject: Re: [PATCH v3 05/10] powerpc/mpic: Search for open-pic device-tree
 node if NULL
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322843287-2745-6-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Sat, 3 Dec 2011 10:05:11 -0600
Message-Id: <3E03D1A2-0DF4-4E1D-B933-2AA300E54950@kernel.crashing.org>
References: <1322795058.3729.48.camel@pasglop>
 <1322843287-2745-6-git-send-email-Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 2, 2011, at 10:28 AM, Kyle Moffett wrote:

> Almost all PowerPC platforms use a standard "open-pic" device node so
> the mpic_alloc() function now accepts NULL for the device-node.  This
> will cause it to perform a default search with =
of_find_matching_node().
>=20
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> arch/powerpc/platforms/85xx/corenet_ds.c          |   10 +-----
> arch/powerpc/platforms/85xx/ksi8560.c             |   14 +--------
> arch/powerpc/platforms/85xx/mpc8536_ds.c          |   13 +-------
> arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   13 +-------
> arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   15 +--------
> arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   14 ++-------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   10 +-----
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c         |   14 +-------
> arch/powerpc/platforms/85xx/p1010rdb.c            |   12 +------
> arch/powerpc/platforms/85xx/p1022_ds.c            |   14 +--------
> arch/powerpc/platforms/85xx/p1023_rds.c           |   11 +------
> arch/powerpc/platforms/85xx/sbc8548.c             |   16 +---------
> arch/powerpc/platforms/85xx/sbc8560.c             |   13 +-------
> arch/powerpc/platforms/85xx/socrates.c            |   11 +------
> arch/powerpc/platforms/85xx/stx_gp3.c             |   13 +-------
> arch/powerpc/platforms/85xx/tqm85xx.c             |   13 +-------
> arch/powerpc/platforms/85xx/xes_mpc85xx.c         |   13 +-------
> arch/powerpc/platforms/86xx/pic.c                 |   11 +-----
> arch/powerpc/platforms/embedded6xx/holly.c        |   10 +-----
> arch/powerpc/platforms/embedded6xx/linkstation.c  |    8 +----
> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   10 +-----
> arch/powerpc/platforms/embedded6xx/storcenter.c   |   10 +-----
> arch/powerpc/sysdev/mpic.c                        |   34 =
++++++++++++++++++--
> 23 files changed, 58 insertions(+), 244 deletions(-)

Ben,

What do pseries, cell, & maple really have in there device trees?  We =
should be able to move all this into mpic.c

- k=

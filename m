Return-Path: <Emilian.Medve@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Optimize counting distinct entries in
	therelocation sections
Date: Mon, 12 Nov 2007 15:31:53 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BC13C@az33exm24.fsl.freescale.net>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174DB3E@az33exm24.fsl.freescale.net>
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com><18231.60427.229658.485287@cargo.ozlabs.ibm.com>
	<598D5675D34BE349929AF5EDE9B03E270174DB3E@az33exm24.fsl.freescale.net>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: sfr@canb.auug.org.au, rusty@rustcorp.com.au, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,


> > Actually I notice that count_relocs is counting all relocs, not just
> > the R_PPC_REL24 ones, which are all that we actually care about in
> > sizing the PLT.  And I would be willing to bet that every single
> > R_PPC_REL24 reloc has r_addend =3D=3D 0.
>=20
> I'll count only the R_PPC_REL24 and I'll validate if they=20
> have r_addend
> =3D=3D 0.

Seems like there are R_PPC_REL24 with r_addend !=3D 0. Within a set of =
41
modules (featuring 5457 R_PPC_REL24 relocations) already included within
the kernel tree I found 37 such relocations (R_PPC_REL24) with r_addend
!=3D 0. In my test case, from 35K relocations, 7K are R_PPC_REL24 and =
from
those only 8 have r_addend !=3D 0.

> > Also I notice that even with your patch, the actual process of doing
> > the relocations will take time proportional to the product of the
> > number of PLT entries times the number of R_PPC_REL24 relocations,
> > since we do a linear search through the PLT entries each time.
>=20
> The reason I started working on this patch was because the kernel
> detected a soft lockup in count_relocs(). It didn't complain=20
> about other
> parts so I did nothing about them.

Since the time hog in my case (and other's cases, reflected by the
previous patches) seems to be count_relocs(), would it be acceptable as
an incremental improvement to fix this now and address the relocation
process performance (later) if needed?

I'll resubmit the patch incorporating some of the feedback from you and
Rusty.


Cheers,
Emil.

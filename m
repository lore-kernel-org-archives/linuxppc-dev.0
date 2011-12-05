Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from slb-smtpout-01.boeing.com (slb-smtpout-01.boeing.com
 [130.76.64.48])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "slb-smtpout-01.boeing.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3002F1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 05:41:42 +1100 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 5 Dec 2011 12:41:25 -0600
Subject: Re: [PATCH v3 02/10] powerpc: Consolidate mpic_alloc() OF address
 translation
Message-ID: <14B81DE9-6C77-4914-873B-050C33876FF2@boeing.com>
References: <1322795058.3729.48.camel@pasglop>
 <1322843287-2745-3-git-send-email-Kyle.D.Moffett@boeing.com>
 <6AB1179B-FB0B-4E43-AE94-43D3D6FF80CE@kernel.crashing.org>
In-Reply-To: <6AB1179B-FB0B-4E43-AE94-43D3D6FF80CE@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

On Dec 03, 2011, at 10:53, Kumar Gala wrote:
> On Dec 2, 2011, at 10:27 AM, Kyle Moffett wrote:
>> Instead of using the open-coded "reg" property lookup and address
>> translation in mpic_alloc(), directly call of_address_to_resource().
>> This includes various workarounds for special cases which the naive
>> of_address_translate() does not.
>>=20
>> Afterwards it is possible to remove the copiously copy-pasted calls to
>> of_address_translate() from the 85xx/86xx/powermac platforms.
>>=20
>> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/platforms/85xx/corenet_ds.c  |    9 +----
>> arch/powerpc/platforms/85xx/ksi8560.c     |    9 +----
>> arch/powerpc/platforms/85xx/mpc8536_ds.c  |    9 +----
>> arch/powerpc/platforms/85xx/mpc85xx_ads.c |    9 +----
>> arch/powerpc/platforms/85xx/mpc85xx_cds.c |    9 +----
>> arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   11 +----
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    9 +----
>> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   11 +----
>> arch/powerpc/platforms/85xx/p1010rdb.c    |    9 +----
>> arch/powerpc/platforms/85xx/p1022_ds.c    |    9 +----
>> arch/powerpc/platforms/85xx/p1023_rds.c   |    9 +----
>> arch/powerpc/platforms/85xx/sbc8548.c     |    9 +----
>> arch/powerpc/platforms/85xx/sbc8560.c     |    9 +----
>> arch/powerpc/platforms/85xx/socrates.c    |    9 +----
>> arch/powerpc/platforms/85xx/stx_gp3.c     |    9 +----
>> arch/powerpc/platforms/85xx/tqm85xx.c     |    9 +----
>> arch/powerpc/platforms/85xx/xes_mpc85xx.c |    9 +----
>> arch/powerpc/platforms/86xx/pic.c         |    4 +-
>> arch/powerpc/platforms/powermac/pic.c     |    8 +---
>> arch/powerpc/sysdev/mpic.c                |   61 ++++++++++++++++-------=
------
>> 20 files changed, 55 insertions(+), 175 deletions(-)
>=20
> What about cleaning up:
>=20
> arch/powerpc/platforms/chrp/setup.c:    chrp_mpic =3D mpic_alloc(np, opad=
dr, MPIC_PRIMARY,
> arch/powerpc/platforms/embedded6xx/holly.c:     mpic =3D mpic_alloc(tsi_p=
ic, mpic_paddr,
> arch/powerpc/platforms/embedded6xx/linkstation.c:       mpic =3D mpic_all=
oc(dnp, paddr, MPIC_PRIMARY | MPIC
> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c:      mpic =3D mpic_all=
oc(tsi_pic, mpic_paddr,
> arch/powerpc/platforms/embedded6xx/storcenter.c:        mpic =3D mpic_all=
oc(dnp, paddr, MPIC_PRIMARY | MPIC
> arch/powerpc/platforms/maple/setup.c:   mpic =3D mpic_alloc(mpic_node, op=
enpic_addr, flags,
> arch/powerpc/platforms/pasemi/setup.c:  mpic =3D mpic_alloc(mpic_node, op=
enpic_addr,
> arch/powerpc/platforms/pseries/setup.c: mpic =3D mpic_alloc(pSeries_mpic_=
node, openpic_addr,
>=20
> Seems like we should be able to remove the 'phys_addr' argument altogethe=
r.

Well, ideally the MPIC code would just be a OF platform_driver with a
bit of supplementary platform_data to deal with device-tree flaws.
Unfortunately it's quite a long way from that.

Some platforms seem to prefer to use a "platform-open-pic" property on
the root node instead of setting up the "reg" node of the open-pic
itself.

Furthermore, the ISU configuration seems to be board-specific.  pSeries
seems to have all of the ISUs configured as additional cells in the
"platform-open-pic" property, but almost all of the rest are just
hard-coded offsets from the PIC address in the board-support code.

If it was possible to fix the device-trees on the systems with hardcoded
offsets then we could put the ISU addresses into the "platform-open-pic"
property and test that in mpic_alloc().

Otherwise there's still going to be a fair amount of hardcoding for
specific boards.

Regardless, I think this patch series is a good first cut and cleaning
up some of the more egregious code duplication there.

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/

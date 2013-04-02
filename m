Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 838E52C015B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 05:01:02 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI hardware
 errata
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364924974.24520.8@snotra>
Date: Tue, 2 Apr 2013 13:01:08 -0500
Message-Id: <2E50E290-8E1B-4710-A9A9-4FD0FB168693@kernel.crashing.org>
References: <1364268527-32068-2-git-send-email-hongtao.jia@freescale.com>
 <1364594074.13310.13@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C32364@039-SN1MPN1-003.039d.mgd.msft.net>
 <1364924974.24520.8@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 2, 2013, at 12:49 PM, Scott Wood wrote:

> On 04/02/2013 01:35:05 AM, Jia Hongtao-B38951 wrote:
>> > -----Original Message-----
>> > From: Wood Scott-B07421
>> > Sent: Saturday, March 30, 2013 5:55 AM
>> > To: Jia Hongtao-B38951
>> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood =
Scott-
>> > B07421; Li Yang-R58472; Jia Hongtao-B38951
>> > Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with =
MSI
>> > hardware errata
>> >
>> > On 03/25/2013 10:28:47 PM, Jia Hongtao wrote:
>> > > The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), =
It
>> > > causes that neither MSI nor MSI-X can work fine. This is a =
workaround
>> > > to allow MSI-X to function properly.
>> > >
>> > > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
>> > > Signed-off-by: Li Yang <leoli@freescale.com>
>> > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
>> > > ---
>> > >  arch/powerpc/sysdev/fsl_msi.c | 47
>> > > ++++++++++++++++++++++++++++++++++++++++---
>> > >  1 file changed, 44 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/arch/powerpc/sysdev/fsl_msi.c
>> > > b/arch/powerpc/sysdev/fsl_msi.c index 178c994..d2f8040 100644
>> > > --- a/arch/powerpc/sysdev/fsl_msi.c
>> > > +++ b/arch/powerpc/sysdev/fsl_msi.c
>> > > @@ -28,6 +28,8 @@
>> > >  #include "fsl_msi.h"
>> > >  #include "fsl_pci.h"
>> > >
>> > > +#define MSI_HW_ERRATA_ENDIAN 0x00000010
>> It seems Kumar like put this just in fsl_msi.c.
>> Here is the comments from Kumar few days ago:
>> "Is there any reason to put this in fsl_msi.h rather than just in
>> fsl_msi.c itself?"
>> I think the all the #defines should be together.
>> Ether all in .h or all in .c.
>> In this case I prefer your idea.
>=20
> I don't care which file they go in (though .c is probably better if =
they don't need wider visibility), just as long as they're together.
>=20
> -Scott

Agreed, I didn't realize it was with mixed with the FSL_PIC_IP_* =
defines.

So this should be with:

#define FSL_PIC_IP_MASK   0x0000000F
#define FSL_PIC_IP_MPIC   0x00000001
#define FSL_PIC_IP_IPIC   0x00000002
#define FSL_PIC_IP_VMPIC  0x00000003

in fsl_msi.h

- k=

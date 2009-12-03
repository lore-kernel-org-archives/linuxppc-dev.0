Return-Path: <Kashyap.Desai@lsi.com>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B44BFB7C0C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 16:26:52 +1100 (EST)
From: "Desai, Kashyap" <Kashyap.Desai@lsi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Pravin Bathija
	<pbathija@amcc.com>
Date: Thu, 3 Dec 2009 10:56:28 +0530
Subject: RE: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
Message-ID: <0D1E8821739E724A86F4D16902CE275C1C93CDDFE3@inbmail01.lsi.com>
References: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
	<1259809190.2076.1194.camel@pasglop>
In-Reply-To: <1259809190.2076.1194.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "Moore,
	Eric" <Eric.Moore@lsi.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch looks OK. Please consider it as ACKed by me on behalf of LSI.

- Kashyap

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Benjamin Herrenschmidt
> Sent: Thursday, December 03, 2009 8:30 AM
> To: Pravin Bathija
> Cc: linux-scsi@vger.kernel.org; linuxppc-dev@ozlabs.org;
> jwboyer@linux.vnet.ibm.com; Moore, Eric
> Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
> resources.
>=20
> On Wed, 2009-12-02 at 17:51 -0800, Pravin Bathija wrote:
> > Powerpc 44x uses 36 bit real address while the real address defined
> >     in MPT Fusion driver is of type 32 bit. This causes ioremap to fail
> and driver
> >     fails to initialize. This fix changes the data types representing
> the real
> >     address from unsigned long 32-bit types to resource_size_t which is
> 64-bit. The
> >     driver has been tested, the disks get discovered correctly and can
> do IO.
> >
> > Signed-off-by: Pravin Bathija <pbathija@amcc.com>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> James, this one should be good ;-)
>=20
> > Acked-by: Feng Kan <fkan@amcc.com>
> > Acked-by: Fushen Chen <fchen@amcc.com>
> > Acked-by: Loc Ho <lho@amcc.com>
> > Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
> > Acked-by: Victor Gallardo <vgallardo@amcc.com>
> > ---
> >  drivers/message/fusion/mptbase.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/message/fusion/mptbase.c
> b/drivers/message/fusion/mptbase.c
> > index 5d496a9..9f14a60 100644
> > --- a/drivers/message/fusion/mptbase.c
> > +++ b/drivers/message/fusion/mptbase.c
> > @@ -1511,7 +1511,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
> >  {
> >  	u8		__iomem *mem;
> >  	int		 ii;
> > -	unsigned long	 mem_phys;
> > +	resource_size_t	 mem_phys;
> >  	unsigned long	 port;
> >  	u32		 msize;
> >  	u32		 psize;
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

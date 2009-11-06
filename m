Return-Path: <Kashyap.Desai@lsi.com>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23922B7088
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 16:18:30 +1100 (EST)
From: "Desai, Kashyap" <Kashyap.Desai@lsi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley
	<James.Bottomley@suse.de>
Date: Fri, 6 Nov 2009 10:29:04 +0530
Subject: RE: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
Message-ID: <0D1E8821739E724A86F4D16902CE275C1C93C03CD6@inbmail01.lsi.com>
References: <1253053555-25097-1-git-send-email-pbathija@amcc.com>
	<20091105134330.GA30489@zod.rchland.ibm.com>
	<1257437226.2753.64.camel@mulgrave.site>
	<1257451218.13611.114.camel@pasglop>
In-Reply-To: <1257451218.13611.114.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Moore, Eric" <Eric.Moore@lsi.com>, "pbathija@amcc.com" <pbathija@amcc.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel=
.org] On Behalf Of Benjamin Herrenschmidt
Sent: Friday, November 06, 2009 1:30 AM
To: James Bottomley
Cc: Josh Boyer; Moore, Eric; pbathija@amcc.com; linux-scsi@vger.kernel.org;=
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit re=
sources.

On Thu, 2009-11-05 at 10:07 -0600, James Bottomley wrote:

> > > 	ioc->memmap =3D mem;
> > >-	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem =3D %p, mem_phys =3D %=
lx\n",
> > >-	    ioc->name, mem, mem_phys));
> > >+	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem =3D %p, mem_phys =3D %=
llx\n",
> > >+	    ioc->name, mem, (u64)mem_phys));
> > >
> > > 	ioc->mem_phys =3D mem_phys;
> > > 	ioc->chip =3D (SYSIF_REGS __iomem *)mem;
> > >
> > > 	/* Save Port IO values in case we need to do downloadboot */
> > >-	ioc->pio_mem_phys =3D port;
> > >+	port =3D ioremap(port_phys, psize);
> > >+	if (port =3D=3D NULL) {
> > >+		printk(MYIOC_s_ERR_FMT " : ERROR - Unable to map adapter"
> > >+			" port !\n", ioc->name);
> > >+		return -EINVAL;
>=20
> So this looks problematic on a few platforms ... what happens to
> platforms that have no IO space?  They automatically fail here and it
> looks like the adapter never attaches.

Yup, that part of the patch looks wrong.

However, a mechanical replacement of unsigned long's with
resource_size_t to hold physical addresses should be fine despite the
lack of feedback from LSI.

--> I was thinking this was actual fix for the issue. Use of resource_size_=
t is understood. Why submitter has added extra ioremap code in this patch? =
Because of ioremap code only this patch was on hold before going for ACK.
Pravin, Any specific reason to add above code?

Pravin, that ioremap definitely seems like it has nothing to do there,
port IO is already remapped for you by the core PCI code and should work
"as is". Please respin without that change.

Cheers,
Ben.



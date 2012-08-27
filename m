Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 991CA2C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2012 00:49:26 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] rapidio/tsi721: modify mport name assignment
Date: Mon, 27 Aug 2012 14:49:17 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D12E7C2D00@corpmail1.na.ads.idt.com>
References: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
 <20120824140229.20e6a46c.akpm@linux-foundation.org>
In-Reply-To: <20120824140229.20e6a46c.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, August 24, 2012 5:02 PM
Andrew Morton <akpm@linux-foundation.org>
>=20
> On Tue, 21 Aug 2012 10:23:54 -0400
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
>> Modify mport device name assignment to provide clear reference to device=
s
>> in systems with multiple Tsi721 bridges.
>>
>> This patch is applicable to kernel versions starting from v3.2.
>=20
> This seems to imply that you think the patch should be backported into
> earlier kernels.  But no reason for doing this was provided.

We cannot prevent users of earlier versions from using more than one Tsi721
device in their systems. In that case the old name form will not provide
definitive reference to a particular mport. Please, see comment below.

>=20
> > --- a/drivers/rapidio/devices/tsi721.c
> > +++ b/drivers/rapidio/devices/tsi721.c
> > @@ -2165,7 +2165,8 @@ static int __devinit tsi721_setup_mport(struct
> tsi721_device *priv)
> >  	rio_init_dbell_res(&mport->riores[RIO_DOORBELL_RESOURCE], 0,
> 0xffff);
> >  	rio_init_mbox_res(&mport->riores[RIO_INB_MBOX_RESOURCE], 0, 3);
> >  	rio_init_mbox_res(&mport->riores[RIO_OUTB_MBOX_RESOURCE], 0, 3);
> > -	strcpy(mport->name, "Tsi721 mport");
> > +	snprintf(mport->name, RIO_MAX_MPORT_NAME, "%s(%s)",
> > +		 dev_driver_string(&pdev->dev), dev_name(&pdev->dev));
>=20
> And it's a non-back-compatible change to a userspace-visible interface!
> As such we'd need extraordinary justification to merge it into
> *future* kernels, let alone backport it.

An mport device do not provide a userspace-visible interface at this point.
This name is used internally in RapidIO subsystem for resource tracking and
debugging. For Tsi721 as a PCIe peripheral, having the mport name that may =
be
easily associated with its PCIe base helps with tracking of assigned PCIe
resources. This option looks to me better than adding simple indexing
component into existing name format, especially for systems that use add-on
cards with PCIe-to-SRIO bridges.

>=20
> Please, do provide much better changelogging than this.

Modify RapidIO mport device name assignment to include device name of PCIe
side of Tsi721 bridge. The new name format is intended to provide definitiv=
e
reference between RapidIO and PCIe sides of the bridge in systems with
multiple Tsi721 bridges.

Return-Path: <nacc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A5E1B6F89
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 09:34:26 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5FN3eqJ024334
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 19:03:40 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5FNYLmp163282
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 19:34:23 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5FNYK3F025169
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2011 19:34:20 -0400
Date: Wed, 15 Jun 2011 16:34:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: libata/ipr/powerpc: regression between 2.6.39-rc4 and 2.6.39-rc5
Message-ID: <20110615233417.GB6324@us.ibm.com>
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF90FCA.1040706@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, wayneb@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	tj@kernel.org, mbizon@freebox.fr, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.06.2011 [15:02:18 -0500], Brian King wrote:
> On 06/15/2011 02:17 PM, Nishanth Aravamudan wrote:
> > From what I can tell, the only place that explicitly clears the FROZEN
> > flag is the error-handling code via ata_eh_thaw_port().
> > 
> > So I thought either we're not invoking the error-handler at probe time
> > correctly to kick the port or perhaps the SAS code is not clearing the
> > flag?
> > 
> > I tried the following patch:
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index d51f979..abd0e0b 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -3797,6 +3797,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
> >   */
> >  int ata_sas_port_start(struct ata_port *ap)
> >  {
> > +       ap->pflags &= ~ATA_PFLAG_FROZEN;
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(ata_sas_port_start);
> > 
> > and the CD-ROM drive works, but I have no idea if it's the right thing
> > to do. I chose this particular change, FWIW, because we call
> > ata_sas_port_start before we probe in ata_sas_port_init and it seems
> > like we need to mark the port as not frozen before we init it? Perhaps
> > that should really be a call to a thaw function, not sure. Let's just
> > say the ATA/SAS/SCSI interactions are a bit hard to follow at first :)
> 
> That looks like the right thing to do. For ipr's usage of
> libata, we don't have the concept of a port frozen state, so this flag
> should really never get set. The alternate way to fix this would be to
> only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
> is not NULL.

It seemed like ipr is as you say, but I wasn't sure if it was
appropriate to make the change above in the common libata-scis code or
not. I don't want to break some other device on accident.

Also, I tried your suggestion, but I don't think that can happen in
ata_port_alloc? ata_port_alloc is allocated ap itself, and it seems like
ap->ops typically gets set only after ata_port_alloc returns?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

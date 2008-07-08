Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 525DCDDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 03:41:31 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m68HfRvI012319
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 13:41:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68HfRIC155844
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 11:41:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68HfQOf005362
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 11:41:26 -0600
Date: Tue, 8 Jul 2008 12:41:15 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 15/16 v3] ibmvscsi: driver enablement for CMO
Message-ID: <20080708174114.GC21578@linux.vnet.ibm.com>
References: <20080704125631.GR1310@linux.vnet.ibm.com>
	<4872298D.8050802@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4872298D.8050802@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Brian King (brking@linux.vnet.ibm.com) wrote:
> Robert Jennings wrote:
> > @@ -1613,6 +1624,26 @@ static struct scsi_host_template driver_
> >  };
> >  
> >  /**
> > + * ibmvscsi_get_desired_dma - Calculate IO entitlement needed by the driver
> > + *
> > + * @vdev: struct vio_dev for the device whose entitlement is to be returned
> > + *
> > + * Return value:
> > + *	Number of bytes of IO data the driver will need to perform well.
> > + */
> > +static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
> > +{
> > +	/* iu_storage data allocated in initialize_event_pool */
> > +	unsigned long io_entitlement = max_requests * sizeof(union viosrp_iu);
> 
> Since you are removing the use of "entitlement" in the function description,
> you should probably remove it everywhere in this patch.

I'll clean this up.

> > +
> > +	/* add io space for sg data */
> > +	io_entitlement += (IBMVSCSI_MAX_SECTORS_DEFAULT *
> > +	                     IBMVSCSI_CMDS_PER_LUN_DEFAULT);
> > +
> > +	return IOMMU_PAGE_ALIGN(io_entitlement);
> 
> I really think this function should just return the number of bytes and
> let the caller round it up to any boundary requirements it might have.

I agree.  I'll be posting a new patch after a work out another issue I'm
having.  Hope to have that out soon.

--Rob Jennings

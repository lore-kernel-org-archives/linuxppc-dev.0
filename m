Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26B1FDE9AF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:35:01 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67EYwSZ000495
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:34:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67EYwhV196528
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:34:58 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67EYv8j010969
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:34:58 -0400
Message-ID: <4872298D.8050802@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:34:53 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 15/16 v3] ibmvscsi: driver enablement for CMO
References: <20080704125631.GR1310@linux.vnet.ibm.com>
In-Reply-To: <20080704125631.GR1310@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Robert Jennings wrote:
> @@ -1613,6 +1624,26 @@ static struct scsi_host_template driver_
>  };
>  
>  /**
> + * ibmvscsi_get_desired_dma - Calculate IO entitlement needed by the driver
> + *
> + * @vdev: struct vio_dev for the device whose entitlement is to be returned
> + *
> + * Return value:
> + *	Number of bytes of IO data the driver will need to perform well.
> + */
> +static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
> +{
> +	/* iu_storage data allocated in initialize_event_pool */
> +	unsigned long io_entitlement = max_requests * sizeof(union viosrp_iu);

Since you are removing the use of "entitlement" in the function description,
you should probably remove it everywhere in this patch.

> +
> +	/* add io space for sg data */
> +	io_entitlement += (IBMVSCSI_MAX_SECTORS_DEFAULT *
> +	                     IBMVSCSI_CMDS_PER_LUN_DEFAULT);
> +
> +	return IOMMU_PAGE_ALIGN(io_entitlement);

I really think this function should just return the number of bytes and
let the caller round it up to any boundary requirements it might have.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

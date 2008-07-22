Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 351A9DE139
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 23:30:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MDUIZP007138
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:30:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MDUCTx152038
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:30:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MDUBPu001594
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:30:12 -0400
Date: Tue, 22 Jul 2008 08:30:12 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/16 v3] [v2] powerpc: iommu enablement for CMO
Message-ID: <20080722133011.GD5650@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125459.GM1310@linux.vnet.ibm.com>
	<20080708204813.GC20206@linux.vnet.ibm.com>
	<18565.27216.228641.108772@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18565.27216.228641.108772@cargo.ozlabs.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Paul Mackerras (paulus@samba.org) wrote:
> Robert Jennings writes:
> 
> > Minor change to add a call to align the return from the device's
> > get_desired_dma() function with IOMMU_PAGE_ALIGN().  Also removed a
> > comment referring to a non-existent structure member.
> 
> Anyway, my first comment is that the first paragraph of the
> description ("Minor change to ...") is not appropriate for the git
> tree and will have to be edited before the patch is applied.  If the
> extra changes are worth describing, describe them (in stand-alone
> fashion) in the description; otherwise put things like this after the
> line of three dashes, which terminates the description.

I'll correct this with the other changes that need to be made.

> > +static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
> > +                                int nelems, enum dma_data_direction direction)
> 
> This function, and the related unmap_sg, map_single and unmap_single
> functions, now take an extra "struct dma_attrs *attrs" argument since
> Mark Nelson's patch "powerpc/dma: implement new dma_*map*_attrs()
> interfaces" went in (and it's now in Linus' tree).  You need to roll
> something like the patch below in with the 11/16 patch.

I'll repost with updates to add the dma_attrs field.

--Rob

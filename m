Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1872B6FA5
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:26:40 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 01:22:46 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S1QSFr712786
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:26:28 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S1QSci025644
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:26:28 +1100
Date: Tue, 28 Feb 2012 09:26:26 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 14/21] Introduce EEH device
Message-ID: <20120228012626.GD3457@shangw>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
 <20120224235012.63b01e51749cb09bc0195d38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120224235012.63b01e51749cb09bc0195d38@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi Gavin,
> 
> On Fri, 24 Feb 2012 17:38:11 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> >
> > diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
> > index d57c08a..4668344 100644
> > --- a/arch/powerpc/include/asm/device.h
> > +++ b/arch/powerpc/include/asm/device.h
> > @@ -31,6 +31,9 @@ struct dev_archdata {
> >  #ifdef CONFIG_SWIOTLB
> >  	dma_addr_t		max_direct_dma_addr;
> >  #endif
> > +#ifdef CONFIG_EEH
> > +	void			*edev;
> > +#endif
> >  };
> >  
> >  struct pdev_archdata {
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> > index ad8f318..1310971 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > +#define OF_NODE_TO_EEH_DEV(dn)		((struct eeh_dev *)(dn->edev))
> > +#define PCI_DEV_TO_EEH_DEV(pdev)	((struct eeh_dev *)(pdev->dev.archdata.edev))
> 
> If the edev fields of dev_archdata and device_node are always going to be
> "struct eeh_dev *", why not declare then as such and avoid the casting?
> 

Thanks for your comments, Stephen. I'll change it in next revision accordingly.

Thanks,
Gavin

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/

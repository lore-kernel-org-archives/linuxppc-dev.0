Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2C01B6FA4
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:20:07 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 01:17:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S1ESLZ3588250
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:14:28 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S1JrLS007192
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:19:54 +1100
Date: Tue, 28 Feb 2012 09:19:51 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
Message-ID: <20120228011951.GB3457@shangw>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
 <20120225000141.73c0de577597e675a0fb5021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120225000141.73c0de577597e675a0fb5021@canb.auug.org.au>
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
> On Fri, 24 Feb 2012 17:38:17 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> >
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> > index 1310971..226c9a5 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -98,6 +98,21 @@ struct eeh_ops {
> >  	int (*configure_bridge)(struct device_node *dn);
> >  };
> >  
> > +/*
> > + * The struct is used to maintain the EEH global statistic
> > + * information. Besides, the EEH global statistics will be
> > + * exported to user space through procfs
> > + */
> > +struct eeh_stats {
> > +	unsigned long no_device;	/* PCI device not found		*/
> > +	unsigned long no_dn;		/* OF node not found		*/
> > +	unsigned long no_cfg_addr;	/* Config address not found	*/
> > +	unsigned long ignored_check;	/* EEH check skipped		*/
> > +	unsigned long total_mmio_ffs;	/* Total EEH checks		*/
> > +	unsigned long false_positives;	/* Unnecessary EEH checks	*/
> > +	unsigned long slot_resets;	/* PE reset			*/
> > +};
> 
> If this is used in only one place, there is not much point in putting it
> in a header file.
> 

Thanks, Stephen. I'll move it to eeh.c in next revision.

Thanks,
Gavin

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/

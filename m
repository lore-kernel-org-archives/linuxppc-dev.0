Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76EAAB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 12:54:35 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 14 Mar 2012 01:50:10 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2E1mBsc2670660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 12:48:11 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2E1rxJH027511
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 12:53:59 +1100
Date: Wed, 14 Mar 2012 09:53:56 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>, benh@kernel.crashing.org
Subject: Re: linux-next: manual merge of the devicetree tree with the powerpc
 tree
Message-ID: <20120314015356.GA4028@shangw>
References: <20120313160100.c8cc3fd2b3d1f485ef7e7954@canb.auug.org.au>
 <20120313182612.0546D3E053B@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120313182612.0546D3E053B@localhost>
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

> > 
> > Today's linux-next merge of the devicetree tree got a conflict in
> > include/linux/of.h between commit eb740b5f3e65 ("powerpc/eeh: Introduce
> > EEH device") from the powerpc tree and commit 0f22dd395fc4 ("of: Only
> > compile OF_DYNAMIC on PowerPC pseries and iseries") from the devicetree
> > tree.
> > 
> > Just context changes.  I fixed it up (see below) and can carry the fix as
> > necessary.
> > -- 
> > Cheers,
> > Stephen Rothwell                    sfr@canb.auug.org.au
> > 
> > diff --cc include/linux/of.h
> > index bdb1c07,533603e..0000000
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@@ -75,14 -72,10 +75,17 @@@ struct of_phandle_args 
> >   	uint32_t args[MAX_PHANDLE_ARGS];
> >   };
> >   
> >  +#if defined(CONFIG_EEH)
> >  +static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
> >  +{
> >  +	return dn->edev;
> >  +}
> >  +#endif
> 
> Ben, What is this?  I don't want the eeh_dev pointer in struct device_node.  Up to
> now we've avoided putting any reverse references into device_nodes.  For everything
> else we use a reverse lookup, particularly for devices, to avoid growing the
> device_node for each new type of lookup.
> 

It's used to trace the EEH device. When EEH (Enhanced Error Hanlding) is enabled,
EEH device will be created against PCI sensitive OF node to trace the EEH state
accordingly. Since you don't want see this in struct device_node, we have to change
struct eeh_dev for a little bit to so that all struct eeh_dev instances will form
a global list and we can search eeh_dev according to the given device_node through
the global list. 

I don't know the policy or rule here for much. I think we can have 2 options.

1. Keep the code as being, and fix it later.
2. Fix it now.

Thanks,
Gavin

Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF820B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 20:40:24 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 14 Mar 2012 14:35:37 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2E92Cxj3678220
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 14:32:13 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2EEVvtp013016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 20:01:58 +0530
Date: Wed, 14 Mar 2012 17:02:07 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: manual merge of the devicetree tree with the powerpc
 tree
Message-ID: <20120314090207.GA31112@shangw>
References: <20120313160100.c8cc3fd2b3d1f485ef7e7954@canb.auug.org.au>
 <20120313182612.0546D3E053B@localhost>
 <20120314015356.GA4028@shangw> <1331713762.3105.121.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331713762.3105.121.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> >  +#if defined(CONFIG_EEH)
>> > >  +static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
>> > >  +{
>> > >  +  return dn->edev;
>> > >  +}
>> > >  +#endif
>> > 
>> > Ben, What is this?  I don't want the eeh_dev pointer in struct device_node.  Up to
>> > now we've avoided putting any reverse references into device_nodes.  For everything
>> > else we use a reverse lookup, particularly for devices, to avoid growing the
>> > device_node for each new type of lookup.
>> > 
>> 
>> It's used to trace the EEH device. When EEH (Enhanced Error Hanlding) is enabled,
>> EEH device will be created against PCI sensitive OF node to trace the EEH state
>> accordingly. Since you don't want see this in struct device_node, we have to change
>> struct eeh_dev for a little bit to so that all struct eeh_dev instances will form
>> a global list and we can search eeh_dev according to the given device_node through
>> the global list. 
>> 
>> I don't know the policy or rule here for much. I think we can have 2 options.
>> 
>> 1. Keep the code as being, and fix it later.
>> 2. Fix it now. 
>
>My bad, it's a mis-review, I thought it was still in pci_dn, I din't
>catch Gavin moving it to device-node.
>
>Yes, Gavin, we need to do something else, a chained list we walk or
>something like that. For the "fast path" which is when we have a pci_dev
>around, we can either add it to dev_archdata or hijack the pci-dev
>platform_data (I don't think anything uses it, Grant, do you know of
>anything ?)
>

Yes, Ben. I'll come up another patch on top of -next. It's supposed
to introduce global list for newly created eeh_dev and retrieve
the corresponding eeh_dev according to the given device_node through
it.

>The patches are already in -next and I won't rebase, so we need to fix
>it on top of the existing patches. Gavin, can you make a patch that puts
>it back into pci_dn to begin with, then we can contemplate what better
>long term solution we have ?
>

I've had something more in my private git tree regarding this. I'll
talk with you for your comments ;-)

Thanks,
Gavin

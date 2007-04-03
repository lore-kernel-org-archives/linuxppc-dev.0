Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E3E3DDF42
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 01:59:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33FxTxG030992
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:59:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33FxTvq052554
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 09:59:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33FxT3L003020
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 09:59:29 -0600
Date: Tue, 3 Apr 2007 10:59:28 -0500
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/19] PCI: rpaphp: Remove un-needed goto
Message-ID: <20070403155928.GK4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403003746.6E9853A65C@topology.austin.ibm.com>
	<20070403104925.GA14107@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403104925.GA14107@lst.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 12:49:25PM +0200, Christoph Hellwig wrote:
> >  	/* should not try to register the same slot twice */
> >  	if (is_registered(slot)) {
> >  		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
> > -		retval = -EAGAIN;
> > -		goto register_fail;
> > +		return -EAGAIN;
> >  	}	
> >  
> >  	retval = pci_hp_register(php_slot);
> >  	if (retval) {
> >  		err("pci_hp_register failed with error %d\n", retval);
> > -		goto register_fail;
> > +		return retval;
> >  	}
> >  
> >  	/* create "phy_location" file */
> > @@ -182,7 +181,6 @@ int rpaphp_register_slot(struct slot *sl
> >  
> >  sysfs_fail:
> >  	pci_hp_deregister(php_slot);
> > -register_fail:
> >  	return retval;
> >  }
> 
> Using a goto for just returning an error is a common idiom if we
> have other failure cases aswell.

Yes, it is, and I rather like that way of doing things. But in this case 
it didn't seem warranted; I've been trying to take to heart that less
code == better code, without muntzing (ala bob pease) the code.  

--linas

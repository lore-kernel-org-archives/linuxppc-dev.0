Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 610A1DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 20:50:05 +1000 (EST)
Date: Tue, 3 Apr 2007 12:49:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 5/19] PCI: rpaphp: Remove un-needed goto
Message-ID: <20070403104925.GA14107@lst.de>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403003746.6E9853A65C@topology.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403003746.6E9853A65C@topology.austin.ibm.com>
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

>  	/* should not try to register the same slot twice */
>  	if (is_registered(slot)) {
>  		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
> -		retval = -EAGAIN;
> -		goto register_fail;
> +		return -EAGAIN;
>  	}	
>  
>  	retval = pci_hp_register(php_slot);
>  	if (retval) {
>  		err("pci_hp_register failed with error %d\n", retval);
> -		goto register_fail;
> +		return retval;
>  	}
>  
>  	/* create "phy_location" file */
> @@ -182,7 +181,6 @@ int rpaphp_register_slot(struct slot *sl
>  
>  sysfs_fail:
>  	pci_hp_deregister(php_slot);
> -register_fail:
>  	return retval;
>  }

Using a goto for just returning an error is a common idiom if we
have other failure cases aswell.

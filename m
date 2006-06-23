Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BA4967B1D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 01:14:11 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5NFE8WT026036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 11:14:08 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5NFE73e158170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 11:14:08 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5NFE7XC004659
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 11:14:07 -0400
Date: Fri, 23 Jun 2006 10:13:58 -0500
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Extra sanity check in EEH code
Message-ID: <20060623151358.GL8866@austin.ibm.com>
References: <20060620080158.GB30974@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060620080158.GB30974@krispykreme>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


As nominal maintainer of the EEH code, I'll add

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

On Tue, Jun 20, 2006 at 06:01:58PM +1000, Anton Blanchard wrote:
> 
> From: Nathan Lynch <ntl@pobox.com>
> 
> Don't dereference a device node that isn't there.  A "shouldn't
> happen" case, but someone ran into it with a possibly misconfigured
> device tree.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: build/arch/powerpc/platforms/pseries/eeh_cache.c
> ===================================================================
> --- build.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2006-06-08 10:57:36.000000000 +1000
> +++ build/arch/powerpc/platforms/pseries/eeh_cache.c	2006-06-20 12:01:49.000000000 +1000
> @@ -304,6 +304,8 @@ void __init pci_addr_cache_build(void)
>  		pci_addr_cache_insert_device(dev);
>  
>  		dn = pci_device_to_OF_node(dev);
> +		if (!dn)
> +			continue;
>  		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
>  		PCI_DN(dn)->pcidev = dev;
>  	}

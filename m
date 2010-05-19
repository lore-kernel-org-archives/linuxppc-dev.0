Return-Path: <sonny@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B04EB7D64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 18:47:27 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4J8jG3t002201
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 04:45:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4J8l9be169336
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 04:47:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4J8l9cJ032448
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 05:47:09 -0300
Date: Wed, 19 May 2010 03:47:08 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] need check for devices with bad status status property
	in __of_scan_bus()
Message-ID: <20100519084708.GC26215@us.ibm.com>
References: <20100511011341.GO4036@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100511011341.GO4036@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 10, 2010 at 08:13:41PM -0500, Sonny Rao wrote:
> Hi Ben, we ran into an issue where it looks like we're not
> properly ignoring a pci device with a non-good status property
> when we walk the device tree and create our device nodes.
> 
> However, the EEH init code does look for the property and 
> disables EEH on these devices.   This leaves us in an
> inconsistent where we are poking at a supposedly bad
> piece of hardware and RTAS will block our config cycles 
> because EEH isn't enabled anyway.
> 
> This has only been compile tested.
> 
> Signed-of-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> 
> Index: common/arch/powerpc/kernel/pci_of_scan.c
> ===================================================================
> --- common/arch/powerpc/kernel.orig/pci_of_scan.c	2010-05-10 20:00:40.000000000 -0500
> +++ common/arch/powerpc/kernel/pci_of_scan.c	2010-05-10 20:03:04.000000000 -0500
> @@ -310,6 +310,8 @@ static void __devinit __of_scan_bus(stru
>  	/* Scan direct children */
>  	for_each_child_of_node(node, child) {
>  		pr_debug("  * %s\n", child->full_name);
> +		if (!of_device_is_available(child))
> +			continue;
>  		reg = of_get_property(child, "reg", &reglen);
>  		if (reg == NULL || reglen < 20)
>  			continue;


Ok, it's now been actually tested with firmware
that marks some devices as failed and appears to work.


-- 
Sonny Rao, LTC OzLabs, BML team

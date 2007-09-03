Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35B14DDF96
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 11:14:02 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l831E1IA025950
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:14:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l831HXtW168858
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:17:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l832DwJJ002481
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 12:13:58 +1000
Date: Mon, 3 Sep 2007 10:58:20 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 1/6] Fix bus probe on Bamboo board
Message-ID: <20070903005820.GB31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
	<20070831200642.866425000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831200642.866425000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 03:04:50PM -0500, Josh Boyer wrote:
> Commit 804ace8881d21 changed the behavior of how compatible nodes are found.
> This highlighted a bug on the Bamboo board where it wasn't probing the bus
> specified in the DTS file.  We fix it by being explicit about which bus to
> probe.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: David Gibson <david@gibson.dropbvear.id.au>

> 
> ---
>  arch/powerpc/platforms/44x/bamboo.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/powerpc/platforms/44x/bamboo.c
> +++ linux-2.6/arch/powerpc/platforms/44x/bamboo.c
> @@ -23,7 +23,7 @@
>  #include "44x.h"
>  
>  static struct of_device_id bamboo_of_bus[] = {
> -	{ .compatible = "ibm,plb", },
> +	{ .compatible = "ibm,plb4", },
>  	{ .compatible = "ibm,opb", },
>  	{ .compatible = "ibm,ebc", },
>  	{},
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

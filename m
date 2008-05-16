Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08E3BDDEF4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:38:28 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4G1baeh006843
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:37:36 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4G1gVek287610
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:42:31 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4G1cPiF017074
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:38:25 +1000
Date: Fri, 16 May 2008 10:15:29 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Fix PCI mem in rainier DTS
Message-ID: <20080516001529.GB11402@yookeroo.seuss>
References: <20080515094123.44974e84@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080515094123.44974e84@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, 2008 at 09:41:23AM -0500, Josh Boyer wrote:
> This fixes the PCI node in the Rainier to match the spec from AMCC.  A
> similar fix was done for 440EPx, which shares the same values as 440GRx.

This will conflict with the dts-v1 conversion patch.

> --- linux-2.6.orig/arch/powerpc/boot/dts/rainier.dts
> +++ linux-2.6/arch/powerpc/boot/dts/rainier.dts
> @@ -328,8 +328,9 @@
>  			 * later cannot be changed. Chip supports a second
>  			 * IO range but we don't use it for now
>  			 */
> -			ranges = <02000000 0 80000000 1 80000000 0 10000000
> -				01000000 0 00000000 1 e8000000 0 00100000>;
> +			ranges = <02000000 0 80000000 1 80000000 0 40000000
> +				01000000 0 00000000 1 e8000000 0 00010000
> +				01000000 0 00000000 1 e8800000 0 03800000>;
>  
>  			/* Inbound 2GB range starting at 0 */
>  			dma-ranges = <42000000 0 0 0 0 0 80000000>;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

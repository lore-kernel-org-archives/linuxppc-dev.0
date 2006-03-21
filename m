Return-Path: <jdmason@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0ED2267A5A
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 15:28:56 +1100 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L3pUvd002713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 22:51:31 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L3pGfF015984
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 22:51:16 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L3p6OM222536
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 22:51:06 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L3p6ua005507
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 22:51:06 -0500
Date: Mon, 20 Mar 2006 21:54:22 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH 5/7] powerpc numa: Consolidate handling of Power4 special
	case
Message-ID: <20060321035421.GA7714@us.ibm.com>
References: <1142901225978-git-send-email-nathanl@austin.ibm.com>
	<11429013752643-git-send-email-nathanl@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11429013752643-git-send-email-nathanl@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 20, 2006 at 06:36:15PM -0600, Nathan Lynch wrote:
> Code to handle Power4's invalid node id (0xffff) is duplicated for cpu
> and memory.  Better to handle this case in one place --
> of_node_to_nid.  Overall behavior should be unchanged.
> 
> Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> 
> ---
> 
>  arch/powerpc/mm/numa.c |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> d9dd3889e58eeb34d1130d2514fea905ca2cab6a
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index e511ca1..4a6cbb0 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -207,6 +207,11 @@ static int of_node_to_nid(struct device_
>  		    device->full_name);
>  		nid = 0;
>  	}
> +
> +	/* POWER4 LPAR uses 0xffff as invalid node */
> +	if (nid == 0xffff)

A #define for 0xffff would make the code much nicer.  Something like
POWER4_LPAR_INVALID_NODEID could also enable you to remove the above
comment.

Thanks,
Jon

> +		nid = 0;
> +
>  	return nid;
>  }
>  
> @@ -297,14 +302,9 @@ static int __cpuinit numa_setup_cpu(unsi
>  	nid = of_node_to_nid(cpu);
>  
>  	if (nid >= num_online_nodes()) {
> -		/*
> -		 * POWER4 LPAR uses 0xffff as invalid node,
> -		 * dont warn in this case.
> -		 */
> -		if (nid != 0xffff)
> -			printk(KERN_ERR "WARNING: cpu %ld "
> -			       "maps to invalid NUMA node %d\n",
> -			       lcpu, nid);
> +		printk(KERN_ERR "WARNING: cpu %ld "
> +		       "maps to invalid NUMA node %d\n",
> +		       lcpu, nid);
>  		nid = 0;
>  	}
>  out:
> @@ -442,10 +442,9 @@ new_range:
>  		nid = of_node_to_nid(memory);
>  
>  		if (nid >= MAX_NUMNODES) {
> -			if (nid != 0xffff)
> -				printk(KERN_ERR "WARNING: memory at %lx maps "
> -				       "to invalid NUMA node %d\n", start,
> -				       nid);
> +			printk(KERN_ERR "WARNING: memory at %lx maps "
> +			       "to invalid NUMA node %d\n", start,
> +			       nid);
>  			nid = 0;
>  		}
>  
> -- 
> 1.2.4
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

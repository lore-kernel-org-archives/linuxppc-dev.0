Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 121E01A0029
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 00:27:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 2 Sep 2014 23:04:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DCB84C90063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 23:04:13 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8334Mi95636440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Sep 2014 03:04:22 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8334LwI010487
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Sep 2014 23:04:22 -0400
Date: Tue, 2 Sep 2014 20:04:18 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 3/3] powerpc: some changes in numa_setup_cpu()
Message-ID: <20140903030418.GC31420@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1409132041-11890-3-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409132041-11890-3-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.08.2014 [17:34:01 +0800], Li Zhong wrote:
> this patches changes some error handling logics in numa_setup_cpu(),
> when cpu node is not found, so:
> 
> if the cpu is possible, but not present, -1 is kept in numa_cpu_lookup_table,
> so later, if the cpu is added, we could set correct numa information for it.
> 
> if the cpu is present, then we set the first online node to
> numa_cpu_lookup_table instead of 0 ( in case 0 might not be an online node? )

Not currently possible (Node 0 is always online), but I'm working on
changing that :)

> 
> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>

Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 3a9061e..ec32d46 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -538,7 +538,7 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
>   */
>  static int numa_setup_cpu(unsigned long lcpu)
>  {
> -	int nid;
> +	int nid = -1;
>  	struct device_node *cpu;
> 
>  	/*
> @@ -555,19 +555,21 @@ static int numa_setup_cpu(unsigned long lcpu)
> 
>  	if (!cpu) {
>  		WARN_ON(1);
> -		nid = 0;
> -		goto out;
> +		if (cpu_present(lcpu))
> +			goto out_present;
> +		else
> +			goto out;
>  	}
> 
>  	nid = of_node_to_nid_single(cpu);
> 
> +out_present:
>  	if (nid < 0 || !node_online(nid))
>  		nid = first_online_node;
> -out:
> -	map_cpu_to_node(lcpu, nid);
> 
> +	map_cpu_to_node(lcpu, nid);
>  	of_node_put(cpu);
> -
> +out:
>  	return nid;
>  }
> 
> -- 
> 1.9.1
> 

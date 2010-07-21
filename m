Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4D8EB70C2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 06:27:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6LKNvT5000543
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 14:23:57 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6LKRJZW100830
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 14:27:24 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6LKUbu1026646
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 14:30:38 -0600
Message-ID: <4C475827.8040605@linux.vnet.ibm.com>
Date: Wed, 21 Jul 2010 15:27:19 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 7/8] v3 Define memory_block_size_bytes() for ppc/pseries
References: <4C451BF5.50304@austin.ibm.com> <4C451F05.9010502@austin.ibm.com>
In-Reply-To: <4C451F05.9010502@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2010 10:59 PM, Nathan Fontenot wrote:
> 
> +static u32 get_memblock_size(void)
> +{
> +	struct device_node *np;
> +	unsigned int memblock_size = 0;
> +
> +	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (np) {
> +		const unsigned int *size;

This needs to be an unsigned long, otherwise I always get zero on my p6.

> +
> +		size = of_get_property(np, "ibm,lmb-size", NULL);
> +		memblock_size = size ? *size : 0;
> +
> +		of_node_put(np);



-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

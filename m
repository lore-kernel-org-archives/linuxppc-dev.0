Return-Path: <walkinair@cn.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF93167C2F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 03:44:32 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id k9GHs2rV216150
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 03:54:02 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9GHlgVa184598
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 03:47:47 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9GHiG8K021979
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 03:44:16 +1000
Message-ID: <4533C4E9.1040504@cn.ibm.com>
Date: Tue, 17 Oct 2006 01:44:09 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
References: <4532613D.1090107@cn.ibm.com>
	<20061016014334.GA30921@localhost.localdomain>
In-Reply-To: <20061016014334.GA30921@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson 写道:
> On Mon, Oct 16, 2006 at 12:26:37AM +0800, Yao Fei Zhu wrote:
> 
>>Hi, all,
>>
>>Boot kernel 2.6.19-rc2 on IBM System P5 partitions will fall into xmon.
>>Here is the boot log,
> 
> 
> This is probably the same bug I recently posted about.  The patch
> below should fix it.
> 
> ibmveth: Fix index increment calculation
> 
> The recent commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773 introduced
> a bug in the producer/consumer index calculation in the ibmveth driver
> - incautious use of the post-increment ++ operator resulted in an
> increment being immediately reverted.  This patch corrects the logic.
> 
> Without this patch, the driver oopses almost immediately after
> activation on at least some machines.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 
> Index: working-2.6/drivers/net/ibmveth.c
> ===================================================================
> --- working-2.6.orig/drivers/net/ibmveth.c	2006-10-13 14:19:54.000000000 +1000
> +++ working-2.6/drivers/net/ibmveth.c	2006-10-13 14:19:59.000000000 +1000
> @@ -212,8 +212,8 @@ static void ibmveth_replenish_buffer_poo
>  			break;
>  		}
>  
> -		free_index = pool->consumer_index++ % pool->size;
> -		pool->consumer_index = free_index;
> +		free_index = pool->consumer_index;
> +		pool->consumer_index = (pool->consumer_index + 1) % pool->size;
>  		index = pool->free_map[free_index];
>  
>  		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
> @@ -329,8 +329,10 @@ static void ibmveth_remove_buffer_from_p
>  			 adapter->rx_buff_pool[pool].buff_size,
>  			 DMA_FROM_DEVICE);
>  
> -	free_index = adapter->rx_buff_pool[pool].producer_index++ % adapter->rx_buff_pool[pool].size;
> -	adapter->rx_buff_pool[pool].producer_index = free_index;
> +	free_index = adapter->rx_buff_pool[pool].producer_index;
> +	adapter->rx_buff_pool[pool].producer_index
> +		= (adapter->rx_buff_pool[pool].producer_index + 1)
> +		% adapter->rx_buff_pool[pool].size;
>  	adapter->rx_buff_pool[pool].free_map[free_index] = index;
>  
>  	mb();
> 
> 
David, I have verified this fix, it works fine for me, Thanks. What's the status of it? Submitted?

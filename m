Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 78210DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 04:03:06 +1100 (EST)
Message-ID: <45CA0646.3060203@freescale.com>
Date: Wed, 07 Feb 2007 11:03:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <45C86715.6090600@freescale.com>
	<001EB06E-FC1D-4F0A-A910-8E08EE0B8CE2@kernel.crashing.org>
	<45CA01C9.3020309@freescale.com>
	<AC7EDFBD-7282-460F-9D0E-2E3AA9ED7718@kernel.crashing.org>
In-Reply-To: <AC7EDFBD-7282-460F-9D0E-2E3AA9ED7718@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> If its been mapped with ioremap() you know the physical address already 
> so why do you need iopa().  

That's what the original function immrbar_virt_to_phys() does.  We're trying to 
get rid of it, because we thought is redundant with iopa().

static inline unsigned long immrbar_virt_to_phys(volatile void * address)
{
	if ( ((u32)address >= (u32)qe_immr) &&
			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
		return (unsigned long)(address - (u32)qe_immr +
				(u32)get_qe_base());
	return (unsigned long)virt_to_phys(address);
}

get_qe_base() does a search of the OF tree the first time it's called.

Here's the code that calls immrbar_virt_to_phys():

	out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
		 (u32) immrbar_virt_to_phys(ugeth->
					    p_tx_bd_ring[i]));


Would it be better to replace this code with something like this:

out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
	get_qe_base() + ((void *) ugeth->p_tx_bd_ring[i] - (void *) qe_immr));


-- 
Timur Tabi
Linux Kernel Developer @ Freescale

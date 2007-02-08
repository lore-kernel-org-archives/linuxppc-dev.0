Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 85EB5DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:35:13 +1100 (EST)
Message-ID: <45CB270C.5090603@freescale.com>
Date: Thu, 08 Feb 2007 07:35:08 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <989B956029373F45A0B8AF02970818900D4401@zch01exm26.fsl.freescale.net>
	<17A046C6-5FD3-46D5-AB96-EAEDF22FA829@kernel.crashing.org>
In-Reply-To: <17A046C6-5FD3-46D5-AB96-EAEDF22FA829@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Right, so when do you know if you'll be using MURAM or normal memory?  
> Why not just keep around a token that is the physical address at the 
> point you make the decision of MURAM vs normal memory.

That's what the original code did, kinda.  It called virt_to_phys() if 
it is main memory, and it called immrbar_virt_to_phys() if it is MURAM. 
  immrbar_virt_to_phys() did pointer math to extract the physical address.

I knew that Leo's patch was calling iopa() on main memory, but since it 
worked, I didn't think much about it.  But it does make some sense that 
since we obtain the physical address when we allocate the BD ring, we 
should store that address and use it.

That's what most drivers do, anyway, and so we should do the same thing. 
  So instead of p_tx_bd_ring[i], we would have p_tx_bd_ring[i].virtual 
and p_tx_bd_ring[i].physical.

Besides, iopa() is slower, because it walks page tables.

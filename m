Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FAF6DDEC6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:50:03 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D4332@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D4332@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6D988EC5-4F41-45FA-9FBF-2AC5731D9B27@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Wed, 7 Feb 2007 10:36:58 -0600
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: netdev@vger.kernel.org, jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 3:34 AM, Li Yang-r58472 wrote:

>> On Feb 6, 2007, at 5:31 AM, Li Yang wrote:
>>
>>> Get rid of private immrbar_virt_to_phys() routine and
>>> use generic iopa().
>>
>> Nack. iopa() isn't that generic, shouldn't we really be using the dma
>> mapping API here?
>
> Do you mean the dma_map_single()?  dma_map_single can map memory space
> correctly, but I don't think it can handle ioremap-ed space.

What are you mapping?  It looks like buffer descriptor rings.  Are  
they being kept in QE sram?  If so that I think you can treat it as  
memory.  (I believe the SRAM behaves like memory, is cache-coherent,  
etc).

- k

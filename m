Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4579DDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 06:17:30 +1000 (EST)
Message-ID: <49ECD839.3060408@freescale.com>
Date: Mon, 20 Apr 2009 15:16:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc: Add support for swiotlb on 32-bit
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>	<D5619B7C-6B6E-4D89-AB47-A9B1CED24885@kernel.crashing.org>	<6084F3DB-F587-43EC-8753-9E116189A453@kernel.crashing.org>
	<AC7EE6C5-5487-4D70-B690-2F60BE974C92@kernel.crashing.org>
In-Reply-To: <AC7EE6C5-5487-4D70-B690-2F60BE974C92@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I'm suggesting we do it one for FSL in fsl_soc.c, the 4xx guys can do it 
> once, etc.  Since the behavior desired is going to be a bit unique to 
> SoCs/chipsets.

Perhaps we should have a dma_mask in platform/of_platform device 
structs?  The driver knows best how many bits it can shove into a DMA 
address register, and it would let us avoid hardcoding 36 bits into this 
code.

What other platform-specific behavior do you have in mind?  Could we 
supply a default implementation that platforms can override if they need 
something weird, rather than duplicating it per soc family?

-Scott

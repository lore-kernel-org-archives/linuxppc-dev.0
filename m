Return-Path: <Nick.Spence@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51F1DDDEFC
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 17:17:15 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m487H5Hq000977
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 00:17:05 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m487H5We015302
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 02:17:05 -0500 (CDT)
Message-ID: <4822A8F0.1010602@freescale.com>
Date: Thu, 08 May 2008 00:17:04 -0700
From: Nick Spence <nick.spence@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM	non-cached.
References: <1210224392246-git-send-email-nick.spence@freescale.com>	
	<18466.38047.531381.157886@cargo.ozlabs.ibm.com>	
	<9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
	<1210229743.1421.36.camel@pasglop>
In-Reply-To: <1210229743.1421.36.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-05-07 at 23:31 -0700, Spence Nick wrote:
> 
> Then you should completely carve it out of the LMB's which will ensure
> it's not seen as RAM by /dev/mem and not mapped by the linear mapping
> (well, the later depends ... if it's carved out of the top of RAM it
> should work fine, if it's a hole, I'm not sure we handle holes in the
> linear mapping on 32 bits).
> 

Unfortunately the memory window is 4 MBytes into the DDR and not at the 
end. It would be hard to put it at the end because the contents are 
location dependent and we can change the memory size.

The region is reserved with an lmb_reserve().

/* Set the location and size of the shared DDR memory region */
void* shared_mem_base = (void *)0x400000;
long  shared_mem_size = 0x100000;

....
lmb_reserve((unsigned long)shared_mem_base, shared_mem_size);



The page protection seemed to be allocated on a per pte basis, where 
each PTE is a small fixed size. I will need to check the TLB setup further.

Nick

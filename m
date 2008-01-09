Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7166ADDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 06:07:17 +1100 (EST)
Message-ID: <47851990.7020908@freescale.com>
Date: Wed, 09 Jan 2008 12:59:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jay_chen <jay_chen@alphanetworks.com>
Subject: Re: Use 2G RAM in 8548, vmalloc fail, adjust_total_lowmem
References: <OF590B6FCB.576A8335-ON482573CB.00169CC3@alphanetworks.com>
In-Reply-To: <OF590B6FCB.576A8335-ON482573CB.00169CC3@alphanetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

jay_chen wrote:
> Hello, all~~~
> 
> I am using a MCP8548 board with 2.6.14.5 kernel.
> And I would like to upgrade memory from 512MB to 2048MB.
> Finally, I realize this is not so easy as I think. I encounter several
> problems. :~~

Well, it should be easy if you use highmem...

> First, I change mem=512M to mem=2048M.
> 
> 1. vmalloc fail problem

Are you saying you have vmalloc failures if you don't do any of the 
below, and enable highmem, with 2GB RAM?  Could you provide more details?

> So, I change kernel config in "advanced setup"
> Change  "Set maximum low memory" from 0x30000000 to 0x80000000.
> Change "Virtual address of kernel base" from 0xC0000000 to 0x60000000.
> Change "Set custom user task size" from 0x80000000 to 0x60000000
> 
> Someone said that he could change "Virtual address of kernel base" to
> 0xA0000000 without problem.
> Could I change it to 0x60000000? Any possible problem?

There are always *possible* problems. :-)
In theory it should work, but it's not a very well tread path.

> In adjust_total_lowmem(), fsl_booke_mmu.c 
> It always limits the low memory to 768MB.  (no matter we set mem=768MB or
> mem=1024MB, or mem=2048MB) 
> __max_low_memory = max_low_mem = __cam0 + __cam1 + __cam2; (each TLB could
> map up to 256MB)
> 
> My question is could I use more than 3 TLBs here? Such as 8 TLBs to map 2G
> ram?

Yes.

> Or could I use e500v2 new feature, that is 1 TLB could map up to 4G?

Yes.

-Scott

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31F48679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 18:14:32 +1100 (EST)
In-Reply-To: <200602241040.54060.michael@ellerman.id.au>
References: <Pine.LNX.4.44.0602231658210.16092-100000@gate.crashing.org>
	<1140736753.8264.55.camel@localhost.localdomain>
	<200602241040.54060.michael@ellerman.id.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CFD34C71-E417-4C9F-A5A1-94B50775B7A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: parsing of some early cmdline options
Date: Fri, 24 Feb 2006 01:14:41 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 23, 2006, at 5:40 PM, Michael Ellerman wrote:

> On Fri, 24 Feb 2006 10:19, Benjamin Herrenschmidt wrote:
>> On Thu, 2006-02-23 at 17:02 -0600, Kumar Gala wrote:
>>> Guys,
>>>
>>> I noticed that we have code in arch/powerpc/kernel/prom_init.c to  
>>> handle
>>> parsing iommu=, mem=, and crashkernel=.
>>>
>>> The problem I have is that we only use/build prom_init.c on  
>>> MULTIPLATFORM
>>> (coming from true OF).
>
>>> Any ideas on how to handle this for the !MULTIPLATFORM cases.   
>>> I'm most
>>> concerned about mem=.
>
> mem= is a bit tricky because you need to know about it really  
> early, otherwise
> your bootloader might violate the limit. But we could certainly  
> check for it
> again in prom.c. And you can always just set /chosen/linux,memory- 
> limit.

Agreed, I'm looking at adding "early" cmd_line parsing in  
early_init_dt_scan_chosen().  I assume we agree that mem= on command  
line overrides "linux,memory-limit".  I guessing that "linux,memory- 
limit" is only ever created in prom_init.c which would be from a mem=  
parsing.

- k

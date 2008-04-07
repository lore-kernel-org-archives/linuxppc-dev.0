Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E083DDE32
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 23:00:42 +1000 (EST)
Message-Id: <D3342AF7-695E-4AA2-9E8A-A1A13E5DEAA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18425.47270.756180.55444@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Update linker script to properly set physical
	addresses
Date: Mon, 7 Apr 2008 08:00:35 -0500
References: <Pine.LNX.4.64.0804030128170.15263@blarg.am.freescale.net>
	<18425.47270.756180.55444@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2008, at 1:01 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> We can set LOAD_OFFSET and use the AT attribute on sections and the
>> linker will properly set the physical address of the LOAD program
>> header for us.
>
> Nice...
>
>> #define KERNELBASE      ASM_CONST(CONFIG_KERNEL_START)
>> #define PAGE_OFFSET	ASM_CONST(CONFIG_PAGE_OFFSET)
>> +#define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START- 
>> CONFIG_PHYSICAL_START))
>
> I think this should be CONFIG_PAGE_OFFSET - CONFIG_PHYSICAL_START
> though.

Disagree (assuming I'm thinking straight first thing in the morning).

PAGE_OFFSET is virt address of the beginning of memory, where  
KERNEL_START is virt address of start of kernel text.
PHYSICAL_START is physical address of KERNEL_START.

(I tried to match x86's definitions here as per Milton's request to be  
consistent).

- k

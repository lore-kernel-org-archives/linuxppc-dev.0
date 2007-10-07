Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDCDDDDEE7
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 01:01:57 +1000 (EST)
In-Reply-To: <18184.23379.478676.911097@cargo.ozlabs.ibm.com>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
	<18184.23379.478676.911097@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <796C20BF-1592-4F07-B83B-5EA35CADBA01@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: TASK_SIZE default 0x80000000 ?
Date: Sun, 7 Oct 2007 10:02:04 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2007, at 11:06 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> In a discussion with Hollis over beer he raised the question why
>> TASK_SIZE is 0x80000000 on ppc32.
>>
>> I was wondering if anyone know why this was still the case?  Seems
>> like we have a 1Gb whole between TASK_SIZE & KERNELBASE.
>
> Two reasons: (a) PReP used to map PCI stuff with BATs in the
> 0x80000000 - 0xbfffffff region, and (b) some embedded ports with
> software-loaded TLBs test just the high bit of the address to
> determine whether to use the kernel or user page tables.

Can you explain (a) further -- I'm assuming the BAT mapping is 1:1  
for that region?

For (b) it looks like:
* 40x, 44x, fsl-booke compare against TASK_SIZE in their software  
handlers.
* 8xx still tests 0x80000000
* 6xx (603) compares against KERNELBASE

It would seem like we should set the default on 8xx & PReP to  
0x80000000 and not allow it to be modified since that will break the  
world and for everything else move it to match KERNELBASE.  Any  
issues with that?

- k

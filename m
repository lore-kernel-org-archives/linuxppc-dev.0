Return-Path: <chris@alcor.co.uk>
Received: from merak.alcor.co.uk (alcor.demon.co.uk [62.49.62.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D6C768819
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 22:33:50 +1100 (EST)
From: "Chris Down" <chris@alcor.co.uk>
To: "'Joakim Tjernlund'" <joakim.tjernlund@transmode.se>,
	<linuxppc-embedded@ozlabs.org>
Date: Mon, 28 Nov 2005 11:33:44 -0000
Message-ID: <003a01c5f40f$971ceff0$0101a8c0@sirius>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9393FE1C7@tmnt04.transmode.se>
Subject: RE: Badness in 2.6.15-rc1 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


-----Original Message-----
From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se] 
Sent: 28 November 2005 10:53
To: Chris Down; linuxppc-embedded@ozlabs.org
Subject: RE: Badness in 2.6.15-rc1 on 8xx
 

> Anyone seen this when booting 2.6.15-rc1 on 8xx?
>   Mount-cache hash table entries: 512
>   Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346
>   Call trace:
>    [c00039e8] check_bug_trap+0x80/0xa8
>    [c0003c1c] program_check_exception+0x20c/0x480
>    [c00031e0] ret_from_except_full+0x0/0x4c
>    [c01b86b8] dma_alloc_init+0x40/0xcc
>    [c000225c] init+0x8c/0x288
>    [c00050ac] kernel_thread+0x44/0x60
>   NET: Registered protocol family 16
> The kernel boots just fine into user space so it seems harmless, but I
> suspect it will bite me later.
> 
> 
> I am currently working with 2.6.15-rc1 on MPC852 and I am 
> seeing a similar
> problem.
> 
> Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346
> Call trace:
>  [c00036f8] check_bug_trap+0xa4/0xb8
>  [c0003f9c] program_check_exception+0x2f0/0x4c4
>  [c0003320] ret_from_except_full+0x0/0x4c
>  [c024c530] dma_alloc_init+0x3c/0xbc
>  [c0002280] init+0xbc/0x25c
>  [c000538c] kernel_thread+0x44/0x60
> 
> Have not had time to look at it yet, however I was not getting this on
> 2.6.11.
> 
> Chris

Let me guess you have IMAP_ADDR set to 0xff000000? Then you need to
change
CONSISTENT_START to something else(like 0xffa00000). Its somwhere in the
Advanced setup.

 Jocke
 
You are correct I do have IMAP_ADDR set to 0xff000000 and setting
CONSISTENT_START to 0xffa00000 solves the problem. 

Chris

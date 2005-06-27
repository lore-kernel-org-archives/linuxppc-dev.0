Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C26B867B5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:18:27 +1000 (EST)
In-Reply-To: <20050627142803.GA9810@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050627142803.GA9810@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <014331894c585b85c6bb419d72110125@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 27 Jun 2005 16:18:14 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: tlbie debugging aid (try #2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 27, 2005, at 10:28 AM, Marcelo Tosatti wrote:

> it yields
>
> _tlbie on pinned range: c0000000-c1800000
> Badness in _tlbie at arch/ppc/mm/pgtable.c:527
> Call trace:
>  [c0005530] dump_stack+0x18/0x28
>  [c0003628] check_bug_trap+0x84/0xac
>  [c00037b0] ProgramCheckException+0x160/0x1a0
>  [c0002d50] ret_from_except_full+0x0/0x4c
>  [c000a91c] _tlbie+0x94/0xa0
>  [c902f018] alloc_init_module+0x18/0x40 [alloc]
>  [c002c4ac] sys_init_module+0x224/0x324
>  [c00026f0] ret_from_syscall+0x0/0x44

How much real memory on your board?
We need to ensure VMALLOC_START is beyond
the pinned entries.  We should make all of the code
much smarter to pin on the real space that is on
the board.  For testing now, just make VMALLOC_OFFSET
32M, which will push the start to the 32M boundary
after the kernel.

Thanks.


	-- Dan

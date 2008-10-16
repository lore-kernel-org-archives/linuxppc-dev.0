Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED3B6DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 13:23:30 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] Support for big page sizes on 44x (Updated)
Date: Thu, 16 Oct 2008 06:22:30 +0400
Message-Id: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
Cc: yanok@emcraft.com, dzu@denx.de, pvr@emcraft.com, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches add support for selecting page size on PPC 44x.
First one adds support for 16K/64K pages while second one adds support
for 256K pages along with some hacks.

However there are still number of problems:
1. We can't use default PKMAP_BASE definition with 64KB/256KB pages so
we change it. Not sure that it's optimal. Then redefined PKMAP_BASE is
not aligned on (1<<PMD_SHIFT), don't know if it is really bad.
2. with 16KB/64KB/256KB pages WARN_ON(!pmd_none(*pmd)) is triggered
inside dma_alloc_init() function. Not sure if it is really bad.
3. with 256KB pages ENTRIES_PER_PAGEPAGE in mm/shem.c become zero.
4. We use asm-offsets mechanism to make PTE_SHIFT/PMD_SHIFT available in
assembler but we don't really need the power of asm-offsets here. Maybe
it will be more convinient to just take these defines out of #ifndef
__ASSEMBLY__? But this would change asm-generic...

We would appreciate any comment.

Regards, Ilya.

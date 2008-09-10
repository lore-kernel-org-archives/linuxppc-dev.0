Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16EA8DDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:53:50 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] Support for big page sizes on 44x
Date: Thu, 11 Sep 2008 01:53:05 +0400
Message-Id: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
Cc: dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for selecting page size on PPC 44x.

However there are still number of problems:
1. We can't use default PKMAP_BASE definition with 64KB/256KB pages so we
change it. Not sure that it's optimal. Then redefined PKMAP_BASE is not
aligned on (1<<PMD_SHIFT), don't know if it is really bad.
2. with 16KB/64KB/256KB pages WARN_ON(!pmd_none(*pmd)) is triggered inside
dma_alloc_init() function. Not sure if it is really bad.
3. with 256KB pages ENTRIES_PER_PAGEPAGE in mm/shem.c become zero.
Second patch tries to address this issue.
4. Ugly ppc_page_asm.h file. I'd prefer to see these defines calculated
instead of being hardcoded but PTE_SHIFT and PMD_SHIFT are declared
inside #ifndef __ASSEMBLY__. Don't know why.

We would appreciate any comment.

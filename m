Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35060DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 13:18:03 +1100 (EST)
Subject: Re: [RFC PATCH] Support for big page sizes on 44x (Updated)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 13:17:48 +1100
Message-Id: <1226369868.7530.60.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 06:22 +0400, Ilya Yanok wrote:
> These patches add support for selecting page size on PPC 44x.
> First one adds support for 16K/64K pages while second one adds support
> for 256K pages along with some hacks.
> 
> However there are still number of problems:
> 1. We can't use default PKMAP_BASE definition with 64KB/256KB pages so
> we change it. Not sure that it's optimal. Then redefined PKMAP_BASE is
> not aligned on (1<<PMD_SHIFT), don't know if it is really bad.

Well, the main thing is the implementation of kmap and kmap_atomic.

They both basically assumes that all the reserved PTEs for kmap and
kmap_atomic are in a single PTE page since it uses a simple addition
(substraction for _atomic really but heh, that's about the same).

Note that PKMAP (kmap) and FIXMAP (kmap_atomic) can be in two different
PTE pages. But it's important that the whole PKMAP is entirely contained
within a PTE page. It doesn't have to -start- on a PTE page boundary
though. 

> 2. with 16KB/64KB/256KB pages WARN_ON(!pmd_none(*pmd)) is triggered
> inside dma_alloc_init() function. Not sure if it is really bad.

I think that's a bogus WARN_ON.

> 3. with 256KB pages ENTRIES_PER_PAGEPAGE in mm/shem.c become zero.

Yeah well, I'd like to keep that 256K page separate for now, let's focus
on merging 16K/64K support first.

> 4. We use asm-offsets mechanism to make PTE_SHIFT/PMD_SHIFT available in
> assembler but we don't really need the power of asm-offsets here. Maybe
> it will be more convinient to just take these defines out of #ifndef
> __ASSEMBLY__? But this would change asm-generic...

We sure should do that. I don't think of a reason why those need to
be protected by __ASSEMBLY__.

Cheers,
Ben.

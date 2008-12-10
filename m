Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57218DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 06:58:40 +1100 (EST)
Subject: Re: Re[2]: [PATCH] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <1251410626.20081210142142@emcraft.com>
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
	<1228858740.22413.28.camel@pasglop>
	<1251410626.20081210142142@emcraft.com>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 06:58:21 +1100
Message-Id: <1228939101.22413.69.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Vladimir Panfilov <pvr@emcraft.com>, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-10 at 14:21 +0300, Yuri Tikhonov wrote:
> 
> > I'm not sure about the above & PMD_MASK. Shouldn't we instead make it
> > not build if (PKMAP_BASE & PMD_MASK) != 0 ? 
> 
>  We separated the !4K_PAGES case here exactly because  (PKMAP_BASE & 
> PMD_MASK) != 0 [see the comment to this chunk - why]. So, this'll turn 
> out to be broken if we follow your suggestion. Are there any reasons 
> why we should have PKMAP_BASE aligned on the PMD_SIZE boundary ?

No, you are right, so why do we need the & PMD_MASK in the 4k case ?

What I don't get is why do we need a different formula for 4k and 64k
but I might just be stupid :-)

>  These definitions seem to be related to the page table, so, as for me, 
> then pgtable.h is the better place for them. Though, as you want; 
> we'll move this to page_32.h.

Well, I like having them next to the pte_t/pgd_t definitions since they
relate directly to the size of those structures.

Cheers,
Ben.

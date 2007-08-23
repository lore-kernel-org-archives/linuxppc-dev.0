Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2043DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 03:58:31 +1000 (EST)
In-Reply-To: <20070823173314.GA18412@ld0162-tx32.am.freescale.net>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<20070823024757.GC7042@localhost.localdomain>
	<20070823173314.GA18412@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <924BAE00-7BB4-4BE8-8DF6-52B7807EFE2C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Thu, 23 Aug 2007 13:00:24 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2007, at 12:33 PM, Scott Wood wrote:

> On Thu, Aug 23, 2007 at 12:47:57PM +1000, David Gibson wrote:
>>> ./drivers/mtd/maps/tqm834x.c:#include <asm/ppcboot.h>
>>> ./drivers/mtd/maps/pq2fads.c:#include <asm/ppcboot.h>
>>
>> Although these both have an extern of type bd_t (defined in
>> ppcboot.h), afaict they don't actually use it, so these should be
>> removable.
>
> They look like they're using it to me...  See the bd->bi_flashstart  
> and
> bd->bi_flashsize references in init_pq2fads_mtd.

Both of these are dead in one way or another.  pq2fads.c isn't in the  
makefile and you can't Kconfig tqm834x.c into existence.  Thus my  
patch to remove them.

- k

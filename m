Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE012.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8217B6F72
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 06:26:06 +1000 (EST)
Date: Tue, 14 Jun 2011 15:26:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
Message-ID: <20110614152601.6258d3a6@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jun 2011 10:56:31 +0200
Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com> wrote:

> * Therefore, to make sure that the mapping I intended with __ioremap()
> is actually reflected in the TLB tables, I added dummy reads of each
> page in the TLB, prior to jumping to the boot code, as follows:
>                 /* make sure memory is read, once every 4Kbyte is enough */
>                 for (p = vaddr; p < vaddr + map_size; p += 0x1000) {
>                         unsigned long dummy = *(volatile unsigned long *)p;
>                         (void)dummy;
>                 }
> 
> * After these changes (make sure all code is mapped + make sure to
> read all pages so that the TLBs are updated), my scenario works fine.

This is fragile -- you are assuming that it's possible to fit this
set of pages in TLB0 all at once, and that none of them will be
evicted/invalidated by the time you're done.

If you really need to do this, I sugest using settlbcam() from
arch/powerpc/mm/fsl_booke_mmu.c to create TLB1 entries with IPROT set.

Better still if you could live with whatever memory the kernel has already
pinned.

-Scott

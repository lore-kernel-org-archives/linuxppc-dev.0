Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 7A0F62BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 16:34:12 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8L6YJK3006895
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 09:34:20 +0300 (EEST)
Message-ID: <414FC633.3090707@intracom.gr>
Date: Tue, 21 Sep 2004 09:12:03 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Song Sam <samlinuxppc@yahoo.com.cn>
References: <20040921013859.86944.qmail@web15608.mail.cnb.yahoo.com>
In-Reply-To: <20040921013859.86944.qmail@web15608.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Song Sam wrote:

>  Tom Rini <trini@kernel.crashing.org> wrote：
>
> > Note that the old SCC enet driver, in linuxppc-2.5 at least is
> > 'OK'. Not that it couldn't do with a cleanup and netdev person
> > audit, but it's functional enough for me and my rpxlite to mount a
> > root fs.
> >
> > -- Tom Rini http://gate.crashing.org/~trini/
>
>
>  Uh, I tried it again on lastest bk pull but still in vain. What's the
>  problem could be?
>
Well it works OK until it gets to start init.

Then it crashes the way it is supposed to :).

Tom I think it's the problem we are talking about.

Song please try this...

Song Sam wrote:

>  Tom Rini <trini@kernel.crashing.org> wrote：
>
> > Note that the old SCC enet driver, in linuxppc-2.5 at least is
> > 'OK'. Not that it couldn't do with a cleanup and netdev person
> > audit, but it's functional enough for me and my rpxlite to mount a
> > root fs.
> >
> > -- Tom Rini http://gate.crashing.org/~trini/
>
>
>  Uh, I tried it again on lastest bk pull but still in vain. What's the
>  problem could be?
>
Well it works OK until it gets to start init.

Then it crashes the way it is supposed to :).

Tom I think it's the problem we are talking about.

Song please try this...

Regards

Pantelis

--- linuxppc_2.5/arch/ppc/mm/init.c 2004-08-26 10:21:00.000000000 +0300
+++ linuxppc_2.5-intracom/arch/ppc/mm/init.c 2004-08-26 
10:34:00.000000000 +0300
@@ -632,9 +632,10 @@
struct page *page = pfn_to_page(pfn);
if (!PageReserved(page)
&& !test_bit(PG_arch_1, &page->flags)) {
- if (vma->vm_mm == current->active_mm)
- __flush_dcache_icache((void *) address);
- else
+ if (vma->vm_mm == current->active_mm) {
+ _tlbie(address);
+ __flush_dcache_icache((void *)address);
+ } else
flush_dcache_icache_page(page);
set_bit(PG_arch_1, &page->flags);
}

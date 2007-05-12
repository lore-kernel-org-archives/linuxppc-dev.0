Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24893DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 19:17:51 +1000 (EST)
Date: Sat, 12 May 2007 11:15:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Using kprobes [was Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070512091559.GA23204@lst.de>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508123214.11b4f25c.akpm@linux-foundation.org>
	<4642FDD6.5090609@ru.mvista.com>
	<20070510111242.dd42adae.akpm@linux-foundation.org>
	<20070511172304.GI4452@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070511172304.GI4452@austin.ibm.com>
Cc: wli@holomorphy.com, dada1@cosmosbay.com, linuxppc-dev@ozlabs.org,
	pavel@ucw.cz, Maxim Uvarov <muvarov@ru.mvista.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 12:23:04PM -0500, Linas Vepstas wrote:
> On Thu, May 10, 2007 at 11:12:42AM -0700, Andrew Morton wrote:
> > 
> > I don't think the syscall-counting feature has a future, sorry.  Perhaps
> > you could do something like hooking it up on-demand by insertion of a kprobe,
> > dunno.
> 
> This is an interesting point. I've started fiddling with (a wrapper
> around) kprobes that allows me to pick any subroutine symbol in System.map,
> and then get an event whenever that subroutine gets called. Its pretty
> slick, and allows me to gather data on certain unusual events in the
> kernel.  (I'm not using this for performance monitoring, I'm trying to 
> do RAS).
> 
> It makes a lot of sense to me to have a generic kprobe extension, where 
> you could give it a list of subroutine names, and it'll collect stats
> on the number of times that the routine was called. Some user-space thingy
> could poll for those stats, or you could put them in /sys or wherever.
> 
> Its more complicted than just instriumenting syscalls, but a lot more
> useful, I would think ... 

Yes, this is exactly the useful kind of kprobes useage we should have in
the tree.  

> 
> --linas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
---end quoted text---

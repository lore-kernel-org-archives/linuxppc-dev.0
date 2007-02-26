Return-Path: <johnstul@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B72DDDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 06:27:56 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1QJSYDm032267
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:28:34 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1QJRon4288732
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:27:50 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1QJRn1O023626
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:27:50 -0500
Subject: Re: Make sure we populate the initroot filesystem late enough
From: john stultz <johnstul@us.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1172448057.3971.9.camel@shinybook.infradead.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 11:27:47 -0800
Message-Id: <1172518068.15970.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-02-25 at 19:00 -0500, David Woodhouse wrote:
> On Mon, 2006-12-11 at 20:59 +0000, Linux Kernel Mailing List wrote:
> > 
> >     Make sure we populate the initroot filesystem late enough
>
> This seems to be what's triggering the apparent memory corruption we've
> been seeing recently -- in the case of the Fedora kernel it manifests
> itself as a BUG() in cache_alloc_refill() when the pmac ide driver
> initialises.
> 
> Another report was at http://lkml.org/lkml/2006/12/17/4
> 
> We've been seeing it on a Mac Mini too, and I managed to reproduce it on
> my shinybook this evening by booting with 'mem=512M'.

Just for reference (as its not in the thread linked above), this issue
disappeared for me after some config changes (I somehow changed my
selection when I backtracked and then moved forward w/ git bisect).

I've not been able to reproduce it since, but I know others (BCC'ed on
this note) have seen it and might prod them to come forth with details
(and broken .config files)

thanks
-john

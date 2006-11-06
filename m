Return-Path: <SRS0+fe8b001394e641f94d96+1170+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A18767C50
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 12:18:31 +1100 (EST)
Subject: Re: ppc32 PIO recovery mecanism
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1162773695.28571.260.camel@localhost.localdomain>
References: <1162773695.28571.260.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 09:18:35 +0800
Message-Id: <1162775915.3415.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 11:41 +1100, Benjamin Herrenschmidt wrote:
> On 32 bits powerpc, we currently have a mechanism where we try to
> recover from machine checks happening on PIO operations (inb/outb/....).
> This mecanisms has proven of dubious reliability in the past and it's my
> understanding that we've pretty fixed all relevant legacy drivers that
> distro typically load so that they don't muck around when they
> shouldn't.
> 
> I'm currently merging 32 and 64 bits io.h and I would really like to
> just get rid of that stuff, but I'd like your distro point of view
> first. Is this mechanism still useful at all or not ?

Yes, I think it's still useful because there are some drivers which
aren't update to use check_legacy_ioport() (or whatever other system)
yet.

Not many, mind you -- but I'd like to be 100% sure before we drop it.
Let's start by making it print with KERN_CRIT instead of KERN_DEBUG?

-- 
dwmw2

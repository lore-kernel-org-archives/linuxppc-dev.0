Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 842C02C0128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:39:28 +1000 (EST)
Message-ID: <1378917555.12204.385.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH v2 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Sep 2013 11:39:15 -0500
In-Reply-To: <1378862123.3783.5.camel@pasglop>
References: <20130905055122.F256EE07B6@canberra.localdomain>
 <1378856847.12204.380.camel@snotra.buserror.net>
 <1378862123.3783.5.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Stephen Chivers <schivers@csc.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, cproctor@csc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 11:15 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-09-10 at 18:47 -0500, Scott Wood wrote:
> 
> > No blank line before }
> > 
> > > +CONFIG_CMDLINE_BOOL=y
> > > +CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
> > 
> > I take it there's no way to pass a command line in from whatever loader
> > this board uses... but you could put it in the dts instead.
> 
> No, please don't put that in the device-tree. Somebody might want
> different settings, this is typically what .config is for.

I figured that in the defconfig it presents a barrier to getting rid of
the board-specific defconfig, while the dts is still going to be
per-board.  In this case the device tree is not baked into firmware so
it's just as easy to change things in /chosen as in .config (actually
slightly easier since you only need to rewrap the kernel rather than
rebuild).

-Scott

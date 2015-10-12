Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCC8D1A0679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 21:30:27 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
Date: Mon, 12 Oct 2015 12:30:18 +0200
Message-ID: <7516455.YEROTAngT1@wuerfel>
In-Reply-To: <1444644025.31951.1.camel@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <7826129.RXlL8kStvO@wuerfel> <1444644025.31951.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 12 October 2015 21:00:25 Michael Ellerman wrote:
> On Thu, 2015-10-08 at 23:30 +0200, Arnd Bergmann wrote:
> > On Friday 09 October 2015 08:09:12 Michael Ellerman wrote:
> > > Currently the NR_IRQS option sits at the top level, which is ugly in
> > > menuconfig. It's not something users will commonly need to worry about
> > > so move it into "Kernel Options".
> > 
> > Is this option actually still meaningful at all, when you select CONFIG_SPARSE_IRQ
> > unconditionally?
> 
> It's still used for #define NR_IRQS, which is still used by the generic irq
> code and also some drivers.

Drivers shouldn't use it, and I don't see any driver using it that can be
enabled on powerpc.

The question is rather whether you have any devices on powerpc that
get a hardwired IRQ number from a statically defined platform device
rather from DT.

If there are any ISA devices, the driver might try to use an interrupt
number that is hardcoded in the driver as a number from 0 to 15.
I guess that could happen on old CHRP or 6xx machines.

> So we need some value for that, whether it needs to be user defined or if we
> could just pick a value I'm not sure. x86 seem to just define it based on
> NR_CPUs and some other factors.

What happens if you set it to 16?

	Arnd

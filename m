Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 1D4AFDDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 10:03:46 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: make ioport_map() handle already mapped ranges
Date: Sun, 13 May 2007 01:55:41 +0200
References: <20070512143221.GB12890@lixom.net>
	<200705130018.42612.arnd@arndb.de>
	<20070512223623.GA16045@lixom.net>
In-Reply-To: <20070512223623.GA16045@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130155.42414.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 13 May 2007, Olof Johansson wrote:
> > We have a bug on cell that would be fixed with this patch, so it
> > might be the same problem, see the patch that I suggested for
> > this at http://patchwork.ozlabs.org/linuxppc/patch?id=10840 .
> 
> Not in this case, but thanks for the pointer. Your case is still based
> on the fact that you only have one io space range, you're just making
> sure you're allocating out of that range. In my case, I have two distinct
> ranges, they're even on different busses...

There is a global io space range for all buses, which is maintained
by the reserve_phb_iospace() call. You should get your I/O ports in there
if you want them to just work. Note that while the reserve_phb_iospace() 
logic works in practice, it does have a few shortcomings that should
eventually be resolved:

* There is no way to free these ranges, so you can't use this mechanism
to allocate space for hotpluggable buses, or you might run out of
space eventually

* there is no locking around the use of reserve_phb_iospace().

* Buses that are already hotplugged get an io port range above the
range maintained by reserve_phb_iospace(), but that may be larger
than 4GB, so that I/O port numbers allocated on thoses buses require
64 bit integers to store them.

* If you have registered primary PCI bus, the whole logic breaks down
and you always need 64 bit integers to store I/O port numbers, at best.

* Worse things happen if you try to use pci_iomap, which checks
PIO_MASK. This mask is currently defined for 30 bit addresses, while
the range managed by reserve_phb_iospace() is already 31 bits, not
to mention ports outside of that range.

* If you call reserve_phb_iospace() for a secondary bus before
 setting pci_io_base to the primary bus, you actually get negative
I/O port numbers, and you crash when using a 32  bit number to store
it.
	Arnd <><

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0B92B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 19:54:54 +1100 (EST)
Message-ID: <1330419272.11728.27.camel@pasglop>
Subject: Re: [PATCH 08/18] PCI, powerpc: Register busn_res for root buses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 Feb 2012 19:54:32 +1100
In-Reply-To: <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
 <1330395009-29260-9-git-send-email-yinghai@kernel.org>
 <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-02-27 at 22:36 -0700, Bjorn Helgaas wrote:
> 
> There's a lot of powerpc code that does this:
> 
>     bus_range = of_get_property(pcictrl, "bus-range", &len);
>     hose->first_busno = bus_range[0];
>     hose->last_busno = bus_range[1];
> 
> That *looks* like it is discovering the bus number aperture.  Is it?
> If it is, why are we using the largest bus number found by
> pci_scan_child_bus() rather than "last_busno"?

We do that but we somewhat -also- rely on the core bumping it if it
needs to make room :-)

As I said, we are swimming in dirty waters between reverse engineered
stuff we don't know 100% and "designed" stuff.

I think we should have ways to more explicitely define what we want tho,
ie whether hose->last_busno is just what happens to be the "current" bus
number assigned by the firmware or the hard max. Maybe a pci flag ?

On the other hand some platforms (all the ppc4xx ones for example) set
the flag to reassign all busses ... but have limit on bus numbers simply
because they have a memory mapped only config space and we don't have
enough address space to ioremap it all on 32-bit.

We need to fix them to use a fixmap entry to do atomic on-demand mapping
of the config space and lift that restriction, but that isn't done yet.

So I think those patches will need really careful handling on our side.

Cheers,
Ben.

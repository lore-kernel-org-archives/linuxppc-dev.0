Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B59AF2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 18:41:23 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23159-10 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 24 Jul 2013 09:41:16 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: Inbound PCI and Memory Corruption
Date: Wed, 24 Jul 2013 09:40:50 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72E5@saturn3.aculab.com>
In-Reply-To: <CAN8Q1EeRWOD1ktGztsaY91VwDYTJmAgwo6XR2baQNb_f7p=FLA@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
 <20130719134615.GR7080@book.gsilab.sittig.org>
 <CAN8Q1EeRWOD1ktGztsaY91VwDYTJmAgwo6XR2baQNb_f7p=FLA@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Peter LaDow" <petela@gocougs.wsu.edu>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, Jul 19, 2013 at 6:46 AM, Gerhard Sittig <gsi@denx.de> wrote:
> > So:  No, not having to fiddle with DMA stuff when doing PCI need
> > not be a problem, it's actually expected.  But since a DMA engine
> > might be involved (that's just not under your command), the
> > accompanying problems may arise.  You may need to flush CPU
> > provided data upon write before telling an external entity to
> > access it, and may need to invalidate caches (to have data
> > re-fetched) before the CPU accesses what an external entity did
> > manipulate.  And this applies to both payload data as well as
> > management data (descriptors) if the latter apply to the former.
>=20
> This is something I've been exploring today.  But what is unclear is
> _how_ to flush/invalidate the caches'.  I was going to tweak the
> driver to setup the descriptors, flush the cache, then enable the
> hardware (and when taking the device down, disable the hardware, flush
> the cache, then deallocate the descriptors).  But this is in the
> network code and it isn't obvious how to make this happen.

FWIW it is almost impossible to code for non-coherent descriptors
(even ignoring problems with speculative cache line reads).
You don't even want to try to do it except for hardware where you
can no choice.

The problem is that you have no control over the device writes
into the descriptors. In order not to lose the device writes
the cpu must not write to any cache lines that contain active
descriptors.

For the receive side this can be arranged by initialising cache
line sized blocks of descriptors (if the cache line write isn't
atomic you still have problems).

The send side is much more tricky: you either have to setup a
full cache line of descriptors or wait until the transmit is idle.

	David

Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from fuzix.org (www.llwyncelyn.cymru [82.70.14.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtt8z2PYwzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:14:42 +1000 (AEST)
Date: Thu, 22 Jun 2017 21:14:31 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates
 <sbates@raithlin.com>
Subject: Re: [PATCH 3/7] asm-generic/io.h: make ioread64 and iowrite64
 universally available
Message-ID: <20170622211431.14270378@alans-desktop>
In-Reply-To: <20170622164817.25515-4-logang@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 10:48:13 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Currently, ioread64 and iowrite64 are only available io CONFIG_64BIT=y
> and CONFIG_GENERIC_IOMAP=n. Thus, seeing the functions are not
> universally available, it makes them unusable for driver developers.
> This leads to ugly hacks such as those at the top of
> 
> drivers/ntb/hw/intel/ntb_hw_intel.c
> 
> This patch adds fallback implementations for when CONFIG_64BIT and
> CONFIG_GENERIC_IOMAP are not set. These functions use two io32 based
> calls to complete the operation.
> 
> Note, we do not use the volatile keyword in these functions like the
> others in the same file. It is necessary to avoid a compiler warning
> on arm.

This is a really really bad idea as per the Alpha comment.

ioread64 and iowrite64 generate a single 64bit bus transaction. There is
hardware where mmio operations have side effects so simply using a pair
of 32bit operations blindly does not work (consider something as trivial
as reading a 64bit performance counter or incrementing pointer).

If a platform doesn't support 64bit I/O operations from the CPU then you
either need to use some kind of platform/architecture specific interface
if present or accept you don't have one.

It's not safe to split it. Possibly for some use cases you could add an

ioread64_maysplit()

but you cannot blindly break ioread64/write64() and expect it to
magically allow you to use drivers that depend upon it.

What btw is the actual ARM compiler warning ? Is the compiler also trying
to tell you it's a bad idea ?

Alan

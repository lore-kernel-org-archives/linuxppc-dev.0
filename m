Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59A761A0072
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2015 00:07:23 +1000 (AEST)
Date: Fri, 17 Jul 2015 16:06:54 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] x86,
 irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED to IRQ_*
In-Reply-To: <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <alpine.DEB.2.11.1507171558010.18576@nanos>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 12 Jul 2015, Bjorn Helgaas wrote:

> The per-cpu vector_irq[] table is indexed by CPU vector numbers, and each
> entry contains an IRQ number.
> 
> Rename the special values VECTOR_UNDEFINED and VECTOR_RETRIGGERED to
> IRQ_UNDEFINED and IRQ_RETRIGGERED to indicate that they are in the IRQ
> number space, not the CPU vector number space.

Makes some sense, but OTOH vector_irq actually reflects the vector
state not the irq number state. The fact that we store the Linux irq
number in vector_irq is just an implementation detail.

VECTOR_UNDEFINED is certainly a misnomer; that should be VECTOR_UNUSED

VECTOR_RETRIGGERED is pretty accurate. In the case we retrigger an
interrupt, we merily use the Linux irq number to figure out which
vector to kick. And after we retriggered it, we lose the association
to the Linux irq number completely.

That said, I'm working on storing the irq descriptor pointer in
vector_irq instead of the irq number, which has the advantage that we
avoid the lookup of the irq descriptor in the interrupt hotpath.

Thanks,

	tglx

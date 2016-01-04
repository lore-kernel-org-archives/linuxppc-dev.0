Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67B7D1A0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 00:37:11 +1100 (AEDT)
Date: Mon, 4 Jan 2016 14:36:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>,
 David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 17/32] arm: define __smp_xxx
Message-ID: <20160104133658.GY6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
 <20160103110158-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160103110158-mutt-send-email-mst@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 03, 2016 at 11:12:44AM +0200, Michael S. Tsirkin wrote:
> On Sat, Jan 02, 2016 at 11:24:38AM +0000, Russell King - ARM Linux wrote:

> > My only concern is that it gives people an additional handle onto a
> > "new" set of barriers - just because they're prefixed with __*
> > unfortunately doesn't stop anyone from using it (been there with
> > other arch stuff before.)
> > 
> > I wonder whether we should consider making the smp memory barriers
> > inline functions, so these __smp_xxx() variants can be undef'd
> > afterwards, thereby preventing drivers getting their hands on these
> > new macros?
> 
> That'd be tricky to do cleanly since asm-generic depends on
> ifndef to add generic variants where needed.
> 
> But it would be possible to add a checkpatch test for this.

Wasn't the whole purpose of these things for 'drivers' (namely
virtio/xen hypervisor interaction) to use these?

And I suppose most of virtio would actually be modules, so you cannot do
what I did with preempt_enable_no_resched() either.

But yes, it would be good to limit the use of these things.

Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E32481A0045
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jan 2016 20:12:56 +1100 (AEDT)
Date: Sun, 3 Jan 2016 11:12:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 17/32] arm: define __smp_xxx
Message-ID: <20160103110158-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-18-git-send-email-mst@redhat.com>
 <20160102112438.GU8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160102112438.GU8644@n2100.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 02, 2016 at 11:24:38AM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 31, 2015 at 09:07:59PM +0200, Michael S. Tsirkin wrote:
> > This defines __smp_xxx barriers for arm,
> > for use by virtualization.
> > 
> > smp_xxx barriers are removed as they are
> > defined correctly by asm-generic/barriers.h
> > 
> > This reduces the amount of arch-specific boiler-plate code.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> In combination with patch 14, this looks like it should result in no
> change to the resulting code.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> My only concern is that it gives people an additional handle onto a
> "new" set of barriers - just because they're prefixed with __*
> unfortunately doesn't stop anyone from using it (been there with
> other arch stuff before.)
> 
> I wonder whether we should consider making the smp memory barriers
> inline functions, so these __smp_xxx() variants can be undef'd
> afterwards, thereby preventing drivers getting their hands on these
> new macros?

That'd be tricky to do cleanly since asm-generic depends on
ifndef to add generic variants where needed.

But it would be possible to add a checkpatch test for this.


> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

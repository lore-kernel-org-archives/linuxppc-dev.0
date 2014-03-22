Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 777F52C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 09:52:37 +1100 (EST)
Date: Sat, 22 Mar 2014 22:52:01 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
Message-ID: <20140322225201.GN7528@n2100.arm.linux.org.uk>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
 <20140322222306.GM7528@n2100.arm.linux.org.uk>
 <1395527860.2143.61.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395527860.2143.61.camel@dabdike.int.hansenpartnership.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Laura Abbott <lauraa@codeaurora.org>,
 linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 22, 2014 at 03:37:40PM -0700, James Bottomley wrote:
> On Sat, 2014-03-22 at 22:23 +0000, Russell King - ARM Linux wrote:
> > On Sat, Mar 22, 2014 at 02:31:21PM -0700, James Bottomley wrote:
> > > Perhaps now might be the time to ask which are the remaining
> > > architectures that cannot do SG chaining and then we can fix them and
> > > pull the whole thing out.
> > 
> > Not quite.  You're making the assumption that we can be sure that all
> > the scatterlist users on an architecture have been converted - that's
> > simply not true on ARM.
> 
> No I'm not, I said "now might be the time to ask which are the remaining
> architectures that cannot do SG chaining"

And I'm disagreeing with that statement which implies that it's something
that is an architecture wide property for any particular architecture.

Right now in mainline, if ARM has IOMMU support enabled, then SG_CHAIN
support will also be enabled.  I've a patch out of tree which I've been
using for years which enables SG_CHAIN for a particular SoC (Dove).
Otherwise, it doesn't have support for SG_CHAIN.

PARISC on the other hand (as you list) has no support to enable SG_CHAIN
under any circumstances.

Where we're disagreeing is whether this is something that is always-on or
always-off for any particular architecture.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

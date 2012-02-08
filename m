Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 39C8FB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 09:03:08 +1100 (EST)
Message-ID: <1328738567.2903.45.camel@pasglop>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 09 Feb 2012 09:02:47 +1100
In-Reply-To: <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-08 at 07:58 -0800, Bjorn Helgaas wrote:
> The only architecture-specific thing here is discovering the range of
> bus numbers below a host bridge.  The architecture should not have to
> mess around with pci_bus_update_busn_res_end() like this.  It should
> be able to say "here's my bus number range" (and of course the PCI
> core can default to 0-255 if the arch doesn't supply a range) and the
> core should take care of the rest. 

So it's a bit messy in here because we deal with several things.

What the firmware gives us is the range it assigned, but that isn't
necessarily the HW limits (almost never is in fact).

In some cases we honor it, for example when in "probe only" mode where
we prevent any reassigning, and in some case, we ignore it and let the
PCI core renumber things (typically because the FW "forgot" to set aside
bus numbers for a cardbus slot for example, that sort of things).

So it's a bit of a tricky situation.

Off the top of my head, I'm pretty sure that most if not all of our PCI
host bridges simply support a full 0...255 range and there is no sharing
between bridges like on x86, they are just different domains.

But I can't vouch 100% for some of the oddball cases like Pegasos or
some freescale gear.

Cheers,
Ben.

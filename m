Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-29.bluehost.com (outbound-mail-29.bluehost.com
	[69.89.17.211]) by ozlabs.org (Postfix) with SMTP id 30DC8DDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 05:52:31 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources()
	implementations
Date: Mon, 3 Mar 2008 10:45:06 -0800
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.404893334@ldl.fc.hp.com>
In-Reply-To: <20080228001053.404893334@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803031045.07054.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
>
> This patch consolidates most of them to use the version annotated below.
> This is the original x86 version, except that it uses the resource
> collision check from powerpc at (5):

Looks really good to me, definitely a step in the right direction.

> The mips/pmc-sierra implementation of pcibios_enable_resources() is
> cluttered with a bunch of titan stuff, so I can't immediately consolidate
> it with the others.  So I made the generic version "weak" so pmc-sierra
> can override it.
>
> Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

So you'd like to see the MIPS stuff cleaned up a bit more first before actual 
sign-off?  Or just more testing?

>  18 files changed, 43 insertions(+), 507 deletions(-)

Nice diffstat. :)

Jesse

Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id EC552DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:11:53 +1100 (EST)
Date: Tue, 19 Feb 2008 01:11:50 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080219061150.GA10115@phobos.i.cabal.ca>
References: <20080219043952.845136014@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080219043952.845136014@ldl.fc.hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
>     - PA-RISC always turns on SERR and PARITY, which no other arch does
> 

I suspect this is because we set the host bus adapters to hard fail
(HPMC) on detecting an error, since we don't want to
	1) return possibly bogus (-1) data
	2) write code to use the (undocumented) error detection

More to the point, I suspect it's extra paranoia because firmware has
set it up this way. I put in a quick hack to test whether those bits
were set, and they came enabled that way by firmware on all the boxes I
tested. (Disclaimer, I didn't have any easily accessible boxes with
add-on cards installed, so firmware might just set it up for core
devices, and we're making sure its set everywhere.)

cheers, Kyle

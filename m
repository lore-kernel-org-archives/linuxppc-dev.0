Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9C58DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 17:48:11 +1100 (EST)
Date: Tue, 19 Feb 2008 23:24:55 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080220062455.GB6315@colo.lackof.org>
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
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
> This patch series consolidates most of them to use the x86 version.
> 
> This series is for discussion only at this point.  I'm interested in
> feedback about whether any of the differences are "real" and need to
> be preserved.
> 
> ARM and PA-RISC, in particular, have interesting differences:
>     - ARM always enables bridge devices, which no other arch does
>     - PA-RISC always turns on SERR and PARITY, which no other arch does
> 
> Should other arches do the same thing, or are these somehow related to
> ARM and PA-RISC architecture?

My impression was most x86 BIOS's did NOT turn on SERR/PERR when I added
that code to parisc-linux port (2000 or 2001 so) . HPUX was turning on
SERR/PERR and so I was comfortable the HW was stable and it not crash
under normal use unless something was really broken.

There is certainly nothing architectural specific about SERR/PERR.
I felt (at the time) this is more of a case of "if it's not reported to the
user, we won't get blamed for it not working well."

hth,
grant

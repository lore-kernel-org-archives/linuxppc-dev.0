Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5625ADDFC4
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:31:42 +1100 (EST)
Date: Thu, 28 Feb 2008 10:31:25 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 5/6] PARISC: move PERR & SERR enables out of
	pcibios_enable_resources()
Message-ID: <20080228173125.GA16270@colo.lackof.org>
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.209248743@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228001053.209248743@ldl.fc.hp.com>
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

On Wed, Feb 27, 2008 at 05:04:42PM -0700, Bjorn Helgaas wrote:
> Move PERR and SERR enables from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Ack-By: Grant Grundler <grundler@parisc-linux.org>

This patch sequence is heading in the right direction.
I've not tested this particular one yet but I'm pretty sure it's ok.
I'll fixup any breakage for parisc.

...
> +/*
> + * A driver is enabling the device.  We enable the PERR and SERR bits
> + * unconditionally.  Drivers that do not need parity (eg graphics and
> + * possibly networking) can clear these bits if they want.
> + */
> +static int platform_pci_enable_device(struct pci_dev *dev)

Thanks for preserving this comment.

In general, I'm wondering if the check for device class would be
sufficient here to NOT enable PERR/SERR for graphics automatically.
While disabling PERR was "the right thing" for older "mostly write"
devices of the 1990's and early 2000, it might not be correct for
current 3-D graphics devices which use host mem to buffer processed
results. I'm thinking of Intel graphics controllers in particular
but I don't know any details of how they actually work.

I'm also a bit concerned about this now becuase (IIRC) AGP didn't
implement parity though it looked like PCI protocol. PCI-e certainly
does but it's possible BIOS/Firmware disable parity generation
on the host bridge when connected to a gfx device.
We wouldn't want to enable parity checking on a PCI-e gfx device in this
case and I hope someone (perhaps at Intel) could double check this.

thanks,
grant

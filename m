Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1FC2B7D0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 14:52:43 +1100 (EST)
Date: Thu, 28 Jan 2010 20:45:24 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
Message-ID: <20100129034524.GA13385@parisc-linux.org>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
	<1264558256.3601.153.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1264558256.3601.153.camel@pasglop>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Miller <davem@davemloft.net>, Ron Mercer <ron.mercer@qlogic.com>,
	kaneshige.kenji@jp.fujitsu.com, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 01:10:56PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Cc'ing Ben for PPC.  Ben, should PPC use pci_scan_device when probing
> > its root busses?  Sounds like it just uses pci_device_add for each one
> > it finds instead?
> > 
> > If you don't actually need scanning (though what about hotplug?) we can
> > move the call to device_add instead...
> 
> Ok so I looked at the code and the problem goes way beyond root busses.
> 
> Basically, powerpc can use the code in arch/powerpc/kernel/pci_of_scan.c
> to "generate" the pci_dev without using config space probing or at least
> using as little of it as possible, using the firmware device-tree
> information instead.
> 
> This is also probably going to be moved to a more generic place and
> extended to be used optionally by other architectures.

Yes, having it under drivers/pci/ somewhere would be a big improvement,
that way we'd actually see it when trying to do cleanups and wouldn't
accidentally break your architectures.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

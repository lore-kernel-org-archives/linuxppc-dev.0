Return-Path: <bjorn.helgaas@hp.com>
Received: from g5t0006.atlanta.hp.com (g5t0006.atlanta.hp.com [15.192.0.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 716E5DDF35
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 03:17:04 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: benh@kernel.crashing.org
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Date: Tue, 19 Feb 2008 09:11:55 -0700
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.878416912@ldl.fc.hp.com>
	<1203402667.6740.94.camel@pasglop>
In-Reply-To: <1203402667.6740.94.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200802190911.56901.bjorn.helgaas@hp.com>
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

On Monday 18 February 2008 11:31:07 pm Benjamin Herrenschmidt wrote:
> 
> On Mon, 2008-02-18 at 21:39 -0700, Bjorn Helgaas wrote:
> >     powerpc: has a different collision check at (5)
> 
> I've always found the collision check dodgy. I tend to want to keep
> the way powerpc does it here.
> 
> pci_enable_device() should only enable resources that have successfully
> been added to the resource tree (that have passed all the collision
> check etc...). There is a simple & clear indication of that: res->parent
> is non-NULL. I think that is a better check than the test x86 does on
> start and end.
> 
> That is, whatever the arch code decides to use to decide whether
> resources are assigned by firmware or by the first pass assignment code
> or not and collide or not, once that phase is finished (which is the
> case when calling pcibios_enable_device(), having the resource in the
> resource-tree or not is, I believe, the proper way to test whether it's
> a useable resource.

So should x86 adopt that collision check?  I don't hear anything about
actual architecture differences that are behind this implementation
difference.

Bjorn

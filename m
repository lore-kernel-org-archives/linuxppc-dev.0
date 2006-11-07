Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D50B67D08
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:44:36 +1100 (EST)
Date: Tue, 7 Nov 2006 13:44:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Russell King <rmk-pci@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
Message-ID: <20061107204432.GZ27140@parisc-linux.org>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107201436.GE9533@flint.arm.linux.org.uk>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 08:14:36PM +0000, Russell King wrote:
> On Tue, Nov 07, 2006 at 01:07:30PM -0700, Matthew Wilcox wrote:
> > We have the per-irq void *chip_data; could this be the right place to
> > keep it instead?  That way, it won't take up space in the pci_dev for
> > devices which don't use MSI.
> 
> Bah.  chip_data is supposed to be __iomem.  I bet if you build ARM
> with sparse it'll kick out lots of warnings as a result of that loss.

Erm, since when?  When I introduced it (back in January 2005 [1]), it
was called handler_data and pointed to a struct which is chip-type
dependent.  One of the items in that struct is an IO address, but we
need more than that.

Now we have something else called handler_data, and I must
admit to being quite confused what the difference is.  The comment in
the header files and the DocBook genericirq leave me quite confused.

[1] http://git.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=1dd15c35b6bc179cd9c2a47e13360052c1e938a3

Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C9E667CB4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:07:35 +1100 (EST)
Date: Tue, 7 Nov 2006 13:07:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
Message-ID: <20061107200730.GY27140@parisc-linux.org>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107072125.68E9F67CA7@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
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

On Tue, Nov 07, 2006 at 06:21:23PM +1100, Michael Ellerman wrote:
> We currently (ab)use the pci_dev to store our msi_info structure. We
> were hoping to stash it in the pci_dn, but that's not a goer, so the
> pci_dev seems like the right place, even though it seems naughty to
> bloat generic structs.

We have the per-irq void *chip_data; could this be the right place to
keep it instead?  That way, it won't take up space in the pci_dev for
devices which don't use MSI.

Or do you rely on mpic_from_irq() working for MSI interrupts too?

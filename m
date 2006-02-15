Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAEDB679FE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 08:45:25 +1100 (EST)
Date: Wed, 15 Feb 2006 15:36:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: "dibacco@inwind.it" <dibacco@inwind.it>
Subject: Re: IMAP_ADDR is virtual or physical address?
In-Reply-To: <IUR08Q$EA50D33FB87244406C6EB74722F8E71C@libero.it>
Message-ID: <Pine.LNX.4.44.0602151534040.30048-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 15 Feb 2006, dibacco@inwind.it wrote:

> I'm wondering if IMAP_ADDR is a virtual address or a physical one. Normally I see things like this in drivers:
> 
> static volatile immap_t *immr = (immap_t *) IMAP_ADDR;
> 
> It seems therefore a virtual address.

IMAP_ADDR tends to be a physical address, however its mapped 1:1 in the 
kernel via io_block_mapping() on a number of systems to get the 1:1 
mapping.

This is somewhat frowned upon, and drivers should really do their own 
ioremap() with a physical address for IMAP_ADDR.

> 
> But I can see the same also in some u-boot code where I imagine we are accessing physical addresses.
> 
> Clear my doubt please!!

In u-boot everything is mapped 1:1 so there is no difference between virt 
and phys addrs.

- kumar

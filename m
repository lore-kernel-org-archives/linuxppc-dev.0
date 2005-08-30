Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17171.57693.981385.165290@cargo.ozlabs.ibm.com>
Date: Tue, 30 Aug 2005 14:32:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050830035338.GA5755@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com>
	<20050830035338.GA5755@dmt.cnet>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti writes:

> The memory map structure which contains device configuration/registers
> is _always_ directly mapped with pte's (the 8xx is a chip with builtin
> UART/network/etc functionality).
> 
> I don't think there is a need to use read/write acessors.

Generally on PowerPC you need to use at least the eieio instruction to
prevent reordering of the loads and stores to the device.  It's
possible that 8xx is sufficiently in-order that you get away without
putting in barrier instructions (eieio or sync), but it's not good
practice to omit them.

You can use accessors such as in_be32 and in_le32 in this situation,
when you have a kernel virtual address that is already mapped to the
device.

Regards,
Paul.

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E0726DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 14:22:12 +1000 (EST)
Date: Sun, 30 Sep 2007 23:25:59 -0500
From: Olof Johansson <olof@lixom.net>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
Message-ID: <20071001042559.GA32255@lixom.net>
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com> <46FC8EFE.2000108@mock.com>
	<12937117.post@talk.nabble.com> <12966462.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12966462.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First, PLEASE stop quoting your own text. Do not append > in front of
the lines you write yourself in the reply. It makes it impossible to
tell what parts are new and what are old.

On Sun, Sep 30, 2007 at 07:54:28AM -0700, Misbah khan wrote:

> >> FPGA is Indeed mapped non cashed here is the part of the code 
> >> 
> >> /* Physical bus memory is mapped */
> >> 	mmap_reg_ptr=(UINT32 *)ioremap_nocache(PHY_MEM_ADDR,PHY_MEM_SIZE);
> >> 
> >> And is it ok if I caste FPGA pointer volatile like this will reduce the
> >> probability of failure 

You cannot ever use set_bit/clear_bit to uncacheable memory. Ever. It
uses load-reserve/store-conditional, and they are not legal to use to
uncacheable memory.

Also, regular ioremap() is by default uncacheable, so it's quite adequate
to use in this case, no need to use the _nocache version.

> >> do you think   in_be32()  could be the best approach than direct
> >> dereferencing. And about test_bit() function does it looks fine to you 

You need to use in_be32() + manipulating the value + out_be32(),
yes. Depending on the rest of your driver you might need to protect it
with a spinlock, but that's beyond the scope of this question.


-Olof

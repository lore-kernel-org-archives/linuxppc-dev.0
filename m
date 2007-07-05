Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id CE325DDF1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jul 2007 16:54:33 +1000 (EST)
Date: Thu, 5 Jul 2007 08:54:29 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Kimmo Surakka <kusti@iki.fi>
Subject: Re: TQM5200 problems (kernel 2.4)
Message-ID: <20070705065429.GC4186@moe.telargo.com>
References: <a44e83440707040751o4f2e195dte8c2edafd5f864c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a44e83440707040751o4f2e195dte8c2edafd5f864c@mail.gmail.com>
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

On 04/07/07 17:51 +0300, Kimmo Surakka wrote:
> Hello all,
> 
Hi!

...
> Problem #2: I2C unreliability. My test setup has two slaves connected
> on the TQM5200 I2C bus #1. On default setup this bus is disabled, so I
> needed to edit file drivers/i2c/i2c-tqm5200.c and changethe value of
> MPC5xxx_I2C1_ENABLE. After this change, the bus gets initialised.
> However, it's not reliable. I send smbus_read_word and
> smbus_write_word commands to the slaves every few milliseconds. Sooner
> or later the bus gets stuck, apparently forever. I found an old I2c

This is probably a hardware bug as described in:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html

> patch for mpc5200 and modified it a bit. With the patch applied, the
> kernel tries to detect bus lock-ups and reset the bus. This helps a
> lot: now the lock-ups are only temporary. However, the dmesg log gets
> polluted with lines like
> 
> Warning: kfree_skb on hard IRQ c008ecfc
> Warning: kfree_skb on hard IRQ c008ecfc
> Warning: kfree_skb on hard IRQ c008ecfc
> Warning: kfree_skb on hard IRQ c008ecfc
> Warning: kfree_skb on hard IRQ c008ecfc
> Warning: kfree_skb on hard IRQ c008ecfc
> 
> (always the same IRQ). The seem to come from net/core/skbuff.c, and
> caused by kfree_skb being called while in_irq().
> 

I'm not seeing these (2.6-git from kernel.org)


	Domen

Return-Path: <henk.stegeman@gmail.com>
Received: from mail-bw0-f211.google.com (mail-bw0-f211.google.com
	[209.85.218.211]) by ozlabs.org (Postfix) with ESMTP id E6945B7BFA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 19:54:28 +1100 (EST)
Received: by bwz3 with SMTP id 3so2628972bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 00:54:25 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 11 Mar 2010 09:54:25 +0100
Message-ID: <ae4f76fd1003110054id15714cped1b19fa3fcf70e8@mail.gmail.com>
Subject: BUG: mpc52xx_gpt mask/unmask of interrupts
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In mpc52xx_gpt.c

The functions

static void mpc52xx_gpt_irq_unmask(unsigned int virq)
static void mpc52xx_gpt_irq_mask(unsigned int virq)

Respectively clear and set bit IRQ_EN (INT_EN in MPC5200B user manual)
of the GPT's enable and mode select register.

Refer to Figure 7-45 and table 7-48 on page 229 of
http://www.freescale.com/files/32bit/doc/ref_manual/MPC5200BUM.pdf

I believe this is wrong (and I've seen this go wrong) because this bit
disables the generation of interrupts, and therefore kills detection
of edged interrupts between calls of mpc52xx_gpt_irq_mask and
mpc52xx_gpt_irq_unmask. I also suspect that clearing this bit clears
an already pending interrupt, which could be the cause of spurious
interrupts I am getting on my board.

Freescale has confirmed to me that this INT_EN bit is indeed not a
mask, but an enable for interrupts.

It seems to me that the only way to mask interrupts for this situation
is to set the TMRx bit for the gpt in the ICTL Critical Priority and
Main Interrupt mask register (table 7-9 on page 175). These bits are
now handled by mpc52xx_pic, the driver for the interrupt the gpt irq
is cascaded to from.

I have no complete idea for a fix yet.
Is it possible to somehow make use of the mpc52xx_pic mask funtions?
For this case that would be quite valid as the gpt as interrupt
controller only provides one interrupt, so masking one is the same as
masking 'all' on the parent.


Cheers,

Henk Stegeman

Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id CF15967A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 05:36:55 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j1MIaomZ010741 for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 13:36:50 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id NAA00610
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 13:36:49 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647668@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 22 Feb 2005 13:36:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: PPC32 8xx MPC880  Linux 2.6 Interrupt storm 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have MPC880 based board with 24C02 I2C serial EEPROM
 and I try to run Linux 2.6 on this board.

Originally I had problem:

<3>request_irq() returned -22 for CPM vector 32.

I traced the problem to the following line,
shown below as commented out (by me)
in cpm_iic_init() (drivers/i2c/algos/i2c-algo-8xx.c)

/* (*cpm_adap->setisr)(CPM_IRQ_OFFSET + CPMVEC_I2C, cpm_iic_interrupt,
cpm_int_name[CPMVEC_I2C], (void *)i2c); */
                               ^                             ^
                               |                             |
                               16                           16

It makes the first argument to be 32 (16 + 16) and that was originally
causing error.

This error gets generated actually in request_irq() in kernel/irq/manage.c.

Specifically (I tracked it down with debug print there ) it comes from

if (irq >= NR_IRQS)

return -EINVAL;

Note that NR_IRQS is set to 32 and irq was also 32 as described above
(before my "fix" - see below) .

I have made the "fix" (it's just a kludge, I am not sure where the correct
fix should be
and what is the actual origin of this problem):


(*cpm_adap->setisr)(CPM_IRQ_OFFSET + CPMVEC_I2C - CPM_IRQ_OFFSET,
cpm_iic_interrupt, cpm_int_name[CPMVEC_I2C], (void *)i2c);

                                                  ^^^^^^^^^^^^^^^

I am leaving above line "as is" just for demonstrational purpose: to show
that in the first argument the 
CPM_IRQ_OFFSET is originally added and I am subtracting it back.

This gives:

cpm_iic_init[134] Install ISR for IRQ 16 CPM_IRQ_OFFSET 16

rpx_install_isr: irq: 0x10 <<<=============    This is correct IRQ for I2C
on 8xx

However after this "fix" I see continuos flood of interrupts for IRQ 0x10
(dedicated to I2C on 8xx) in response to polling of 0x50 I2C address 
- should be just one interrupt ...
but actually, the ISR function gets triggered in continuous non-stop flood -
I could see it with the print statement (of course I disabled this print for
the next build ...) so it chokes the processor completely.

Thanks,
Best Regards,
Alex

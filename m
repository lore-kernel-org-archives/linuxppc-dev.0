Return-Path: <allanjos@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 45D1668A1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 04:50:54 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so493422nzd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 09:50:53 -0800 (PST)
Message-ID: <7a2435710601200950r757a27f1l3c2fa90cd7fa2f3@mail.gmail.com>
Date: Fri, 20 Jan 2006 13:50:53 -0400
From: Moloko Vellocet <allanjos@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: PSC mode
In-Reply-To: <7a2435710601200815p623cfe22meff3bc108aae5c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7a2435710601200815p623cfe22meff3bc108aae5c8f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, I'm writing a driver to manage the serial communication in a
MPC5200 board, but the interrupt I don't have obtained the call to
interrupt routine, I've configured the registers in the initialization
code as the following:

#define REG_MBAR     MPC5xxx_MBAR
#define REG_BASE_PSC MPC5xxx_PSC3
#define REG_CR       (REG_BASE_PSC + 0x08)
#define REG_RXTX     (REG_BASE_PSC + 0x0C)
#define REG_IMR      (REG_BASE_PSC + 0x14)
#define REG_SICR     (REG_BASE_PSC + 0x40)
#define REG_RFALARM  (REG_BASE_PSC + 0x6E)
#define REG_TFALARM  (REG_BASE_PSC + 0x8E)

outb(0x0A, REG_CR);
wmb();
printk("REG_CR=3D%x\n", inb(REG_CR));
rmb();
outb(0x221000, REG_SICR);
wmb();
printk("REG_SICR=3D%x\n", inb(REG_SICR));
rmb();
outb(0x0004, REG_RFALARM);
wmb();
printk("REG_RFALARM=3D%x\n", inb(REG_RFALARM));
rmb();
outb(0x0004, REG_TFALARM);
wmb();
printk("REG_TFALARM=3D%x\n", inb(REG_TFALARM));
rmb();
outb(0x00000300, REG_IMR);
wmb();
printk("REG_IMR=3D%x\n", inb(REG_IMR));
rmb();

I'm getting always:
REG_CR=3D0
REG_SICR=3D0
REG_RFALARM=3D0
REG_TFALARM=3D0
REG_IMR=3D0

I have to configure 'port config' register doing a 'or' with the
actual value in the register, but I can't get the values contained in
the registers. Are the register write-only.

I've registered the following interrupts:
if ((err =3D request_irq(MPC5xxx_IR_RX_IRQ,  /*RX_IRQ_NUMBER,*/
  interrupt_handler,
  SA_INTERRUPT,
  DEVICE_NAME,
  NULL)) < 0)
  goto fail_rx_req_irq;

if ((err =3D request_irq(MPC5xxx_IR_TX_IRQ,  /*TX_IRQ_NUMBER,*/
  interrupt_handler_tx,
  SA_INTERRUPT,
  DEVICE_NAME,
  NULL)) < 0)
  goto fail_tx_req_irq;

But the interrupts are not activated when I execute a ioctl to the
board the interrupt handler are not called.

Does anyone know the problem with this code?




--
_______________________________
Allann J. O. Silva

"I received the fundamentals of my education in school, but that was
not enough. My real education, the superstructure, the details, the
true architecture, I got out of the public library. For an
impoverished child whose family could not afford to buy books, the
library was the open door to wonder and achievement, and I can never
be sufficiently grateful that I had the wit to charge through that
door and make the most of it." (from I. Asimov, 1994)

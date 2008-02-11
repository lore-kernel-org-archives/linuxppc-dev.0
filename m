Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id D3E89DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 22:36:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: External interrupts with UIO framework on mpc8313e
Date: Mon, 11 Feb 2008 12:24:00 +0100
Message-ID: <29DC34A6B43468409F5A371CFE34E8495492CD@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone!

I'm trying to receive external interrupts on the mpc8313erdb board.
I'm also using the UIO framework to register the interrupt handler.=20

It works for me when I register the interrupt handler for external =
interrupt IRQ4 (irq =3D 20)
But when I'm trying the register the handler for IRQ0(48)-IRQ3(17-19) it =
doesn't.=20

I'm using following simple code:

---snip---
static irqreturn_t intHandler(int irq, struct uio_info *dev_info)
{
    printk("name: %s\n", dev_info->name);
    return IRQ_HANDLED
}

static struct uio_info myinfo =3D {
    .name =3D "IRQ4 Kernel Driver",
    .version =3D "1.0.0",
    .irq =3D 20,
    .irq_flags =3D IRQF_SHARED | IRQF_DISABLED,
    .handler =3D intHandler,
};

static int uio_probe(struct device *dev)
{
    if(uio_register_device(dev,&myinfo))
    {
        return -ENODEV;
    }
    else
    {
        return 0;
    }
}
---snip---

After booting the kernel, the driver (for IRQ4) appears correct in =
/proc/interrups and can be triggered.

I guess, this should also work for IRQ0-IRQ3 but it won't. IRQ0 cannot =
registered to 48 at all and the
other ones appear in /proc/interruts but they cannot be triggered (BUT =
shared with serial or i2c).=20

I also checked the value of the SEMSR register and see that IRQ4 is set =
correctly.

Okay, I thought when I set the SEMSR register manually e.g. IRQ2 to "1" =
and trigger the correct interrupt signal I could see in /proc/stat a =
counting value. Nothing happened. But the BAD counter in =
/proc/interrupts is rising.=20

Furthermore there's a mapping issue between the interrupt id number from =
the board manual
(page 8-10) and the output of /proc/interrupts. The kernel registers the =
i2c devices to=20
ID 16 and 17 although the manual says they are mapped to 14 and 15.


Any hint is appreciate!=20
Best regards



Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 58
Fax:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 99
Email:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
frank.prepelica@ubidyne.com
Homepage:=A0=A0=A0=A0=A0=A0 www.ubidyne.com
=A0
Registered office: Ulm
District court of Ulm: HRB 5295
Managing Directors:
Dipl. Ing. Ken Hawk
Dipl. Ing. Beat M=FCller
Dr. Clemens Rheinfelder

Return-Path: <dwilson@dslextreme.com>
Received: from mail9.dslextreme.com (mail9.dslextreme.com [66.51.199.94])
	by ozlabs.org (Postfix) with SMTP id 43004DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 09:08:41 +1100 (EST)
Message-ID: <200702011408330875.0BD61D69@smtp.dslextreme.com>
Date: Thu, 01 Feb 2007 14:08:33 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: linuxppc-embedded@ozlabs.org
Subject: PPC 85xx serial port error
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are using an 8541 processor with ELDK 4.0 and 2.6.15 kernel.

Frequently, if we dump large amounts of output to the console port (for=
 example, if we use 'tar' with the verbose option), we see an error message=
 that starts and scrolls until we reboot the unit:
    serial8250: too much work for irq90

We see this at 9600 baud and also at 115200 baud, although it seems to=
 happen less often at 115k.

This message comes from serial8250_interrupt, which appears to trigger it=
 if the interrupt handler has looped 256 times through the list?

How is this possible?  If the interrupt routine is running, does that not=
 prevent user threads from running and adding more data to the list?  Or am=
 I not understanding this code correctly?

Any light that anyone can shed on the expected behavior of this driver and=
 any ideas on how to work around this are greatly appreciated!

Best regards,

Dan.

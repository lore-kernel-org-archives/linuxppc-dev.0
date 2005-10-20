Return-Path: <claus.baumgartner@netsonic.fi>
Received: from smtp.netsonic.fi (smtp.netsonic.fi [194.29.192.26])
	by ozlabs.org (Postfix) with ESMTP id 271D66861B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 00:21:46 +1000 (EST)
Received: from webmail.netsonic.fi (mc4.netsonic.fi [194.29.192.103])
	by smtp.netsonic.fi (Postfix) with ESMTP id 5A9691F8060
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 16:50:59 +0300 (EEST)
Message-ID: <1795.194.9.254.253.1129816331.squirrel@webmail.netsonic.fi>
Date: Thu, 20 Oct 2005 16:52:11 +0300 (EEST)
From: "claus" <claus.baumgartner@netsonic.fi>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: MPC8270 with preemptible kernel stucks in early console write
Reply-To: claus.baumgartner@netsonic.fi
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,

I'm porting the 2.6.13.2 kernel to a custom board with a MPC8270.
If I compile the kernel preemptible then it gets stuck at the following
line in the cpm_uart_console_write function:

    while ((bdp->cbd_sc & BD_SC_READY) != 0)
            ;

The early_console output works fine in the beginning of the boot but then
it gets stuck after the line "checking if image is initramfs...it isn't
(no cpio magic); looks like an initrd" is printed. The problem doesn't
seem to have anything to do with the initramfs detection though.

I can see with the debugger that the descriptors are OK and the buffers
are filled with correct data but it seems that the SCC is not sending the
characters and the main core is stuck waiting for a descriptor to be
ready for use.

Everything works fine if the kernel is not configured preemptible.

Has anyone else had similar behavior?
Any ideas?


-Claus-

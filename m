Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 7E87567CD6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 02:44:20 +1100 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1Gh6e0-0006HR-So
	for linuxppc-embedded@ozlabs.org; Mon, 06 Nov 2006 16:44:16 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	<87lknadbbl.fsf@sleipner.barco.com>
	<877iylreca.fsf@sleipner.barco.com>
	<609d5c8e0610301145y30d058afs467d27d344149936@mail.gmail.com>
Date: Mon, 06 Nov 2006 16:44:16 +0100
In-Reply-To: <609d5c8e0610301145y30d058afs467d27d344149936@mail.gmail.com>
	(David Bolcsfoldi's message of "Mon, 30 Oct 2006 11:45:45 -0800")
Message-ID: <87u01czijz.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:

Hi,
>> This doesn't help much as you don't use the com_port argument in
>> the other functions.

David> True, it's utterly useless. I was planning on having an array
David> with base addresses which would be used to support the com_port
David> argument.  But it didn't make it in this patch although I have
David> version that does this now.

You don't even need an array - you can use use the base address as the
com_port cookie, E.G.:

--- /dev/null
+++ linux-trunk/arch/ppc/boot/simple/uartlite_tty.c
@@ -0,0 +1,86 @@
+/*
+ * Boot support for Xilinx uartlite
+ *
+ * Copyright (C) 2006 David Bolcsfoldi <dbolcsfoldi@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <asm/io.h>
+#include <linux/serial_uartlite.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+unsigned long serial_init(int chan, void *ignored)
+{
+	unsigned long com_port = 0;
+
+	switch (chan)  {
+#ifdef XPAR_UARTLITE_0_BASEADDR
+	case 0:
+		com_port = XPAR_UARTLITE_0_BASEADDR + 3;
+		break;
+#endif
+#ifdef XPAR_UARTLITE_1_BASEADDR
+	case 1:
+		com_port = XPAR_UARTLITE_1_BASEADDR + 3;
+		break;
+#endif
+#ifdef XPAR_UARTLITE_2_BASEADDR
+	case 2:
+		com_port = XPAR_UARTLITE_2_BASEADDR + 3;
+		break;
+#endif
+#ifdef XPAR_UARTLITE_3_BASEADDR
+	case 3:
+		com_port = XPAR_UARTLITE_3_BASEADDR + 3;
+		break;
+#endif
+	default:
+		break;
+	}
+
+	if (com_port) {
+		void __iomem *base = (void __iomem*)com_port;
+		writeb(0, base + ULITE_CONTROL);
+		writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
+		       base + ULITE_CONTROL);
+		writeb(0, base + ULITE_CONTROL);
+	}
+
+	return com_port;
+}
+
+
+int serial_tstc(unsigned long com_port)
+{
+	void __iomem *base = (void __iomem*)com_port;
+
+	if (base)
+		return readb(base + ULITE_STATUS) & ULITE_STATUS_RXVALID;
+	else
+		return 0;
+}
+
+void serial_putc(unsigned long com_port, unsigned char c)
+{
+	void __iomem *base = (void __iomem*)com_port;
+
+	if (base) {
+		while (readb(base + ULITE_STATUS) & ULITE_STATUS_TXFULL);
+		writeb(c, base + ULITE_TX);
+	}
+}
+
+unsigned char serial_getc(unsigned long com_port)
+{
+	void __iomem *base = (void __iomem*)com_port;
+
+	if (base) {
+		while (!serial_tstc(com_port));
+		return readb(base + ULITE_RX);
+	}
+	else
+		return 0;
+}


>> Where did you get the XPAR_XUL_UART_ defines from? Our
>> xparameters.h seem to contain XPAR_UARTLITE_ defines instead.

David> I think that name is picked up from the name of the device in your
David> design, the defines get names XPAR_NNN_ and mine are called
David> XUL_UART.

Crap - Ok, then people just have to add linux-compatible defines to
the end of their xparameters.h - E.G
#define XPAR_UARTLITE_0_BASEADDR XPAR_XUL_UART_BASEADDR

>> You can always use the ppc_md.progress() stuff for really early
>> debugging if needed. I would prefer to keep this workaround out of
>> uartlite.c if it isn't needed.

David> I am pretty certain probe won't get called until ppc_sys_init has been
David> called which is fairly far into the booting process and even if
David> it did the platform_bus hasn't been initialized before the
David> ppc_sys_init is called, at least not with any of the devices
David> exported by ppc_sys_devices.

True. For really early stuff you'll need to use ppc_md.progress() (or
some additional hacking)

David> Thanks for the review!  David

You're welcome.

-- 
Bye, Peter Korsgaard

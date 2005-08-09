Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 40B4C68060
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 08:29:34 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so7308wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Aug 2005 15:29:33 -0700 (PDT)
Message-ID: <c3d0340b050809152338ca9670@mail.gmail.com>
Date: Tue, 9 Aug 2005 15:23:20 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: gen550_dbg.c cannot handle 16 or 32 bit access to UART registers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The arch/ppc/syslib/gen550_dbg.c assumes UART registers are all
accessed in bytes. However in some designs the bus connected to UART
can only be addressed in 32 or 16 bits. So some flexibility is
desirable. And the change is kinda trivial.

Before making this trivial change, I'm confused about two sets of
defintions on io_type. In <linux/serial.h>, the following are defined.
#define SERIAL_IO_PORT=090
#define SERIAL_IO_HUB6=091
#define SERIAL_IO_MEM=092

However in <linux/serial_core.h>, these are defined.
#define UPIO_PORT=09=09(0)
#define UPIO_HUB6=09=09(1)
#define UPIO_MEM=09=09(2)
#define UPIO_MEM32=09=09(3)

Which set of defintion is better to be used in defining
SERIAL_PORT_DFNS? Currently gen550_gdb.c use SERAIL_IO_XXXX macros.
Either adding a new macro SERIAL_IO_MEM32 in <linux/serial.h> or just
use what are already there.

Are these two sets duplicated? If they are, maybe one of them will be
deprecated soon.

Regards,
-Shawn.

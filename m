Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6364ADDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 23:27:51 +1000 (EST)
Date: Fri, 27 Jul 2007 17:27:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Message-ID: <20070727132721.GA11908@localhost.localdomain>
References: <20070726134754.GA3539@localhost.localdomain>
	<20070726135051.GB5550@localhost.localdomain>
	<200707262007.07537.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200707262007.07537.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
	Stephen Street <stephen@streetfiresound.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 08:07:07PM -0700, David Brownell wrote:
> On Thursday 26 July 2007, Anton Vorontsov wrote:
> > Loopback mode is supported by various controllers, this mode
> > is useful for testing, especially in conjunction with spidev
> > driver.
> 
> ISTR that Stephen Street provided a loopback mode for debug
> in his pxa2xx_spi code.  And I know you're fight that this
> mode shows up in a lot of hardware.
> 
> Comments, anyone?  This seems like a fair way to expose this
> mechanism.  And I tend to agree that it'd mostly be useful in
> conjunction with "spidev".
> 
> Anton -- assuming this goes in, it'd be nice if you could
> contribute a simple test program using this, which we could
> keep in Documentation/spi somewhere.  (Maybe with other testing
> notes, if anyone comes up with such.)

Sure. Test utility is below.

I'm aware it's not perfect, it sends just one transfer message,
which not covers all testing requirements. So implementing
--datafile switch to pass .ppm-alike files (as in
drivers/video/logo/) would be great. But I'm leaving this feature
implementation to those who will really need it. ;-)

Thanks!

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [SPI] spidev_test utility

This is simple utility used to test SPI functionality.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/spi/spidev_test.c |  202 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 202 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/spidev_test.c

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
new file mode 100644
index 0000000..d76a72b
--- /dev/null
+++ b/Documentation/spi/spidev_test.c
@@ -0,0 +1,202 @@
+/*
+ * SPI testing utility (using spidev driver)
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Cross-compile with cross-gcc -I/path/to/cross-kernel/include
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/spi/spidev.h>
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+
+static void pabort(const char *s)
+{
+	perror(s);
+	abort();
+}
+
+static char *device = "/dev/spidev1.1";
+static uint8_t mode;
+static uint8_t bits = 8;
+static uint32_t speed = 500000;
+static uint16_t delay;
+
+static void transfer(int fd)
+{
+	int ret;
+	uint8_t tx[] = {
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
+		0xF0, 0x0D,
+	};
+	uint8_t rx[ARRAY_SIZE(tx)] = {0, };
+	struct spi_ioc_transfer tr = {
+		.tx_buf = (unsigned long)tx,
+		.rx_buf = (unsigned long)rx,
+		.len = ARRAY_SIZE(tx),
+		.delay_usecs = delay,
+		.speed_hz = speed,
+		.bits_per_word = bits,
+	};
+
+	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
+	if (ret == 1)
+		pabort("can't send spi message");
+
+	for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {
+		if (!(ret % 6))
+			puts("");
+		printf("%.2X ", rx[ret]);
+	}
+	puts("");
+}
+
+void print_usage(char *prog)
+{
+	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
+	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
+	     "  -s --speed    speed (Hz)\n"
+	     "  -d --delay    delay (usec)\n"
+	     "  -b --bpw      bits per word \n"
+	     "  -l --loop     loopback\n"
+	     "  -H --cpha     clock phase\n"
+	     "  -O --cpol     clock polarity\n"
+	     "  -L --lsb      least significant bit first\n"
+	     "  -C --cs-high  chip select active high\n"
+	     "  -3 --3wire    SI/SO signals shared\n");
+	exit(1);
+}
+
+void parse_opts(int argc, char *argv[])
+{
+	while (1) {
+		static struct option lopts[] = {
+			{ "device",  1, 0, 'D' },
+			{ "speed",   1, 0, 's' },
+			{ "delay",   1, 0, 'd' },
+			{ "bpw",     1, 0, 'b' },
+			{ "loop",    0, 0, 'l' },
+			{ "cpha",    0, 0, 'H' },
+			{ "cpol",    0, 0, 'O' },
+			{ "lsb",     0, 0, 'L' },
+			{ "cs-high", 0, 0, 'C' },
+			{ "3wire",   0, 0, '3' },
+			{ NULL, 0, 0, 0 },
+		};
+		int c;
+
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3", lopts, NULL);
+
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'D':
+			device = optarg;
+			break;
+		case 's':
+			speed = atoi(optarg);
+			break;
+		case 'd':
+			delay = atoi(optarg);
+			break;
+		case 'b':
+			bits = atoi(optarg);
+			break;
+		case 'l':
+			mode |= SPI_LOOP;
+			break;
+		case 'H':
+			mode |= SPI_CPHA;
+			break;
+		case 'O':
+			mode |= SPI_CPOL;
+			break;
+		case 'L':
+			mode |= SPI_LSB_FIRST;
+			break;
+		case 'C':
+			mode |= SPI_CS_HIGH;
+			break;
+		case '3':
+			mode |= SPI_3WIRE;
+			break;
+		default:
+			print_usage(argv[0]);
+			break;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+	int fd;
+
+	parse_opts(argc, argv);
+
+	fd = open(device, O_RDWR);
+	if (fd < 0)
+		pabort("can't open device");
+
+	/*
+	 * spi mode
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_MODE, &mode);
+	if (ret == -1)
+		pabort("can't set spi mode");
+
+	ret = ioctl(fd, SPI_IOC_RD_MODE, &mode);
+	if (ret == -1)
+		pabort("can't get spi mode");
+
+	/*
+	 * bits per word
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
+	if (ret == -1)
+		pabort("can't set bits per word");
+
+	ret = ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits);
+	if (ret == -1)
+		pabort("can't get bits per word");
+
+	/*
+	 * max speed hz
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
+	if (ret == -1)
+		pabort("can't set max speed hz");
+
+	ret = ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed);
+	if (ret == -1)
+		pabort("can't get max speed hz");
+
+	printf("spi mode: %d\n", mode);
+	printf("bits per word: %d\n", bits);
+	printf("max speed: Hz (kHz): %d (%d)\n", speed, speed/1000);
+
+	transfer(fd);
+
+	close(fd);
+
+	return ret;
+}
-- 
1.5.0.6

Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzj4c02JMzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:42:07 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 33/37] tools: PCI: Add a userspace tool to test PCI endpoint
Date: Thu, 12 Jan 2017 15:56:22 +0530
Message-ID: <1484216786-17292-34-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a userspace tool to invoke the ioctls exposed by the
PCI endpoint test driver to perform various PCI tests.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 tools/pci/pcitest.c |  186 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 tools/pci/pcitest.c

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
new file mode 100644
index 0000000..39b5b0b
--- /dev/null
+++ b/tools/pci/pcitest.c
@@ -0,0 +1,186 @@
+/**
+ * Userspace PCI Endpoint Test Module
+ *
+ * Copyright (C) 2017 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/pcitest.h>
+
+#define BILLION 1E9
+
+static char *result[] = { "NOT OKAY", "OKAY" };
+
+struct pci_test {
+	char		*device;
+	char		barnum;
+	bool		legacyirq;
+	unsigned int	msinum;
+	bool		read;
+	bool		write;
+	bool		copy;
+	unsigned long	size;
+};
+
+static int run_test(struct pci_test *test)
+{
+	long ret;
+	int fd;
+	struct timespec start, end;
+	double time;
+
+	fd = open(test->device, O_RDWR);
+	if (fd < 0) {
+		perror("can't open PCI Endpoint Test device");
+		return fd;
+	}
+
+	if (test->barnum >= 0 && test->barnum <= 5) {
+		ret = ioctl(fd, PCITEST_BAR, test->barnum);
+		fprintf(stdout, "BAR%d:\t\t", test->barnum);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->legacyirq) {
+		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
+		fprintf(stdout, "LEGACY IRQ:\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->msinum > 0 && test->msinum <= 32) {
+		ret = ioctl(fd, PCITEST_MSI, test->msinum);
+		fprintf(stdout, "MSI%d:\t\t", test->msinum);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->write) {
+		ret = ioctl(fd, PCITEST_WRITE, test->size);
+		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->read) {
+		ret = ioctl(fd, PCITEST_READ, test->size);
+		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->copy) {
+		ret = ioctl(fd, PCITEST_COPY, test->size);
+		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	fflush(stdout);
+}
+
+int main(int argc, char **argv)
+{
+	int c;
+	struct pci_test *test;
+
+	test = calloc(1, sizeof(*test));
+	if (!test) {
+		perror("Fail to allocate memory for pci_test\n");
+		return -ENOMEM;
+	}
+
+	/* since '0' is a valid BAR number, initialize it to -1 */
+	test->barnum = -1;
+
+	/* set default size as 100KB */
+	test->size = 0x19000;
+
+	/* set default endpoint device */
+	test->device = "/dev/pci-endpoint-test.0";
+
+	while ((c = getopt(argc, argv, "D:b:m:lrwcs:")) != EOF)
+	switch (c) {
+	case 'D':
+		test->device = optarg;
+		continue;
+	case 'b':
+		test->barnum = atoi(optarg);
+		if (test->barnum < 0 || test->barnum > 5)
+			goto usage;
+		continue;
+	case 'l':
+		test->legacyirq = true;
+		continue;
+	case 'm':
+		test->msinum = atoi(optarg);
+		if (test->msinum < 1 || test->msinum > 32)
+			goto usage;
+		continue;
+	case 'r':
+		test->read = true;
+		continue;
+	case 'w':
+		test->write = true;
+		continue;
+	case 'c':
+		test->copy = true;
+		continue;
+	case 's':
+		test->size = strtoul(optarg, NULL, 0);
+		continue;
+	case '?':
+	case 'h':
+	default:
+usage:
+		fprintf(stderr,
+			"usage: %s [options]\n"
+			"Options:\n"
+			"\t-D <dev>		pci endpoint test device {default: /dev/pci-endpoint-test.0}\n"
+			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
+			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
+			"\t-r			Read buffer test\n"
+			"\t-w			Write buffer test\n"
+			"\t-c			Copy buffer test\n"
+			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			argv[0]);
+		return -EINVAL;
+	}
+
+	run_test(test);
+	return 0;
+}
-- 
1.7.9.5

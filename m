Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 69ED868589
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:03:51 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAAK3oKL013961
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:03:50 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAAK3ocs013952
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:03:50 +0900 (JST)
Message-ID: <4554DB20.9020200@am.sony.com>
Date: Fri, 10 Nov 2006 12:03:44 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 14/16] powerpc: add ps3 platform OS params support
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support to access the parameter data from the ps3pf other OS area of flash
memory.  The parameter data mainly holds user preferences like static ip
address, etc.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3pf/Makefile  |    2 
 arch/powerpc/platforms/ps3pf/os-area.c |  245 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3pf/setup.c   |    1 
 3 files changed, 247 insertions(+), 1 deletion(-)

Index: cell--common--6/arch/powerpc/platforms/ps3pf/Makefile
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/ps3pf/Makefile
+++ cell--common--6/arch/powerpc/platforms/ps3pf/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_PS3PF) += setup.o mm.o smp.o time.o hvcall.o htab.o repository.o
-obj-$(CONFIG_PS3PF) += interrupt.o exports.o
+obj-$(CONFIG_PS3PF) += interrupt.o exports.o os-area.o
Index: cell--common--6/arch/powerpc/platforms/ps3pf/os-area.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/os-area.c
@@ -0,0 +1,245 @@
+/*
+ * os-area.c - PS3 Platform OS data area.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include <asm/lmb.h>
+#include <asm/ps3pf.h>
+
+#include "platform.h"
+
+enum {
+	segment_size = 0x200,
+	ldr_format_raw = 0,
+	ldr_format_gzip = 1,
+	boot_flag_game_os = 0,
+	boot_flag_other_os = 1,
+	av_multi_out_ntsc = 0,
+	av_multi_out_pal_rgb = 1,
+	av_multi_out_pal_ycbcr = 2,
+	av_multi_out_secam = 3,
+	ctrl_button_o_is_yes = 0,
+	ctrl_button_x_is_yes = 1,
+};
+
+/**
+ * struct header - os area header segment.
+ * @magic_num: Always 'cell_ext_os_area'.
+ * @hdr_version: Header format version number.
+ * @os_region_offset: Segment number of os region.
+ * @bootloader_offset: Segment number of bootloader image.
+ * @ldr_format: ldr_format flag.
+ * @ldr_size: Size of bootloader image in bytes.
+ */
+
+struct header {
+	s8 magic_num[16];
+	u32 hdr_version;
+	u32 os_image_offset;
+	u32 bootloader_offset;
+	u32 _reserved_1;
+	u32 ldr_format;
+	u32 ldr_size;
+	u32 _reserved_2[6];
+} __attribute__ ((packed));
+
+/**
+ * struct params - os area params segment.
+ * @boot_flag: User preference of operating system.
+ * @num_params: Number of params in this (params) segment.
+ * @rtc_diff: Difference in seconds between 1970 and the ps3pf rtc value.
+ * @av_multi_out: User preference of AV output.
+ * @ctrl_button: User preference of controller button config.
+ * @static_ip_addr: User preference of static IP address.
+ * @network_mask: User preference of static network mask.
+ * @default_gateway: User preference of static default gateway.
+ * @dns_primary: User preference of static primary dns server.
+ * @dns_secondary: User preference of static secondary dns server.
+ *
+ * User preference of zero for static_ip_addr means use dhcp.
+ */
+
+struct params {
+	u32 boot_flag;
+	u32 _reserved_1[3];
+	u32 num_params;
+	u32 _reserved_2[3];
+	/* param 0 */
+	s64 rtc_diff;
+	u8 av_multi_out;
+	u8 ctrl_button;
+	u8 _reserved_3[6];
+	/* param 1 */
+	u8 static_ip_addr[4];
+	u8 network_mask[4];
+	u8 default_gateway[4];
+	u8 _reserved_4[4];
+	/* param 2 */
+	u8 dns_primary[4];
+	u8 dns_secondary[4];
+	u8 _reserved_5[8];
+} __attribute__ ((packed));
+
+/**
+ * struct os_params - Static working copies of data from the os area.
+ *
+ * For the convinience of the guest, the HV makes a copy of the os area in
+ * flash to a high address in the boot memory region and then puts that RAM
+ * address and the byte count into the repository for retreval by the guest.
+ * We copy the data we want into a static variable and allow the memory setup
+ * by the HV to be claimed by the lmb manager.
+ */
+
+struct os_params {
+	/* param 0 */
+	s64 rtc_diff;
+	unsigned int av_multi_out;
+	unsigned int ctrl_button;
+	/* param 1 */
+	u8 static_ip_addr[4];
+	u8 network_mask[4];
+	u8 default_gateway[4];
+	/* param 2 */
+	u8 dns_primary[4];
+	u8 dns_secondary[4];
+} static os_params;
+
+#define dump_header(_a) _dump_header(_a, __func__, __LINE__)
+static void _dump_header(const struct header __iomem *h, const char* func,
+	int line)
+{
+	pr_debug("%s:%d: h.magic_num:         '%s'\n", func, line,
+		h->magic_num);
+	pr_debug("%s:%d: h.hdr_version:       %u\n", func, line,
+		h->hdr_version);
+	pr_debug("%s:%d: h.os_image_offset:   %u\n", func, line,
+		h->os_image_offset);
+	pr_debug("%s:%d: h.bootloader_offset: %u\n", func, line,
+		h->bootloader_offset);
+	pr_debug("%s:%d: h.ldr_format:        %u\n", func, line,
+		h->ldr_format);
+	pr_debug("%s:%d: h.ldr_size:          %xh\n", func, line,
+		h->ldr_size);
+}
+
+#define dump_params(_a) _dump_params(_a, __func__, __LINE__)
+static void _dump_params(const struct params __iomem *p, const char* func,
+	int line)
+{
+	pr_debug("%s:%d: p.boot_flag:       %u\n", func, line, p->boot_flag);
+	pr_debug("%s:%d: p.num_params:      %u\n", func, line, p->num_params);
+	pr_debug("%s:%d: p.rtc_diff         %ld\n", func, line, p->rtc_diff);
+	pr_debug("%s:%d: p.av_multi_out     %u\n", func, line, p->av_multi_out);
+	pr_debug("%s:%d: p.ctrl_button:     %u\n", func, line, p->ctrl_button);
+	pr_debug("%s:%d: p.static_ip_addr:  %u.%u.%u.%u\n", func, line,
+		p->static_ip_addr[0], p->static_ip_addr[1],
+		p->static_ip_addr[2], p->static_ip_addr[3]);
+	pr_debug("%s:%d: p.network_mask:    %u.%u.%u.%u\n", func, line,
+		p->network_mask[0], p->network_mask[1],
+		p->network_mask[2], p->network_mask[3]);
+	pr_debug("%s:%d: p.default_gateway: %u.%u.%u.%u\n", func, line,
+		p->default_gateway[0], p->default_gateway[1],
+		p->default_gateway[2], p->default_gateway[3]);
+	pr_debug("%s:%d: p.dns_primary:     %u.%u.%u.%u\n", func, line,
+		p->dns_primary[0], p->dns_primary[1],
+		p->dns_primary[2], p->dns_primary[3]);
+	pr_debug("%s:%d: p.dns_secondary:   %u.%u.%u.%u\n", func, line,
+		p->dns_secondary[0], p->dns_secondary[1],
+		p->dns_secondary[2], p->dns_secondary[3]);
+}
+
+static int __init verify_header(const struct header *header)
+{
+	if (memcmp(header->magic_num, "cell_ext_os_area", 16)) {
+		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
+		return -1;
+	}
+
+	if (header->hdr_version != 1) {
+		pr_debug("%s:%d hdr_version failed\n", __func__, __LINE__);
+		return -1;
+	}
+
+	if (header->os_image_offset > header->bootloader_offset) {
+		pr_debug("%s:%d offsets failed\n", __func__, __LINE__);
+		return -1;
+	}
+
+	return 0;
+}
+
+int __init ps3pf_os_area_init(void)
+{
+	int result;
+	u64 lpar_addr;
+	unsigned int size;
+	struct header *header;
+	struct params *params;
+
+	result = ps3pf_repository_read_boot_dat_info(&lpar_addr, &size);
+
+	if (result) {
+		pr_debug("%s:%d ps3pf_repository_read_boot_dat_info failed\n",
+			__func__, __LINE__);
+		return result;
+	}
+
+	header = (struct header *)__va(lpar_addr);
+	params = (struct params *)__va(lpar_addr + segment_size);
+
+	result = verify_header(header);
+
+	if (result) {
+		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
+		dump_header(header);
+		return -EIO;
+	}
+
+	dump_header(header);
+	dump_params(params);
+
+	os_params.rtc_diff = params->rtc_diff;
+	os_params.av_multi_out = params->av_multi_out;
+	if (0) { /* currently not used */
+		os_params.ctrl_button = params->ctrl_button;
+		memcpy(os_params.static_ip_addr, params->static_ip_addr, 4);
+		memcpy(os_params.network_mask, params->network_mask, 4);
+		memcpy(os_params.default_gateway, params->default_gateway, 4);
+		memcpy(os_params.dns_secondary, params->dns_secondary, 4);
+	}
+
+	return result;
+}
+
+/**
+ * ps3pf_os_area_rtc_diff - Returns the ps3pf rtc diff value.
+ *
+ * The ps3pf rtc maintains a value that approximates seconds since
+ * 2000-01-01 00:00:00 UTC.  Returns the exact number of seconds from 1970 to
+ * 2000 when os_params.rtc_diff has not been properly set up.
+ */
+
+u64 ps3pf_os_area_rtc_diff(void)
+{
+	return os_params.rtc_diff ? os_params.rtc_diff : 946684800UL;
+}
Index: cell--common--6/arch/powerpc/platforms/ps3pf/setup.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/ps3pf/setup.c
+++ cell--common--6/arch/powerpc/platforms/ps3pf/setup.c
@@ -115,6 +115,7 @@
 
 	powerpc_firmware_features |= FW_FEATURE_LPAR;
 
+	ps3pf_os_area_init();
 	ps3pf_mm_init();
 	ps3pf_mm_vas_create(&htab_size);
 	ps3pf_hpte_init(htab_size);

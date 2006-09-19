Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17679.29206.548556.979379@cargo.ozlabs.ibm.com>
Date: Tue, 19 Sep 2006 14:29:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
In-Reply-To: <1158639740.32015.114.camel@localhost.localdomain>
References: <17679.25131.721027.405431@cargo.ozlabs.ibm.com>
	<1158639740.32015.114.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> Where do I get ops.h?

Oops... here it is.

Paul.

diff --git /dev/null b/arch/powerpc/boot/ops.h
--- /dev/null	2006-09-18 11:33:23.687982711 +1000
+++ b/arch/powerpc/boot/ops.h	2006-09-19 14:09:38.000000000 +1000
@@ -0,0 +1,100 @@
+/*
+ * Global definition of all the bootwrapper operations.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef _PPC_BOOT_OPS_H_
+#define _PPC_BOOT_OPS_H_
+
+#include "types.h"
+
+#define	COMMAND_LINE_SIZE	512
+#define	MAX_PATH_LEN		256
+#define	MAX_PROP_LEN		256 /* What should this be? */
+
+/* Platform specific operations */
+struct platform_ops {
+	void	(*fixups)(void);
+	void *	(*malloc)(u32 size);
+	void	(*free)(void *ptr, u32 size);
+	void	(*exit)(void);
+};
+extern struct platform_ops platform_ops;
+
+/* Device Tree operations */
+struct dt_ops {
+	void *	(*finddevice)(const char *name);
+	int	(*getprop)(const void *node, const char *name, void *buf,
+			const int buflen);
+	int	(*setprop)(const void *node, const char *name,
+			const void *buf, const int buflen);
+	u64	(*translate_addr)(const char *path, const u32 *in_addr,
+			const u32 addr_len);
+	void	(*call_kernel)(void *entry_addr, unsigned long a1,
+			unsigned long a2, void *promptr, void *sp);
+};
+extern struct dt_ops dt_ops;
+
+/* Console operations */
+struct console_ops {
+	int	(*open)(void);
+	void	(*write)(char *buf, int len);
+	void	(*edit_cmdline)(char *buf, int len);
+	void	(*close)(void);
+	void	*data;
+};
+extern struct console_ops console_ops;
+
+/* Serial console operations */
+struct serial_console_data {
+	int		(*open)(void);
+	void		(*putc)(unsigned char c);
+	unsigned char	(*getc)(void);
+	u8		(*tstc)(void);
+	void		(*close)(void);
+};
+
+extern int platform_init(void *promptr);
+extern void simple_alloc_init(void);
+extern void ft_init(void *dt_blob);
+extern int serial_console_init(void);
+
+static inline void *finddevice(const char *name)
+{
+	return (dt_ops.finddevice) ? dt_ops.finddevice(name) : NULL;
+}
+
+static inline int getprop(void *devp, const char *name, void *buf, int buflen)
+{
+	return (dt_ops.getprop) ? dt_ops.getprop(devp, name, buf, buflen) : -1;
+}
+
+static inline int setprop(void *devp, const char *name, void *buf, int buflen)
+{
+	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
+}
+
+static inline void *malloc(u32 size)
+{
+	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
+}
+
+static inline void free(void *ptr, u32 size)
+{
+	if (platform_ops.free)
+		platform_ops.free(ptr, size);
+}
+
+static inline void exit(void)
+{
+	if (platform_ops.exit)
+		platform_ops.exit();
+	for(;;);
+}
+
+#endif /* _PPC_BOOT_OPS_H_ */

Subject: Build issues with 2.6.0-test3
From: Gary Thomas <gary@mlbassoc.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F38DEC4.8050708@imc-berlin.de>
References: <3F33BC10.8060407@imc-berlin.de>
	 <3F33EADE.4010908@embeddededge.com>  <3F38DEC4.8050708@imc-berlin.de>
Content-Type: multipart/mixed; boundary="=-WcTWBjANnHkk6tah2nTa"
Message-Id: <1060696614.31273.419.camel@hermes>
Mime-Version: 1.0
Date: 12 Aug 2003 07:56:55 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-WcTWBjANnHkk6tah2nTa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm trying to build 2.6.0-test3 for some embedded boards and, as
reported before, there are compile problems.  The attached patches
fix these, but also bring up some questions:

* How best to handle optional support?  One of the patches fixes
  a problem of a missing system call (sys_pciconfig_iobase).  In
  this case, the platform I was building for has no PCI, so it's
  not configured in.  The way I fixed it was to conditionalize
  the syscall table.  An alternate way would be to have a module
  which is compiled if CONFIG_PCI is *not* set (or alternately
  have arch/ppc/kernel/pci.c always be compiled and export the
  appropriate functions that just return -ENOSYS).  Comments?
* I have a number of boards/platforms that I support that have
  not been moved into 2.6.  Can I just send patches for those
  as well?
* Has anyone succeeded in building & running 2.6 (or late 2.5)
  on any embedded boards (8xx/8260/405)?

Thanks.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates

--=-WcTWBjANnHkk6tah2nTa
Content-Disposition: attachment; filename=diffs
Content-Type: text/x-patch; name=diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: arch/ppc/8260_io/enet.c
===================================================================
RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/8260_io/enet.c,v
retrieving revision 1.1
diff -u -5 -p -r1.1 enet.c
--- arch/ppc/8260_io/enet.c	12 Aug 2003 12:18:15 -0000	1.1
+++ arch/ppc/8260_io/enet.c	12 Aug 2003 13:32:35 -0000
@@ -611,10 +611,11 @@ static void set_multicast_list(struct ne
 static int __init scc_enet_init(void)
 {
 	struct net_device *dev;
 	struct scc_enet_private *cep;
 	int i, j;
+        int err;
 	unsigned char	*eap;
 	unsigned long	mem_addr;
 	bd_t		*bd;
 	volatile	cbd_t		*bdp;
 	volatile	cpm8260_t	*cp;
Index: arch/ppc/8260_io/uart.c
===================================================================
RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/8260_io/uart.c,v
retrieving revision 1.1
diff -u -5 -p -r1.1 uart.c
--- arch/ppc/8260_io/uart.c	12 Aug 2003 12:18:15 -0000	1.1
+++ arch/ppc/8260_io/uart.c	12 Aug 2003 13:30:40 -0000
@@ -2389,11 +2389,11 @@ void kgdb_map_scc(void)
 	up->smc_mrblr = RX_BUF_SIZE;		/* receive buffer length */
 	up->smc_maxidl = RX_BUF_SIZE;
 }
 #endif

-static kdev_t serial_console_device(struct console *c)
+static struct tty_driver *serial_console_device(struct console *c, int *index)
 {
 	*index = c->index;
 	return serial_driver;
 }

Index: arch/ppc/kernel/misc.S
===================================================================
RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/kernel/misc.S,v
retrieving revision 1.1
diff -u -5 -p -r1.1 misc.S
--- arch/ppc/kernel/misc.S	12 Aug 2003 12:18:16 -0000	1.1
+++ arch/ppc/kernel/misc.S	12 Aug 2003 13:44:25 -0000
@@ -1326,13 +1326,19 @@ _GLOBAL(sys_call_table)
 	.long sys_truncate64
 	.long sys_ftruncate64
 	.long sys_stat64	/* 195 */
 	.long sys_lstat64
 	.long sys_fstat64
+#ifdef CONFIG_PCI
 	.long sys_pciconfig_read
 	.long sys_pciconfig_write
 	.long sys_pciconfig_iobase 	/* 200 */
+#else
+	.long sys_ni_syscall /* sys_pciconfig_read */
+	.long sys_ni_syscall /* sys_pciconfig_write */
+	.long sys_ni_syscall /* sys_pciconfig_iobase 	/* 200 */
+#endif
 	.long sys_ni_syscall		/* 201 - reserved - MacOnLinux - new */
 	.long sys_getdents64
 	.long sys_pivot_root
 	.long sys_fcntl64
 	.long sys_madvise	/* 205 */

--=-WcTWBjANnHkk6tah2nTa--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

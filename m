Subject: PATCH: removing a couple of proc references
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Tue, 4 Apr 2000 16:09:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000404060913.F001A505F0@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a small patch to Dan's 2.2.13-based kernel to remove a couple of /proc
references when configured to not use the /proc filesystem. It's the first of
a few patches I'll post to trim down the kernel for embedded systems a little:

Index: sw/linux/arch/ppc/8xx_io/uart.c
===================================================================
retrieving revision 1.3
diff -c -r1.3 uart.c
*** sw/linux/arch/ppc/8xx_io/uart.c	2000/03/10 02:01:18	1.3
--- sw/linux/arch/ppc/8xx_io/uart.c	2000/04/03 03:37:29
***************
*** 2365,2371 ****
--- 2365,2375 ----
  	serial_driver.start = rs_8xx_start;
  	serial_driver.hangup = rs_8xx_hangup;
  	serial_driver.wait_until_sent = rs_8xx_wait_until_sent;
+ #ifdef CONFIG_PROC_FS
  	serial_driver.read_proc = rs_8xx_read_proc;
+ #else
+ 	serial_driver.read_proc = NULL;
+ #endif

  	/*
  	 * The callout device is just like normal device except for
Index: sw/linux/arch/ppc/kernel/m8xx_setup.c
===================================================================
retrieving revision 1.1.1.3
diff -c -r1.1.1.3 m8xx_setup.c
*** sw/linux/arch/ppc/kernel/m8xx_setup.c	2000/03/10 01:11:11	1.1.1.3
--- sw/linux/arch/ppc/kernel/m8xx_setup.c	2000/04/03 03:37:29
***************
*** 475,481 ****
--- 475,485 ----
  	}

  	ppc_md.setup_arch     = m8xx_setup_arch;
+ #ifdef CONFIG_PROC_FS
  	ppc_md.setup_residual = m8xx_setup_residual;
+ #else
+ 	ppc_md.setup_residual = NULL;
+ #endif
  	ppc_md.get_cpuinfo    = NULL;
  	ppc_md.irq_cannonicalize = NULL;
  	ppc_md.init_IRQ       = m8xx_init_IRQ;
Index: sw/linux/drivers/char/misc.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 misc.c
*** sw/linux/drivers/char/misc.c	1999/12/30 05:57:11	1.1.1.1
--- sw/linux/drivers/char/misc.c	2000/04/03 03:37:29
***************
*** 184,192 ****
--- 184,194 ----

  int __init misc_init(void)
  {
+ #ifdef CONFIG_PROC_FS
  	proc_misc = create_proc_entry("misc", 0, 0);
  	if (proc_misc)
  		proc_misc->read_proc = misc_read_proc;
+ #endif
  #ifdef CONFIG_BUSMOUSE
  	bus_mouse_init();
  #endif

--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

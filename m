Date: Tue, 18 Sep 2001 22:28:48 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: IDE 1Gig Microdrive (Working!!)
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	andre@linux-ide.org, andre@suse.com
Message-id: <3BA82D10.5694BC63@acm.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_v7n+nm+mhbARio9Zb5TJAA)"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Boundary_(ID_v7n+nm+mhbARio9Zb5TJAA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

I have Ben H's 2.4.9 kernel and I have hacked up something which allows
the 1Gig Microdrive PCCard to work.

What I am wondering is, does my patch stand a chance of making it into
the tree?

>From what I can tell there is already some code to disable the IRQ on
the Card but I guess the 1Gig drive does not honor this.  So I am
disabling the IRQ at the processor.  It is my understanding that the IDE
maintainer will not accept this.  Of course I would put this flag into
the hwif or drive structure and not use a global like this but if I am
going to have to apply this patch for every kernel upgrade I will leave
it this way.

These are against Ben's latest rsync.  Any thoughts, would be
appreciated.

And Thanks so much for all your help again,
Ira Weiny
iweiny@acm.org

--Boundary_(ID_v7n+nm+mhbARio9Zb5TJAA)
Content-type: text/plain; charset=us-ascii; name=ide-cs.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ide-cs.patch

*** ./ide-cs.c	Sun Sep  9 17:35:01 2001
--- /usr/src/linux/drivers/ide/ide-cs.c	Sun Sep 16 08:15:36 2001
*************** int idecs_register (int arg1, int arg2,
*** 233,238 ****
--- 233,245 ----
          return ide_register_hw(&hw, NULL);
  }

+
+ extern int ide_disable_irq_on_probe;
+
  void ide_config(dev_link_t *link)
  {
      client_handle_t handle = link->handle;
*************** void ide_config(dev_link_t *link)
*** 334,339 ****
--- 341,351 ----
      if (link->io.NumPorts2)
  	release_region(link->io.BasePort2, link->io.NumPorts2);

+     ide_disable_irq_on_probe = 1;
+
      outb(0x02, ctl_base); // Set nIEN = disable device interrupts

      /* retry registration in case device is still spinning up */
*************** void ide_config(dev_link_t *link)
*** 352,357 ****
--- 364,375 ----
  	schedule_timeout(HZ/10);
      }

+     ide_disable_irq_on_probe = 0;
+
      if (hd < 0) {
  	printk(KERN_NOTICE "ide_cs: ide_register() at 0x%03x & 0x%03x"
  	       ", irq %u failed\n", io_base, ctl_base,

--Boundary_(ID_v7n+nm+mhbARio9Zb5TJAA)
Content-type: text/plain; charset=us-ascii; name=ide-probe.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ide-probe.patch

*** ./ide-probe.c	Sun Sep  9 17:35:01 2001
--- /usr/src/linux/drivers/ide/ide-probe.c	Tue Sep 18 20:48:25 2001
*************** static inline void do_identify (ide_driv
*** 176,181 ****
--- 176,183 ----
  	return;
  }

+ int ide_disable_irq_on_probe = 0;
+
  /*
   * try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
   * and waits for a response.  It also monitors irqs while this is
*************** static int actual_try_to_identify (ide_d
*** 213,223 ****
--- 215,234 ----
  	if ((cmd == WIN_PIDENTIFY))
  		OUT_BYTE(0,IDE_FEATURE_REG);	/* disable dma & overlap */

+         if (ide_disable_irq_on_probe == 1)
+         {
+            disable_irq(HWIF(drive)->irq);
+         }
+
  #if CONFIG_BLK_DEV_PDC4030
  	if (HWIF(drive)->chipset == ide_pdc4030) {
  		/* DC4030 hosted drives need their own identify... */
  		extern int pdc4030_identify(ide_drive_t *);
  		if (pdc4030_identify(drive)) {
+                         if (ide_disable_irq_on_probe == 1)
+                         {
+                                 enable_irq(HWIF(drive)->irq);
+                         }
  			return 1;
  		}
  	} else
*************** static int actual_try_to_identify (ide_d
*** 227,238 ****
--- 238,254 ----
  	timeout += jiffies;
  	do {
  		if (0 < (signed long)(jiffies - timeout)) {
+                         if (ide_disable_irq_on_probe == 1)
+                         {
+                                 enable_irq(HWIF(drive)->irq);
+                         }
  			return 1;	/* drive timed-out */
  		}
  		ide_delay_50ms();		/* give drive a breather */
  	} while (IN_BYTE(hd_status) & BUSY_STAT);

  	ide_delay_50ms();		/* wait for IRQ and DRQ_STAT */
+
  	if (OK_STAT(GET_STAT(),DRQ_STAT,BAD_R_STAT)) {
  		unsigned long flags;
  		__save_flags(flags);	/* local CPU only */
*************** static int actual_try_to_identify (ide_d
*** 242,248 ****
--- 258,272 ----
  		(void) GET_STAT();	/* clear drive IRQ */
  		__restore_flags(flags);	/* local CPU only */
  	} else
+         {
  		rc = 2;			/* drive refused ID */
+         }
+
+         if (ide_disable_irq_on_probe == 1)
+         {
+            enable_irq(HWIF(drive)->irq);
+         }
+
  	return rc;
  }


--Boundary_(ID_v7n+nm+mhbARio9Zb5TJAA)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

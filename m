Date: Tue, 23 Oct 2001 01:58:29 -0700
From: Till Straumann <Till.Straumann@TU-Berlin.de>
Subject: aha152x bugfix (1460 pccard, powerpc linux-2.4.12)
To: fischer@norbit.de
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Message-id: <3BD53135.11B90801@TU-Berlin.de>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_KWV/KFPcuWEGcZPo8DG52Q)"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dies ist eine mehrteilige Nachricht im MIME-Format.

--Boundary_(ID_KWV/KFPcuWEGcZPo8DG52Q)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: quoted-printable

Hi J=FCrgen.

Thank you very much for your aha52x driver which has been very
useful for me on my i386 notebook.

Now I'm riding PowerPC and while resolving a portability issue,
I came across a bug in the driver. Suggestions for solving the
problems are attached. The patch header also contains some
comments.

1) The PPC has more than 16 IRQs. This resulted in an overflow
   of a static table. The fix replaces the 'aha152x_host[NUM_IRQS]'
   by 'aha152x_host[MAX_HOSTS]' (MAX_HOSTS is currently limited to =

   2 anyway).

2) Due to 1) the driver didn't work properly and resulting in
   the routine aha152x_device_reset() timing out. In this case,
   however, the driver failed to remove the command from the
   ISSUE_SC queue which eventually crashed the system.

3) minor stuff.

4) I also have a question: Your driver allocates its IRQ with the
   SA_SHIRQ flag set. However, I can't see how the ISR actually
   implements IRQ sharing. I.e. shouldn't it check all known
   hosts to find out who (if any) actually rose the IRQ?

Thanks for the great work.

Regards

-- Till=

--Boundary_(ID_KWV/KFPcuWEGcZPo8DG52Q)
Content-type: text/plain; charset=us-ascii; name=aha152x.c.patch0
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=aha152x.c.patch0

Patch for drivers/scsi/aha152x.c

original version:

 * $Id: aha152x.c,v 2.4 2000/12/16 12:53:56 fischer Exp $

This patch (level 0) addresses the following issues:

  - The PowerPC (luckily) has more interrupts than 16.
    This resulted in an overrun of a statically allocated
    table with 16 entries.
  - Bugfix of the device_reset() routine which failed to
    properly remove a command struct from a queue resulting
    in a crash.
  - Some mdelays() (only when debugging enabled) seem to be
    too long for my G4 Powerbook [->crash].

Author: Till Straumann <Till.Straumann@TU-Berlin.de>, 10/22/2001

Test Platform: Apple Powerbook G4, Adaptec 1460 PC-card,
               linux-2.4.12-benh0,  pcmcia-cs-3.1.29.

Note: both, the kernel pcmcia drivers and the alternate pcmcmia-cs
      drivers have no extra implementation for the 1460 - they
      both rely on aha152x.c

*** aha152x.c.orig	Fri Oct 12 05:05:33 2001
--- aha152x.c	Tue Oct 23 00:48:18 2001
***************
*** 314,320 ****
  #define IRQ_MIN 9
  #define IRQ_MAX 12
  #endif
! #define IRQS    IRQ_MAX-IRQ_MIN+1

  enum {
  	not_issued	= 0x0001,	/* command not yet issued */
--- 314,334 ----
  #define IRQ_MIN 9
  #define IRQ_MAX 12
  #endif
!
! #if defined(__PPC)
! #include <asm/irq.h>
! #undef IRQ_MAX
! #define IRQ_MAX (NR_IRQS-1)
! #endif
!
! #ifdef CONFIG_ADB_PMU
! /* T. Straumann, 10/22/2001: My TiBook crashed due to the long
!  * delays. Maybe the PMU needs to be petted more frequently...
!  */
! #define SHOWQ_DELAY	do {} while(0)
! #else
! #define SHOWQ_DELAY	mdelay(1000)
! #endif

  enum {
  	not_issued	= 0x0001,	/* command not yet issued */
***************
*** 419,425 ****
  	char *conf;
  } setup[2];

! static struct Scsi_Host *aha152x_host[IRQS];

  /*
   * internal states of the host
--- 433,440 ----
  	char *conf;
  } setup[2];

! #define SLOTS	2	/* maximal 2 controllers supported */
! struct Scsi_Host *aha152x_host[SLOTS] = {0};

  /*
   * internal states of the host
***************
*** 943,952 ****

  static void swintr(int irqno, void *dev_id, struct pt_regs *regs)
  {
! 	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];

! 	if (!shpnt)
!         	printk(KERN_ERR "aha152x%d: catched software interrupt for unknown controller.\n", HOSTNO);

  	HOSTDATA(shpnt)->swint++;

--- 958,975 ----

  static void swintr(int irqno, void *dev_id, struct pt_regs *regs)
  {
! 	int i;
! 	struct Scsi_Host *shpnt;
!
! 	for (i=SLOTS-1; i>=0; i--) {
! 		if ((shpnt=aha152x_host[i]) && shpnt->irq == irqno)
! 			break;
! 	}

! 	if (i<0) {
!         	printk(KERN_ERR "aha152x%d: caught software interrupt for unknown controller.\n", HOSTNO);
! 		return;
! 	}

  	HOSTDATA(shpnt)->swint++;

***************
*** 968,974 ****
  #endif
  	tpnt->proc_name = "aha152x";

! 	for (i = 0; i < IRQS; i++)
  		aha152x_host[i] = (struct Scsi_Host *) NULL;

  	if (setup_count) {
--- 991,997 ----
  #endif
  	tpnt->proc_name = "aha152x";

! 	for (i = 0; i < SLOTS; i++)
  		aha152x_host[i] = (struct Scsi_Host *) NULL;

  	if (setup_count) {
***************
*** 1203,1212 ****

  	printk("detected %d controller(s)\n", setup_count);

  	for (i=0; i<setup_count; i++) {
  		struct Scsi_Host *shpnt;

! 		aha152x_host[setup[i].irq - IRQ_MIN] = shpnt =
  		    scsi_register(tpnt, sizeof(struct aha152x_hostdata));

  		if(!shpnt) {
--- 1226,1237 ----

  	printk("detected %d controller(s)\n", setup_count);

+ 	if (setup_count > SLOTS)
+ 		panic("aha152x panic: too many setups\n");
  	for (i=0; i<setup_count; i++) {
  		struct Scsi_Host *shpnt;

! 		aha152x_host[i] = shpnt =
  		    scsi_register(tpnt, sizeof(struct aha152x_hostdata));

  		if(!shpnt) {
***************
*** 1330,1336 ****
  			scsi_unregister(shpnt);
  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			aha152x_host[shpnt->irq - IRQ_MIN] = 0;
  			shpnt = 0;
  			continue;
  		}
--- 1355,1361 ----
  			scsi_unregister(shpnt);
  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			aha152x_host[i] = 0;
  			shpnt = 0;
  			continue;
  		}
***************
*** 1356,1362 ****

  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			aha152x_host[shpnt->irq - IRQ_MIN] = 0;
  			scsi_unregister(shpnt);
  			shpnt=NULL;
  			continue;
--- 1381,1387 ----

  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			aha152x_host[i] = 0;
  			scsi_unregister(shpnt);
  			shpnt=NULL;
  			continue;
***************
*** 1374,1380 ****
  			scsi_unregister(shpnt);
  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			shpnt = aha152x_host[shpnt->irq - IRQ_MIN] = 0;
  			continue;
  		}
  	}
--- 1399,1405 ----
  			scsi_unregister(shpnt);
  			registered_count--;
  			release_region(shpnt->io_port, IO_RANGE);
! 			shpnt = aha152x_host[i] = 0;
  			continue;
  		}
  	}
***************
*** 1573,1579 ****
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(DEBUG_LEAD "abort(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		mdelay(1000);
  	}
  #endif

--- 1598,1604 ----
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(DEBUG_LEAD "abort(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		SHOWQ_DELAY;
  	}
  #endif

***************
*** 1611,1619 ****

  static void timer_expired(unsigned long p)
  {
! 	struct semaphore *sem = (void *)p;

  	printk(KERN_INFO "aha152x: timer expired\n");
  	up(sem);
  }

--- 1636,1656 ----

  static void timer_expired(unsigned long p)
  {
! 	Scsi_Cmnd	 *SCpnt = (Scsi_Cmnd*)p;
! 	struct semaphore *sem = SCSEM(SCpnt);
! 	struct Scsi_Host *shpnt = SCpnt->host;

  	printk(KERN_INFO "aha152x: timer expired\n");
+ 	/* T. Straumann, 10/22/2001: we must remove the
+ 	 * command from the issued queue and free the
+ 	 * host_scribble data.
+ 	 */
+ 	if (remove_SC(&ISSUE_SC,SCpnt)) {
+ 		kfree(SCpnt->host_scribble);
+ 		SCpnt->host_scribble=0;
+ 	} else {
+ 		printk(KERN_ERR "aha152x: severe internal error; expired command not on ISSUED list\n");
+ 	}
  	up(sem);
  }

***************
*** 1634,1640 ****
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(INFO_LEAD "aha152x_device_reset(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		mdelay(1000);
  	}
  #endif

--- 1671,1677 ----
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(INFO_LEAD "aha152x_device_reset(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		SHOWQ_DELAY;
  	}
  #endif

***************
*** 1652,1664 ****
  	cmnd.request_bufflen = 0;

  	init_timer(&timer);
! 	timer.data     = (unsigned long) &sem;
  	timer.expires  = jiffies + 100*HZ;   /* 10s */
  	timer.function = (void (*)(unsigned long)) timer_expired;
- 	add_timer(&timer);

  	aha152x_internal_queue(&cmnd, &sem, resetting, 0, internal_done);

  	down(&sem);

  	del_timer(&timer);
--- 1689,1706 ----
  	cmnd.request_bufflen = 0;

  	init_timer(&timer);
! 	timer.data     = (unsigned long) &cmnd; /* T.Straumann; 10/22/2001: pass entire command */
  	timer.expires  = jiffies + 100*HZ;   /* 10s */
  	timer.function = (void (*)(unsigned long)) timer_expired;

  	aha152x_internal_queue(&cmnd, &sem, resetting, 0, internal_done);

+ 	/* T. Straumann, 10/22/2001. Add timer after queuing to make sure
+ 	 * the semaphore is in place.
+ 	 */
+
+ 	add_timer(&timer);
+
  	down(&sem);

  	del_timer(&timer);
***************
*** 1704,1714 ****
  	struct Scsi_Host *shpnt = SCpnt->host;
  	unsigned long flags;

  #if defined(AHA152X_DEBUG)
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(DEBUG_LEAD "aha152x_bus_reset(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		mdelay(1000);
  	}
  #endif

--- 1746,1757 ----
  	struct Scsi_Host *shpnt = SCpnt->host;
  	unsigned long flags;

+
  #if defined(AHA152X_DEBUG)
  	if(HOSTDATA(shpnt)->debug & debug_eh) {
  		printk(DEBUG_LEAD "aha152x_bus_reset(%p)", CMDINFO(SCpnt), SCpnt);
  		show_queues(shpnt);
! 		SHOWQ_DELAY;
  	}
  #endif

***************
*** 1867,1873 ****
  static void run(void)
  {
  	int i;
! 	for (i = 0; i < IRQS; i++) {
  		struct Scsi_Host *shpnt = aha152x_host[i];
  		if (shpnt && HOSTDATA(shpnt)->service) {
  			HOSTDATA(shpnt)->service=0;
--- 1910,1916 ----
  static void run(void)
  {
  	int i;
! 	for (i = 0; i < SLOTS; i++) {
  		struct Scsi_Host *shpnt = aha152x_host[i];
  		if (shpnt && HOSTDATA(shpnt)->service) {
  			HOSTDATA(shpnt)->service=0;
***************
*** 1881,1892 ****
   *
   */

  static void intr(int irqno, void *dev_id, struct pt_regs *regs)
  {
! 	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];

! 	if (!shpnt) {
! 		printk(KERN_ERR "aha152x: catched interrupt for unknown controller.\n");
  		return;
  	}

--- 1924,1948 ----
   *
   */

+ /* Till Straumann, 10/22/2001; FIXME: Hmm - the interrupt
+  *    was requested as SHIRQ. However, this handler doesn't
+  *    seem to implement interrupt sharing. It just serves
+  *    the first matching controller and doesn't bother
+  *    finding out if it's really the interrupt source...
+  */
+
  static void intr(int irqno, void *dev_id, struct pt_regs *regs)
  {
! 	int i;
! 	struct Scsi_Host *shpnt;
!
! 	for (i=SLOTS-1; i>=0; i--) {
! 		if ((shpnt=aha152x_host[i]) && shpnt->irq==irqno)
! 			break;
! 	}

! 	if (i<0) {
! 		printk(KERN_ERR "aha152x: caught interrupt for unknown controller.\n");
  		return;
  	}

***************
*** 3750,3756 ****
  	unsigned long flags;
  	int thislength;

! 	for (i = 0, shpnt = (struct Scsi_Host *) NULL; i < IRQS; i++)
  		if (aha152x_host[i] && aha152x_host[i]->host_no == hostno)
  			shpnt = aha152x_host[i];

--- 3806,3812 ----
  	unsigned long flags;
  	int thislength;

! 	for (i = 0, shpnt = (struct Scsi_Host *) NULL; i < SLOTS; i++)
  		if (aha152x_host[i] && aha152x_host[i]->host_no == hostno)
  			shpnt = aha152x_host[i];


--Boundary_(ID_KWV/KFPcuWEGcZPo8DG52Q)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

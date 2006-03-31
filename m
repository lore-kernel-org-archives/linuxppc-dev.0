Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FE58679E6
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 08:09:25 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VL9KMC004034
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 16:09:20 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VL9KfG206110
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 16:09:21 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2VL9KtP030197
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 16:09:20 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: whitespace cleanups
Date: Fri, 31 Mar 2006 15:09:25 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603311509.25712.nfont@austin.ibm.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is nothing but whitespace cleanup for eeh.c.  This removes spaces 
between function calls and their parameters, edits lines that are longer than 
80 characters and puts function return variables and function names on one 
line.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>


Index: nfont/kernel/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- nfont.orig/kernel/arch/powerpc/platforms/pseries/eeh.c      2006-03-31 
09:02:17.%N -0600
+++ nfont/kernel/arch/powerpc/platforms/pseries/eeh.c   2006-03-31 14:34:43.%N 
-0600
@@ -111,7 +111,7 @@ static unsigned long slot_resets;
 /* --------------------------------------------------------------- */
 /* Below lies the EEH event infrastructure */

-void eeh_slot_error_detail (struct pci_dn *pdn, int severity)
+void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 {
        int config_addr;
        unsigned long flags;
@@ -126,13 +126,10 @@ void eeh_slot_error_detail (struct pci_d
        if (pdn->eeh_pe_config_addr)
                config_addr = pdn->eeh_pe_config_addr;

-       rc = rtas_call(ibm_slot_error_detail,
-                      8, 1, NULL, config_addr,
-                      BUID_HI(pdn->phb->buid),
-                      BUID_LO(pdn->phb->buid), NULL, 0,
-                      virt_to_phys(slot_errbuf),
-                      eeh_error_buf_size,
-                      severity);
+       rc = rtas_call(ibm_slot_error_detail, 8, 1, NULL, config_addr,
+                      BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid),
+                      NULL, 0, virt_to_phys(slot_errbuf),
+                      eeh_error_buf_size, severity);

        if (rc == 0)
                log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
@@ -184,7 +181,7 @@ static inline unsigned long eeh_token_to
        return pa | (token & (PAGE_SIZE-1));
 }

-/**
+/**
  * Return the "partitionable endpoint" (pe) under which this device lies
  */
 struct device_node * find_device_pe(struct device_node *dn)
@@ -203,8 +200,7 @@ struct device_node * find_device_pe(stru
  *  and the slot is frozen, then the driver can deadlock in
  *  an interrupt context, which is bad.
  */
-
-static void __eeh_mark_slot (struct device_node *dn, int mode_flag)
+static void __eeh_mark_slot(struct device_node *dn, int mode_flag)
 {
        while (dn) {
                if (PCI_DN(dn)) {
@@ -217,13 +213,13 @@ static void __eeh_mark_slot (struct devi
                                dev->error_state = pci_channel_io_frozen;

                        if (dn->child)
-                               __eeh_mark_slot (dn->child, mode_flag);
+                               __eeh_mark_slot(dn->child, mode_flag);
                }
                dn = dn->sibling;
        }
 }

-void eeh_mark_slot (struct device_node *dn, int mode_flag)
+void eeh_mark_slot(struct device_node *dn, int mode_flag)
 {
        dn = find_device_pe (dn);

@@ -232,36 +228,36 @@ void eeh_mark_slot (struct device_node *
                dn = dn->parent;

        PCI_DN(dn)->eeh_mode |= mode_flag;
-       __eeh_mark_slot (dn->child, mode_flag);
+       __eeh_mark_slot(dn->child, mode_flag);
 }

-static void __eeh_clear_slot (struct device_node *dn, int mode_flag)
+static void __eeh_clear_slot(struct device_node *dn, int mode_flag)
 {
        while (dn) {
                if (PCI_DN(dn)) {
                        PCI_DN(dn)->eeh_mode &= ~mode_flag;
                        PCI_DN(dn)->eeh_check_count = 0;
                        if (dn->child)
-                               __eeh_clear_slot (dn->child, mode_flag);
+                               __eeh_clear_slot(dn->child, mode_flag);
                }
                dn = dn->sibling;
        }
 }

-void eeh_clear_slot (struct device_node *dn, int mode_flag)
+void eeh_clear_slot(struct device_node *dn, int mode_flag)
 {
        unsigned long flags;
        spin_lock_irqsave(&confirm_error_lock, flags);
-
+
        dn = find_device_pe (dn);
-
+
        /* Back up one, since config addrs might be shared */
        if (PCI_DN(dn) && PCI_DN(dn)->eeh_pe_config_addr)
                dn = dn->parent;

        PCI_DN(dn)->eeh_mode &= ~mode_flag;
        PCI_DN(dn)->eeh_check_count = 0;
-       __eeh_clear_slot (dn->child, mode_flag);
+       __eeh_clear_slot(dn->child, mode_flag);
        spin_unlock_irqrestore(&confirm_error_lock, flags);
 }

@@ -305,8 +301,8 @@ int eeh_dn_check_failure(struct device_n
            pdn->eeh_mode & EEH_MODE_NOCHECK) {
                ignored_check++;
 #ifdef DEBUG
-               printk ("EEH:ignored check (%x) for %s %s\n",
-                       pdn->eeh_mode, pci_name (dev), dn->full_name);
+               printk("EEH:ignored check (%x) for %s %s\n",
+                       pdn->eeh_mode, pci_name(dev), dn->full_name);
 #endif
                return 0;
        }
@@ -327,16 +323,17 @@ int eeh_dn_check_failure(struct device_n
        if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
                pdn->eeh_check_count ++;
                if (pdn->eeh_check_count >= EEH_MAX_FAILS) {
-                       printk (KERN_ERR "EEH: Device driver ignored %d bad 
reads, panicing\n",
-                               pdn->eeh_check_count);
+                       printk(KERN_ERR "EEH: Device driver ignored %d bad "
+                               "reads, panicing\n", pdn->eeh_check_count);
                        dump_stack();
-
+
                        /* re-read the slot reset state */
                        if (read_slot_reset_state(pdn, rets) != 0)
                                rets[0] = -1;   /* reset state unknown */

-                       /* If we are here, then we hit an infinite loop. Stop. 
*/
-                       panic("EEH: MMIO halt (%d) on device:%s\n", rets[0], 
pci_name(dev));
+                       /* If we're here, then we hit an infinite loop. Stop. 
*/+                       panic("EEH: MMIO halt (%d) on device:%s\n",
+                               rets[0], pci_name(dev));
                }
                goto dn_unlock;
        }
@@ -352,8 +349,8 @@ int eeh_dn_check_failure(struct device_n

        /* If the call to firmware failed, punt */
        if (ret != 0) {
-               printk(KERN_WARNING "EEH: read_slot_reset_state() failed; 
rc=%d dn=%s\n",
-                      ret, dn->full_name);
+               printk(KERN_WARNING "EEH: read_slot_reset_state() failed; "
+                       "rc=%d dn=%s\n", ret, dn->full_name);
                false_positives++;
                rc = 0;
                goto dn_unlock;
@@ -361,8 +358,8 @@ int eeh_dn_check_failure(struct device_n

        /* If EEH is not supported on this device, punt. */
        if (rets[1] != 1) {
-               printk(KERN_WARNING "EEH: event on unsupported device, rc=%d 
dn=%s\n",
-                      ret, dn->full_name);
+               printk(KERN_WARNING "EEH: event on unsupported device, rc=%d "
+                       "dn=%s\n", ret, dn->full_name);
                false_positives++;
                rc = 0;
                goto dn_unlock;
@@ -384,11 +381,11 @@ int eeh_dn_check_failure(struct device_n
        }

        slot_resets++;
-
+
        /* Avoid repeated reports of this failure, including problems
         * with other functions on this device, and functions under
         * bridges. */
-       eeh_mark_slot (dn, EEH_MODE_ISOLATED);
+       eeh_mark_slot(dn, EEH_MODE_ISOLATED);
        spin_unlock_irqrestore(&confirm_error_lock, flags);

        state = pci_channel_io_normal;
@@ -396,12 +393,13 @@ int eeh_dn_check_failure(struct device_n
                state = pci_channel_io_frozen;
        if (rets[0] == 5)
                state = pci_channel_io_perm_failure;
-       eeh_send_failure_event (dn, dev, state, rets[2]);
+       eeh_send_failure_event(dn, dev, state, rets[2]);

        /* Most EEH events are due to device driver bugs.  Having
         * a stack trace will help the device-driver authors figure
         * out what happened.  So print that out. */
-       if (rets[0] != 5) dump_stack();
+       if (rets[0] != 5)
+               dump_stack();
        return 1;

 dn_unlock:
@@ -438,7 +436,7 @@ unsigned long eeh_check_failure(const vo
        }

        dn = pci_device_to_OF_node(dev);
-       eeh_dn_check_failure (dn, dev);
+       eeh_dn_check_failure(dn, dev);

        pci_dev_put(dev);
        return val;
@@ -453,26 +451,29 @@ EXPORT_SYMBOL(eeh_check_failure);
  * a number of milliseconds to wait until the PCI slot is
  * ready to be used.
  */
-static int
-eeh_slot_availability(struct pci_dn *pdn)
+static int eeh_slot_availability(struct pci_dn *pdn)
 {
        int rc;
        int rets[3];

        rc = read_slot_reset_state(pdn, rets);

-       if (rc) return rc;
+       if (rc)
+               return rc;

-       if (rets[1] == 0) return -1;  /* EEH is not supported */
-       if (rets[0] == 0) return 0;   /* Oll Korrect */
+       if (rets[1] == 0)
+               return -1;  /* EEH is not supported */
+       if (rets[0] == 0)
+               return 0;   /* Oll Korrect */
        if (rets[0] == 5) {
-               if (rets[2] == 0) return -1; /* permanently unavailable */
+               if (rets[2] == 0)
+                       return -1; /* permanently unavailable */
                return rets[2]; /* number of millisecs to wait */
        }
        if (rets[0] == 1)
                return 250;

-       printk (KERN_ERR "EEH: Slot unavailable: rc=%d, rets=%d %d %d\n",
+       printk(KERN_ERR "EEH: Slot unavailable: rc=%d, rets=%d %d %d\n",
                rc, rets[0], rets[1], rets[2]);
        return -1;
 }
@@ -486,18 +487,16 @@ eeh_slot_availability(struct pci_dn *pdn
  * safe to call in an interrupt context.
  *
  */
-
-static void
-rtas_pci_slot_reset(struct pci_dn *pdn, int state)
+static void rtas_pci_slot_reset(struct pci_dn *pdn, int state)
 {
        int config_addr;
        int rc;

-       BUG_ON (pdn==NULL);
+       BUG_ON (pdn==NULL);

        if (!pdn->phb) {
-               printk (KERN_WARNING "EEH: in slot reset, device node %s has 
no phb\n",
-                       pdn->node->full_name);
+               printk(KERN_WARNING "EEH: in slot reset, device node %s "
+                       "has no phb\n", pdn->node->full_name);
                return;
        }

@@ -506,14 +505,13 @@ rtas_pci_slot_reset(struct pci_dn *pdn,
        if (pdn->eeh_pe_config_addr)
                config_addr = pdn->eeh_pe_config_addr;

-       rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
-                      config_addr,
-                      BUID_HI(pdn->phb->buid),
-                      BUID_LO(pdn->phb->buid),
+       rc = rtas_call(ibm_set_slot_reset,4,1, NULL, config_addr,
+                      BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid),
                       state);
        if (rc) {
-               printk (KERN_WARNING "EEH: Unable to reset the failed slot, 
(%d) #RST=%d dn=%s\n",
-                       rc, state, pdn->node->full_name);
+               printk(KERN_WARNING "EEH: Unable to reset the failed slot, "
+                       "(%d) #RST=%d dn=%s\n", rc, state,
+                       pdn->node->full_name);
                return;
        }
 }
@@ -523,39 +521,38 @@ rtas_pci_slot_reset(struct pci_dn *pdn,
  *
  *  Return 0 if success, else a non-zero value.
  */
-
-int
-rtas_set_slot_reset(struct pci_dn *pdn)
+int rtas_set_slot_reset(struct pci_dn *pdn)
 {
        int i, rc;

-       rtas_pci_slot_reset (pdn, 1);
+       rtas_pci_slot_reset(pdn, 1);

        /* The PCI bus requires that the reset be held high for at least
         * a 100 milliseconds. We wait a bit longer 'just in case'.  */

 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
-       msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
-
-       /* We might get hit with another EEH freeze as soon as the
+       msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
+
+       /* We might get hit with another EEH freeze as soon as the
         * pci slot reset line is dropped. Make sure we don't miss
         * these, and clear the flag now. */
-       eeh_clear_slot (pdn->node, EEH_MODE_ISOLATED);
+       eeh_clear_slot(pdn->node, EEH_MODE_ISOLATED);

-       rtas_pci_slot_reset (pdn, 0);
+       rtas_pci_slot_reset(pdn, 0);

        /* After a PCI slot has been reset, the PCI Express spec requires
         * a 1.5 second idle time for the bus to stabilize, before starting
         * up traffic. */
 #define PCI_BUS_SETTLE_TIME_MSEC 1800
-       msleep (PCI_BUS_SETTLE_TIME_MSEC);
+       msleep(PCI_BUS_SETTLE_TIME_MSEC);

        /* Now double check with the firmware to make sure the device is
         * ready to be used; if not, wait for recovery. */
-       for (i=0; i<10; i++) {
-               rc = eeh_slot_availability (pdn);
+       for (i = 0; i < 10; i++) {
+               rc = eeh_slot_availability(pdn);
                if (rc < 0)
-                       printk (KERN_ERR "EEH: failed (%d) to reset slot 
%s\n", rc, pdn->node->full_name);
+                       printk(KERN_ERR "EEH: failed (%d) to reset slot %s\n",
+                               rc, pdn->node->full_name);
                if (rc == 0)
                        return 0;
                if (rc < 0)
@@ -564,9 +561,10 @@ rtas_set_slot_reset(struct pci_dn *pdn)
                msleep (rc+100);
        }

-       rc = eeh_slot_availability (pdn);
+       rc = eeh_slot_availability(pdn);
        if (rc)
-               printk (KERN_ERR "EEH: timeout resetting slot %s\n", 
pdn->node->full_name);
+               printk(KERN_ERR "EEH: timeout resetting slot %s\n",
+                       pdn->node->full_name);

        return rc;
 }
@@ -577,7 +575,7 @@ rtas_set_slot_reset(struct pci_dn *pdn)
  * Although firmware will set up BARs during boot, it doesn't
  * set up device BAR's after a device reset, although it will,
  * if requested, set up bridge configuration. Thus, we need to
- * configure the PCI devices ourselves.
+ * configure the PCI devices ourselves.
  */

 /**
@@ -586,12 +584,14 @@ rtas_set_slot_reset(struct pci_dn *pdn)
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
  */
-static inline void __restore_bars (struct pci_dn *pdn)
+static inline void __restore_bars(struct pci_dn *pdn)
 {
        int i;

-       if (NULL==pdn->phb) return;
-       for (i=4; i<10; i++) {
+       if (NULL==pdn->phb)
+               return;
+
+       for (i = 4; i < 10; i++) {
                rtas_write_config(pdn, i*4, 4, pdn->config_space[i]);
        }

@@ -601,11 +601,11 @@ static inline void __restore_bars (struc
 #define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
 #define SAVED_BYTE(OFF) (((u8 *)(pdn->config_space))[BYTE_SWAP(OFF)])

-       rtas_write_config (pdn, PCI_CACHE_LINE_SIZE, 1,
-                   SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+       rtas_write_config(pdn, PCI_CACHE_LINE_SIZE, 1,
+                         SAVED_BYTE(PCI_CACHE_LINE_SIZE));

-       rtas_write_config (pdn, PCI_LATENCY_TIMER, 1,
-                   SAVED_BYTE(PCI_LATENCY_TIMER));
+       rtas_write_config(pdn, PCI_LATENCY_TIMER, 1,
+                         SAVED_BYTE(PCI_LATENCY_TIMER));

        /* max latency, min grant, interrupt pin and line */
        rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
@@ -620,15 +620,15 @@ static inline void __restore_bars (struc
 void eeh_restore_bars(struct pci_dn *pdn)
 {
        struct device_node *dn;
-       if (!pdn)
+       if (!pdn)
                return;
-
+
        if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) 
&& !IS_BRIDGE(pdn->class_code))-               __restore_bars (pdn);
+               __restore_bars(pdn);

        dn = pdn->node->child;
        while (dn) {
-               eeh_restore_bars (PCI_DN(dn));
+               eeh_restore_bars(PCI_DN(dn));
                dn = dn->sibling;
        }
 }
@@ -645,9 +645,9 @@ static void eeh_save_bars(struct pci_dn
 {
        int i;

-       if (!pdn )
+       if (!pdn)
                return;
-
+
        for (i = 0; i < 16; i++)
                rtas_read_config(pdn, i * 4, 4, &pdn->config_space[i]);
 }
@@ -663,13 +663,11 @@ rtas_configure_bridge(struct pci_dn *pdn
        if (pdn->eeh_pe_config_addr)
                config_addr = pdn->eeh_pe_config_addr;

-       rc = rtas_call(ibm_configure_bridge,3,1, NULL,
-                      config_addr,
-                      BUID_HI(pdn->phb->buid),
-                      BUID_LO(pdn->phb->buid));
+       rc = rtas_call(ibm_configure_bridge,3,1, NULL, config_addr,
+                      BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid));
        if (rc) {
-               printk (KERN_WARNING "EEH: Unable to configure device bridge 
(%d) for %s\n",
-                       rc, pdn->node->full_name);
+               printk(KERN_WARNING "EEH: Unable to configure device bridge "
+                       "(%d) for %s\n", rc, pdn->node->full_name);
        }
 }

@@ -750,31 +748,35 @@ static void *early_enable_eeh(struct dev
                        pdn->eeh_mode |= EEH_MODE_SUPPORTED;
                        pdn->eeh_config_addr = regs[0];

-                       /* If the newer, better, ibm,get-config-addr-info is 
supported,
-                        * then use that instead. */
+                       /* If the newer, better, ibm,get-config-addr-info
+                        * is supported, then use that instead. */
                        pdn->eeh_pe_config_addr = 0;
                        if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) 
{
                                unsigned int rets[2];
-                               ret = rtas_call (ibm_get_config_addr_info, 4, 
2, rets,
-                                       pdn->eeh_config_addr,
-                                       info->buid_hi, info->buid_lo,
-                                       0);
+                               ret = rtas_call(ibm_get_config_addr_info, 4, 
2,
+                                               rets, pdn->eeh_config_addr,
+                                               info->buid_hi, info->buid_lo,
+                                               0);
                                if (ret == 0)
                                        pdn->eeh_pe_config_addr = rets[0];
                        }
 #ifdef DEBUG
-                       printk(KERN_DEBUG "EEH: %s: eeh enabled, config=%x 
pe_config=%x\n",
-                              dn->full_name, pdn->eeh_config_addr, 
pdn->eeh_pe_config_addr);
+                       printk(KERN_DEBUG "EEH: %s: eeh enabled, config=%x "
+                               "pe_config=%x\n", dn->full_name,
+                               pdn->eeh_config_addr, 
pdn->eeh_pe_config_addr);
 #endif
                } else {

                        /* This device doesn't support EEH, but it may have an
                         * EEH parent, in which case we mark it as supported. 
*/                        if (dn->parent && PCI_DN(dn->parent)
-                           && (PCI_DN(dn->parent)->eeh_mode & 
EEH_MODE_SUPPORTED)) {
+                           && (PCI_DN(dn->parent)->eeh_mode
+                               & EEH_MODE_SUPPORTED)) {
+
                                /* Parent supports EEH. */
                                pdn->eeh_mode |= EEH_MODE_SUPPORTED;
-                               pdn->eeh_config_addr = 
PCI_DN(dn->parent)->eeh_config_addr;
+                               pdn->eeh_config_addr =
+                                       PCI_DN(dn->parent)->eeh_config_addr;
                                return NULL;
                        }
                }
@@ -818,7 +820,7 @@ void __init eeh_init(void)
        ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
        ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
        ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
-       ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
+       ibm_configure_bridge = rtas_token("ibm,configure-bridge");

        if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
                return;
@@ -828,8 +830,9 @@ void __init eeh_init(void)
                eeh_error_buf_size = 1024;
        }
        if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
-               printk(KERN_WARNING "EEH: rtas-error-log-max is bigger than 
allocated "
-                     "buffer ! (%d vs %d)", eeh_error_buf_size, 
RTAS_ERROR_LOG_MAX);
+               printk(KERN_WARNING "EEH: rtas-error-log-max is bigger than "
+                       "allocated buffer ! (%d vs %d)", eeh_error_buf_size,
+                       RTAS_ERROR_LOG_MAX);
                eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
        }

@@ -848,7 +851,8 @@ void __init eeh_init(void)
        }

        if (eeh_subsystem_enabled)
-               printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling 
Enabled\n");
+               printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling "
+                       "Enabled\n");
        else
                printk(KERN_WARNING "EEH: No capable adapters found\n");
 }
@@ -925,12 +929,12 @@ static void eeh_add_device_late(struct p
        printk(KERN_DEBUG "EEH: adding device %s\n", pci_name(dev));
 #endif

-       pci_dev_get (dev);
+       pci_dev_get(dev);
        dn = pci_device_to_OF_node(dev);
        pdn = PCI_DN(dn);
        pdn->pcidev = dev;

-       pci_addr_cache_insert_device (dev);
+       pci_addr_cache_insert_device(dev);
 }

 /**
@@ -957,7 +961,7 @@ static void eeh_remove_device(struct pci

        dn = pci_device_to_OF_node(dev);
        PCI_DN(dn)->pcidev = NULL;
-       pci_dev_put (dev);
+       pci_dev_put(dev);
 }

 void eeh_remove_bus_device(struct pci_dev *dev)
@@ -990,9 +994,9 @@ static int proc_eeh_show(struct seq_file
                                "eeh_false_positives=%ld\n"
                                "eeh_ignored_failures=%ld\n"
                                "eeh_slot_resets=%ld\n",
-                               no_device, no_dn, no_cfg_addr,
-                               ignored_check, total_mmio_ffs,
-                               false_positives, ignored_failures,
+                               no_device, no_dn, no_cfg_addr,
+                               ignored_check, total_mmio_ffs,
+                               false_positives, ignored_failures,
                                slot_resets);
        }

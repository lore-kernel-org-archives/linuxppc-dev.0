Message-Id: <l03130300b359276d80de@[192.168.10.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 7 May 1999 17:48:43 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Stephen Edie <sedie@terraplex.com>
Subject: Yosemite patches
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have been quietly working on Linux kernel support the Blue G3 during the
last month or so.  I am usually quite busy with other things, so my
accomplishments have been limited.  A couple of weeks ago, Terra Soft
Solutions released a binary kernel and a couple of broken .DIFF patches to
their download site.  Under the advice of Cort and others, I have
re-written the PCI IDE support and re-formatted the remaining changes so
that they apply cleanly to the 2.2.6 and 2.2.7 kernels.

A number of people have reported hangs when using the binary kernel.  The
clean patch appears to have resolved the hangs, although, I can not be
certain that this is the case as the machine I am testing it on only
experienced these hangs once in a while.  We are in the process of building
a new binary with the clean patches as well as USB support.

I regret having procrastinated the clean up and release, but anyway, the
patches are include with this message.  I would appreciate it if the
ide-pmac.c guys would take a look at the IDE code.  The old PCI IDE patch
hacked around with the PCI IDE source code which I didn't like.  The new
patch provided here only modifies source files that are PPC specific.  The
generic IDE chain appears to be functioning properly with this patch,
although, I don't have a wide range of machines to test it on.

There are three patches in all.  Please apply each of them in order as two
of the patches update the same file.  (ide-pmac.c)  Again, these patches
apply cleanly to both 2.2.6 and 2.2.7 kernels.

blueg3-pci-2.2.6.diff:
Fixes the PCI probing/machine check problem

blueg3-extra-2.2.6.diff:
Additional patches provided in the original "challanger" .DIFFs.  Some of
these changes may improve the stability of the Pmac.  You should apply this
before applying the patch below.

blueg3-ide-2.2.6.diff:
Modifications which allow the IDE PCI drivers, including the CMD646 driver,
to work properely.

Thanks to those on this list whose contributions made Linux on the BlueG3 a
reality!  From here on, I will be keeping in touch.


Sincerely,
Stephen

Terra Soft Solutions, Inc.
http://www.yellowdoglinux.com


--- arch/ppc/kernel/pmac_pci.c.orig     Mon May  3 13:45:50 1999
+++ arch/ppc/kernel/pmac_pci.c  Mon May  3 13:45:14 1999
@@ -361,6 +361,7 @@
 {
        int bus;
        struct bridge_data *bridge;
+       struct device_node *p2pbridge;

        bridge_list = 0;
        max_bus = 0;
@@ -373,6 +374,28 @@
        for (bridge = bridge_list; bridge != NULL; bridge = bridge->next)
                for (bus = bridge->bus_number; bus <= bridge->max_bus; ++bus)
                        bridges[bus] = bridge;
+
+       if((p2pbridge = find_devices("pci-bridge")) &&
!strcmp(p2pbridge->parent->name, "pci")) {
+               unsigned char devfn, offset;
+               unsigned short val;
+
+               if(!pci_device_loc(p2pbridge, &bus, &devfn)) {
+#if 0
+                       unsigned int lval;
+                       printk("P2P bridge configuration space register
dump:\n");
+                       for(offset = 0; offset <= 0x40; offset += 4) {
+                               grackle_pcibios_read_config_dword(0, devfn,
offset, &lval);
+                               printk("0x%02x: 0x%08x\n", offset, lval);
+                       }
+                       printk("\n");
+#endif
+
+                       grackle_pcibios_read_config_word(0, devfn,
PCI_BRIDGE_CONTROL, &val);
+                       val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
+                       grackle_pcibios_write_config_word(0, devfn,
PCI_BRIDGE_CONTROL, val);
+                       grackle_pcibios_read_config_word(0, devfn,
PCI_BRIDGE_CONTROL, &val);
+               }
+       }

        return mem_start;
 }




--- arch/ppc/kernel/prom.c.orig Mon May  3 14:18:56 1999
+++ arch/ppc/kernel/prom.c      Mon May  3 13:52:53 1999
@@ -334,7 +334,8 @@
                         */
                        model = (char *) early_get_property
                                (r4 + bi->deviceTreeOffset, 4, RELOC("model"));
-                       if (model && strcmp(model, RELOC("iMac,1")) == 0) {
+                       if (model && (strcmp(model, RELOC("iMac,1")) == 0 ||
+                                     strcmp(model, RELOC("PowerMac1,1"))
== 0)) {
                                out_le32((unsigned *)0x80880008, 1);    /*
XXX */
                        }
                }
@@ -870,11 +871,14 @@
            && (imp = (struct pci_intr_map *)
                get_property(np->parent, "interrupt-map", &ml)) != 0
            && (ip = (int *) get_property(np, "interrupts", &l)) != 0) {
-               unsigned int busdevfn = pci_addrs[0].addr.a_hi & 0xffff00;
+         /* P2P bridge's interrupt map contains no bus number */
+         /*    unsigned int busdevfn = pci_addrs[0].addr.a_hi & 0xffff00; */
+               unsigned int devfn = pci_addrs[0].addr.a_hi & 0x00ff00;
+
                np->n_intrs = 0;
                np->intrs = (struct interrupt_info *) mem_start;
                for (i = 0; (ml -= sizeof(struct pci_intr_map)) >= 0; ++i) {
-                       if (imp[i].addr.a_hi == busdevfn) {
+                       if (imp[i].addr.a_hi == devfn) {
                                np->intrs[np->n_intrs].line = imp[i].intr;
                                np->intrs[np->n_intrs].sense = 0;
                                ++np->n_intrs;
--- arch/ppc/kernel/traps.c.orig        Mon May  3 14:18:49 1999
+++ arch/ppc/kernel/traps.c     Thu Apr 29 11:24:46 1999
@@ -85,9 +85,29 @@
        force_sig(signr, current);
 }

+#if 1
+static inline void __notify(unsigned long pat, unsigned long offset)
+{
+  int i, *ptr;
+
+  if(offset >= 0x00400000)
+    offset = 0;
+  ptr = (int *)(0x88400000 + offset);
+
+  for(i = 0; i < 0x00001000; i++)
+    ptr[i] = pat;
+}
+#endif
+
 void
 MachineCheckException(struct pt_regs *regs)
 {
+#if 1
+  static int ext = 0;
+
+  __notify(0x0000ff00, ext*0x8000);
+  ++ext;
+#endif
        if ( !user_mode(regs) )
        {
 #ifdef CONFIG_MBX
@@ -121,7 +141,14 @@
                        break;
                default:
                        printk("Unknown values in msr\n");
+#if 1
+                       __notify(0xff000000, ext*0x8000);
+                       ++ext;
+#endif
                }
+#if 1
+               return;
+#endif
                show_regs(regs);
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
                debugger(regs);
--- arch/ppc/mm/init.c.orig     Fri Mar 19 03:50:04 1999
+++ arch/ppc/mm/init.c  Mon May  3 13:57:36 1999
@@ -1003,6 +1003,8 @@
                        if (macio && macio->n_addrs)
                                base = macio->addrs[0].address;
                        setbat(0, base, base, 0x100000, IO_PAGE);
+                       /* ATY, Rage 128y LE aperture for debug purposes */
+                       setbat(1, 0x88000000, 0x88000000, 0x01000000,
RAM_PAGE);
                        ioremap_base = 0xf0000000;
                }
                break;
--- drivers/block/ide-pmac.c.orig       Mon May  3 14:24:12 1999
+++ drivers/block/ide-pmac.c    Mon May  3 14:23:55 1999
@@ -142,6 +142,18 @@
        *pp = removables;

        for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
+               struct device_node *tp;
+               int hosted_by_mac_io;
+
+               for (tp = np->parent, hosted_by_mac_io = 0; tp; tp =
tp->parent)
+                 if (tp->type &&
+                     (!strcmp(tp->type, "mac-io") || !strcmp(tp->type,
"dbdma"))) {
+                         hosted_by_mac_io = 1;
+                         break;
+                 }
+               if (!hosted_by_mac_io)
+                   continue;
+
                if (np->n_addrs == 0) {
                        printk(KERN_WARNING "ide: no address for device %s\n",
                               np->full_name);
--- drivers/scsi/aic7xxx.c.orig Thu Apr 22 13:15:49 1999
+++ drivers/scsi/aic7xxx.c      Mon May  3 14:29:10 1999
@@ -9020,6 +9020,10 @@
               PCI_SLOT(temp_p->pci_device_fn),
               PCI_FUNC(temp_p->pci_device_fn));
             printk("aic7xxx: Controller disabled by BIOS, ignoring.\n");
+#if 1
+           printk("io_base = 0x%08x, mem_base = 0x%08x, irq = %d\n",
+                  temp_p->base, temp_p->mbase, temp_p->irq);
+#endif
             kfree(temp_p);
             temp_p = NULL;
             continue;




--- include/asm-ppc/ide.h.orig  Mon May  3 14:54:20 1999
+++ include/asm-ppc/ide.h       Mon May  3 14:58:05 1999
@@ -52,7 +52,9 @@
 #define insw(port, buf, ns)    do {                            \
        if ( _machine & (_MACH_chrp|_MACH_mbx) )                \
                 ide_insw((port)+_IO_BASE, (buf), (ns));        \
-       else if ( _machine & (_MACH_Pmac|_MACH_apus) )          \
+       else if ( _machine & (_MACH_Pmac) )                     \
+                ide_insw((port)+_IO_BASE, (buf), (ns));        \
+       else if ( _machine & (_MACH_apus) )                     \
                 ide_insw((port), (buf), (ns));                 \
        else                                                    \
                /* this must be the same as insw in io.h!! */   \
@@ -63,7 +65,9 @@
 #define outsw(port, buf, ns)   do {                            \
        if ( _machine & (_MACH_chrp|_MACH_mbx) )                \
                ide_outsw((port)+_IO_BASE, (buf), (ns));        \
-       else if ( _machine & (_MACH_Pmac|_MACH_apus) )          \
+       else if ( _machine & (_MACH_Pmac) )                     \
+               ide_outsw((port)+_IO_BASE, (buf), (ns));        \
+       else if ( _machine * (_MACH_apus) )                     \
                ide_outsw((port), (buf), (ns));                 \
        else                                                    \
                /* this must be the same as outsw in io.h!! */  \
@@ -261,17 +265,9 @@
        }
 }

-#undef inb
-#define inb(port)      \
-       in_8((unsigned char *)((port) + \
-                              ((_machine==_MACH_Pmac)? 0: _IO_BASE) ) )
 #undef inb_p
 #define inb_p(port)    inb(port)

-#undef outb
-#define outb(val, port)        \
-       out_8((unsigned char *)((port) + \
-                               ((_machine==_MACH_Pmac)? 0: _IO_BASE) ),
(val) )
 #undef outb_p
 #define outb_p(val, port)      outb(val, port)

--- drivers/block/ide-pmac.c.orig       Mon May  3 14:35:44 1999
+++ drivers/block/ide-pmac.c    Mon May  3 14:44:27 1999
@@ -54,12 +54,27 @@
 };
 #endif /* CONFIG_PMAC_PBOOK */

+void
+pmac_ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base, int *irq)
+{
+       int i;
+
+       *p = 0;
+       if (base == 0)
+               return;
+
+       for(i = 0; i < 8; ++i)
+               *p++ = base + i;
+       *p = 0;
+}
+
+
 /*
  * N.B. this can't be an initfunc, because the media-bay task can
  * call ide_[un]register at any time.
  */
 void
-pmac_ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base, int *irq)
+pmac_ide_init_hwif_ports_nonpci(ide_ioreg_t *p, ide_ioreg_t base, int *irq)
 {
        int i, r;

@@ -141,26 +156,35 @@
        *rp = NULL;
        *pp = removables;

-       for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
+       for (i = 0, np = atas; i < MAX_HWIFS && np != NULL;) {
                struct device_node *tp;
                int hosted_by_mac_io;

+               if (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] != 0) {
+                       /* If the ide_hwifs[i] is already taken, (by
ide-pci.c for example) we skip it and try the next available. */
+                       i++;
+                       continue;
+               }
+
                for (tp = np->parent, hosted_by_mac_io = 0; tp; tp =
tp->parent)
                  if (tp->type &&
                      (!strcmp(tp->type, "mac-io") || !strcmp(tp->type,
"dbdma"))) {
                          hosted_by_mac_io = 1;
                          break;
                  }
-               if (!hosted_by_mac_io)
-                   continue;
+               if (!hosted_by_mac_io) {
+                       np = np->next;
+                       continue;
+               }

                if (np->n_addrs == 0) {
                        printk(KERN_WARNING "ide: no address for device %s\n",
                               np->full_name);
+                       np = np->next;
                        continue;
                }

-               base = (unsigned long) ioremap(np->addrs[0].address, 0x200);
+               base = (unsigned long) ioremap(np->addrs[0].address, 0x200)
- _IO_BASE;

                /* XXX This is bogus. Should be fixed in the registry by
checking
                   the kind of host interrupt controller, a bit like gatwick
@@ -184,7 +208,7 @@
                        feature_set(np, FEATURE_IDE_enable);

                hwif = &ide_hwifs[i];
-               pmac_ide_init_hwif_ports(hwif->io_ports, base, &hwif->irq);
+               pmac_ide_init_hwif_ports_nonpci(hwif->io_ports, base,
&hwif->irq);
                hwif->chipset = ide_generic;
                hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
                hwif->tuneproc = pmac_ide_tuneproc;
@@ -196,6 +220,7 @@
                }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */

+               np = np->next;
                ++i;
        }
        pmac_ide_count = i;



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

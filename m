Date: Mon, 29 Apr 2002 21:34:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Problem in pmac PCI fixup
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020428151609.30064@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-1020108890=:367"
Message-Id: <E172GvB-00007O-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-1020108890=:367
Content-Type: TEXT/plain; charset=us-ascii

Hi Ben,

On  28 Apr, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>--- linux-2.4.19-pre6-lvm-gentoo/arch/ppc/kernel/pmac_pci.c     Sun Apr
>>28 09:14:09 2002
>>+++ linux-2.4.16-planb/arch/ppc/kernel/pmac_pci.c       Sun Apr
>>28 17:18:39 2002
>>@@ -493,8 +503,6 @@
>>                unsigned char pin;
>>                struct device_node* node;
>>
>>-               if (pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) ||
>>!pin)
>>-                       continue; /* No interrupt generated -> no fixup */
>>                node = pci_device_to_OF_node(dev);
>>                if (!node) {
>>                        printk("No OF node for device %x:%x\n", dev->bus-
>>>number, dev->devfn >> 3);
>>
>>Anybody have any problem with that approach?
>
> No problem with that, it's actually what we do in chrp.

Good then, can you apply the attached patch to any kernel tree within
your reach :) ?

I'll send off the Plan diff privately to you (it's quite a few K in
size...).

Cheers, and thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-1020108890=:367
Content-Type: TEXT/plain; name="pci-irq.diff"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: attachment; filename="pci-irq.diff"

--- linux-2.4.19-pre6-lvm-gentoo/arch/ppc/kernel/pmac_pci.c=09Sun Apr 28 09=
:14:09 2002
+++ linux-2.4.16-planb/arch/ppc/kernel/pmac_pci.c=09Sun Apr 28 17:18:39 200=
2
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.pmac_pci.c 1.34 03/22/02 10:45:30 benh
+ * BK Id: SCCS/s.pmac_pci.c 1.27 09/08/01 15:47:42 paulus
  */
 /*
  * Support for PCI bridges found on Power Macintoshes.
@@ -27,7 +27,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
-#include <asm/pmac_feature.h>
+#include <asm/feature.h>
=20
 #include "pci.h"
=20
@@ -258,12 +258,21 @@
 =09=09rev =3D in_8(bp->cfg_data);
 =09=09if (rev !=3D BANDIT_REVID)
 =09=09=09printk(KERN_WARNING
-=09=09=09       "Unknown revision %d for bandit\n", rev);
+=09=09=09       "Unknown revision %d for bandit at %08lx\n",
+=09=09=09       rev, bp->io_base_phys);
 =09} else if (vendev !=3D (BANDIT_DEVID_2 << 16) + PCI_VENDOR_ID_APPLE) {
 =09=09printk(KERN_WARNING "bandit isn't? (%x)\n", vendev);
 =09=09return;
 =09}
=20
+=09/* read the revision id */
+=09out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) + PCI_REVISION_ID);
+=09udelay(2);
+=09rev =3D in_8(bp->cfg_data);
+=09if (rev !=3D BANDIT_REVID)
+=09=09printk(KERN_WARNING "Unknown revision %d for bandit at %08lx\n",
+=09=09       rev, bp->io_base_phys);
+
 =09/* read the word at offset 0x50 */
 =09out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) + BANDIT_MAGIC);
 =09udelay(2);
@@ -273,7 +282,8 @@
 =09magic |=3D BANDIT_COHERENT;
 =09udelay(2);
 =09out_le32((volatile unsigned int *)bp->cfg_data, magic);
-=09printk(KERN_INFO "Cache coherency enabled for bandit/PSX\n");
+=09printk(KERN_INFO "Cache coherency enabled for bandit/PSX at %08lx\n",
+=09       bp->io_base_phys);
 }
=20
=20
@@ -493,8 +503,6 @@
 =09=09unsigned char pin;
 =09=09struct device_node* node;
 =09=09=09
-=09=09if (pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) || !pin)
-=09=09=09continue; /* No interrupt generated -> no fixup */
 =09=09node =3D pci_device_to_OF_node(dev);
 =09=09if (!node) {
 =09=09=09printk("No OF node for device %x:%x\n", dev->bus->number, dev->de=
vfn >> 3);
@@ -519,37 +527,29 @@
 {
 =09struct device_node* node;
 =09int updatecfg =3D 0;
-=09int uninorth_child;
-=09
+
 =09node =3D pci_device_to_OF_node(dev);
-=09
+
 =09/* We don't want to enable USB controllers absent from the OF tree
 =09 * (iBook second controller)
 =09 */
 =09if (dev->vendor =3D=3D PCI_VENDOR_ID_APPLE
 =09    && dev->device =3D=3D PCI_DEVICE_ID_APPLE_KL_USB && !node)
 =09=09return -EINVAL;
-
-=09if (!node)
-=09=09return 0;
-=09=09
-=09uninorth_child =3D node->parent &&
-=09=09device_is_compatible(node->parent, "uni-north");
 =09=09
 =09/* Firewire & GMAC were disabled after PCI probe, the driver is
 =09 * claiming them, we must re-enable them now.
 =09 */
-=09if (uninorth_child && !strcmp(node->name, "firewire") &&=20
+=09if (node && !strcmp(node->name, "firewire") &&=20
 =09    (device_is_compatible(node, "pci106b,18") ||=20
-=09     device_is_compatible(node, "pci106b,30") ||
-=09     device_is_compatible(node, "pci11c1,5811"))) {
-=09=09pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, node, 0, 1);
-=09=09pmac_call_feature(PMAC_FTR_1394_ENABLE, node, 0, 1);
+=09     device_is_compatible(node, "pci106b,30"))) {
+=09=09feature_set_firewire_cable_power(node, 1);
+=09=09feature_set_firewire_power(node, 1);
 =09=09updatecfg =3D 1;
 =09}
-=09if (uninorth_child && !strcmp(node->name, "ethernet") &&=20
+=09if (node && !strcmp(node->name, "ethernet") &&=20
 =09    device_is_compatible(node, "gmac")) {
-=09=09pmac_call_feature(PMAC_FTR_GMAC_ENABLE, node, 0, 1);
+=09=09feature_set_gmac_power(node, 1);
 =09=09updatecfg =3D 1;
 =09}
=20
@@ -606,11 +606,10 @@
 =09nd =3D find_devices("firewire");
 =09while (nd) {
 =09=09if (nd->parent && (device_is_compatible(nd, "pci106b,18") ||
-=09=09=09=09   device_is_compatible(nd, "pci106b,30") ||
-=09=09=09=09   device_is_compatible(nd, "pci11c1,5811"))
+=09=09=09=09=09device_is_compatible(nd, "pci106b,30"))
 =09=09    && device_is_compatible(nd->parent, "uni-north")) {
-=09=09=09pmac_call_feature(PMAC_FTR_1394_ENABLE, nd, 0, 0);
-=09=09=09pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, nd, 0, 0);
+=09=09=09feature_set_firewire_power(nd, 0);
+=09=09=09feature_set_firewire_cable_power(nd, 0);
 =09=09}
 =09=09nd =3D nd->next;
 =09}
@@ -618,7 +617,7 @@
 =09while (nd) {
 =09=09if (nd->parent && device_is_compatible(nd, "gmac")
 =09=09    && device_is_compatible(nd->parent, "uni-north"))
-=09=09=09pmac_call_feature(PMAC_FTR_GMAC_ENABLE, nd, 0, 0);
+=09=09=09feature_set_gmac_power(nd, 0);
 =09=09nd =3D nd->next;
 =09}
 }

--134458388-1804289383-1020108890=:367--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: paubert@iram.es
Cc: Paul.Mackerras@cs.anu.edu.au, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: Your message of "Tue, 30 Mar 1999 13:41:41 +0200 (METDST)"
	<Pine.HPP.3.96.990330131656.1043J-100000@gra-ux1.iram.es>
References: <Pine.HPP.3.96.990330131656.1043J-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990401012034H.roikawa@rr.iij4u.or.jp>
Date: Thu, 01 Apr 1999 01:20:34 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Gabriel Paubert <paubert@iram.es>
Subject: Re: Blue G3 and machine check

> Indeed. But if it only happens on access through the P2P bridges, it means
> that the bridge transforms Master Abort on the secondary side into Target
> Aborts on the primary. IIRC there is a bit in the configuration of the
> bridge to control this. 
 Though I'm not sure, do you mean for example something like below?

pmac_pci.c:
__initfunc(unsigned long pmac_find_bridges(unsigned long mem_start, unsigned long mem_end))
{
	int bus;
	struct bridge_data *bridge;
+	struct device_node *p2pbridge;

	bridge_list = 0;
	max_bus = 0;
	add_bridges(find_devices("bandit"), &mem_start);
	add_bridges(find_devices("chaos"), &mem_start);
	add_bridges(find_devices("pci"), &mem_start);
	bridges = (struct bridge_data **) mem_start;
	mem_start += (max_bus + 1) * sizeof(struct bridge_data *);
	memset(bridges, 0, (max_bus + 1) * sizeof(struct bridge_data *));
	for (bridge = bridge_list; bridge != NULL; bridge = bridge->next)
		for (bus = bridge->bus_number; bus <= bridge->max_bus; ++bus)
			bridges[bus] = bridge;

+	if((p2pbridge = find_devices("pci-bridge")) && !strcmp(p2pbridge->parent->name, "pci")) {
+		unsigned char devfn;
+		unsigned short val;
+
+		if(!pci_device_loc(p2pbridge, &bus, &devfn)) {
+			grackle_pcibios_read_config_word(0, devfn, PCI_BRIDGE_CONTROL, &val);
+			val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
+			grackle_pcibios_write_config_word(0, devfn, PCI_BRIDGE_CONTROL, val);
+			grackle_pcibios_read_config_word(0, devfn, PCI_BRIDGE_CONTROL, &val);
+		}
+	}
+
	return mem_start;
}


As a matter of fact, kernel successfully booted right before executing
/sbin/init(I haven't prepareed filesystem yet) adding two more fixes:

prom.c:
	 * If the pci host bridge has an interrupt-map property,
	 * look for our node in it.
	 */
	if (np->parent != 0 && pci_addrs != 0
	    && (imp = (struct pci_intr_map *)
		get_property(np->parent, "interrupt-map", &ml)) != 0
	    && (ip = (int *) get_property(np, "interrupts", &l)) != 0) {
-	  	unsigned int busdevfn = pci_addrs[0].addr.a_hi & 0xffff00;
+		/* P2P bridge's interrupt map contains no bus number */
+	        unsigned int devfn = pci_addrs[0].addr.a_hi & 0x00ff00;

		np->n_intrs = 0;
		np->intrs = (struct interrupt_info *) mem_start;
		for (i = 0; (ml -= sizeof(struct pci_intr_map)) >= 0; ++i) {
			if (imp[i].addr.a_hi == devfn) {
				np->intrs[np->n_intrs].line = imp[i].intr;
				np->intrs[np->n_intrs].sense = 0;
				++np->n_intrs;
			}

ide-pmac.c:
	*rp = NULL;
	*pp = removables;

	for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
+	        struct device_node *tp;
+		int hosted_by_mac_io;
+
+		for (tp = np->parent, hosted_by_mac_io = 0; tp; tp = tp->parent)
+		  if (tp->type &&
+		      (!strcmp(tp->type, "mac-io") || !strcmp(tp->type, "dbdma"))) {
+			  hosted_by_mac_io = 1;
+			  break;
+		  }
+		if (!hosted_by_mac_io)
+		    continue;

		if (np->n_addrs == 0) {
			printk(KERN_WARNING "ide: no address for device %s\n",
			       np->full_name);
			continue;
		}


These are the boot messages on the screen before kernel panic(hand-copied,
may exist typo).
.....
(scsi0) <Adaptec AHA 294X Ultra2 SCSI host adaptor> found at PCI 4/0
(scsi0) Wide channel, SCSI ID=7, 32/255 SCBs
(scsi0) Down loading sequecncer code... 407 instructions down loaded
scsi0: Adaptec ...
scsi1: MESH
scsi: 2 hosts
 Vendor: IBM	Model: DDRS-39130D	Rev: DC2A
 Type: Direct-access
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
......
(scsi0:0:0:0) Synchronous at 80.0 Mbytes/sec, offset 15
SCSI device sda: hdwr sectors=512, Sectors=17850000 [8715MB] [8.7GB]
....
PPP version 2.3.3
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
eth0: BMAC+ at 00:05:02:09:f8:f3
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5
 sdb: sdb1 sdb2 sdb3 sdb4
 sdc: sdc1 sdc2 sdc3 sdc4
VFS: Mounted root (hfs filesystem) readonly.
Freeing unused kernel memory: 112k init 32k prep
Warning: unable to open an initial console.
kernel panic: No init found. Try passing init= option to kernel.


I put precompiled kernel(2.2.1) on
  ftp://ppc.linux.or.jp/pub/users/oikawa/linux-pmac/bluemacg3/vmlinux-2.2.1-challenger2.gz
I was given many useful advice on this by Benjamin Herrenschmidt.


Could you give me recommended/suggested fix codes on machine check
exception? I think I can try them and report.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

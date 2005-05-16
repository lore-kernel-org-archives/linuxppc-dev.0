Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 2F0C567A03
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 18:42:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 16 May 2005 10:42:51 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2B@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Nghiem, Tien" <TNghiem@oerlikon.ca>,
	<linuxppc-dev@ozlabs.org>
Subject: RE : eth0: PHY id 0x00221619 is not supported! HELP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FIrst of all tks a lot for your answers everybody.
Tien, in my case, I do not have and so do not use the function =
"mii_phy_probe(struct mii_phy *phy, int mii_id)" in the "ibm_ocp_phy.c" =
file.
Here is the list of call used in my process:

--> ocp_enet_probe(int curr_emac)                            =
[ibm_ocp_enet.c]
     --> find_phy(struct net_device *dev)                    =
[ibm_ocp_phy.c]
          --> check_phy(struct net_device *dev, int phnum)   =
[ibm_ocp_phy.c]

And here are the function detailed:

-------------------------------------------------------------------------=
-------------------
static int
ocp_enet_probe(int curr_emac)
{
	int ret =3D 1;
	int i;
	bd_t *bd;
	struct net_device *dev;
	struct ocp_enet_private *ep;
	struct ocp_dev *emac_driver;
        dev_list_t *new_dev_list;            =09
	dev =3D init_etherdev(NULL, sizeof (struct ocp_enet_private));      =20
	if (dev =3D=3D NULL) {
		printk(KERN_ERR
		       "ibm_ocp_enet: Could not allocate ethernet device.\n");
		return -1;
	}       =20

 /* create devlist instance */
 new_dev_list =3D (dev_list_t *)kmalloc(sizeof(struct =
dev_list),GFP_ATOMIC);
 if(new_dev_list =3D=3D NULL)
 {
    printk(KERN_ERR "IBM_OCP_ENET: dev_list alloc failed \n");
    return -1;
 }
 new_dev_list->next =3D NULL;
 new_dev_list->dev =3D dev;
 if (emac_dev_list =3D=3D NULL)
 {
    emac_dev_list =3D new_dev_list;
    cur_dev_list =3D new_dev_list;
 }
 else
 {
    cur_dev_list->next =3D new_dev_list;
    cur_dev_list =3D new_dev_list;
	}

=09
	ep =3D dev->priv;
	ep->emac_num =3D curr_emac;
	ep->mal =3D DCRN_MAL_BASE;
	ep->sequence_done =3D 0;

	emac_driver =3D &ep->ocpdev;
	emac_driver->type =3D EMAC;
	ocp_register(emac_driver);
	ocp_set_drvdata(emac_driver, dev);

	ep->emacp =3D (volatile emac_t *) __ioremap
	    (emac_driver->paddr, sizeof (emac_t), _PAGE_NO_CACHE);
	init_zmii(ZMII_AUTO, dev);
	/******************************/
        /* Beginning of my pb         */
        /******************************/
        find_phy(dev);
	if (!ep->phy) {
		ocp_remove_one(emac_driver);
		return -1;
	}
	ep->link =3D 1;
	ep->txchan =3D 0x80000000  >> curr_emac*2 ;
	ep->rxchan =3D 0x80000000 >> curr_emac;
	dev->irq =3D ocp_get_irq(EMAC,curr_emac);
	/* read the MAC Address */
	bd =3D (bd_t *) __res;     =20
	for (i =3D 0; i < 6; i++)
		dev->dev_addr[i] =3D bd->BD_EMAC_ADDR(curr_emac, i);	/* Marco to =
disques array */    =20
	/* Fill in the driver function table */
	dev->open =3D &ppc405_enet_open;
	dev->hard_start_xmit =3D &ppc405_enet_start_xmit;
	dev->stop =3D &ppc405_enet_close;
	dev->get_stats =3D &ppc405_enet_stats;
	dev->set_multicast_list =3D &ppc405_enet_set_multicast_list;
	dev->do_ioctl =3D &ocp_enet_ioctl;
	emac_dev[curr_emac] =3D dev;
	printk(KERN_NOTICE "Reset ethernet interfaces\n");

	/* Reset the EMAC */
	out_be32(&ep->emacp->em0mr0, EMAC_M0_SRST);
	udelay(10);

	if (in_be32(&ep->emacp->em0mr0) & EMAC_M0_SRST) {
		printk(KERN_NOTICE "%s: Cannot open interface without Link\n",
		       dev->name);
		return -1;
	}
	config_mal(ep);

	return (ret);
}

-------------------------------------------------------------------------=
-------------------

static int check_phy(struct net_device *dev, int phnum)
{
	struct ocp_enet_private *fep =3D dev->priv;
	uint phy_reg;
	int i;

	fep->phy_addr =3D phnum;
	if (ocp_enet_mdio_read(dev, mk_mii_read(MII_REG_PHYIR1), &phy_reg))
		return 0;

	ppc405_phy_dump(dev);

	/* Got 2nd part of ID, now get remainder. */
	fep->phy_id =3D (phy_reg & 0xffff) << 16;

	if (ocp_enet_mdio_read(dev, mk_mii_read(MII_REG_PHYIR2), &phy_reg)) {
		if (phnum =3D=3D MIN_PHY_ADDR)
			printk(KERN_ERR "%s: Got bad Phy Read, missing MDIO pullup?\n",
			       dev->name);
		return 0;
	}

	fep->phy_id |=3D (phy_reg & 0xffff);

	for (i =3D 0; phy_info[i]; i++)
		if (phy_info[i]->id =3D=3D (fep->phy_id >> phy_info[i]->shift))
			break;
	if (!phy_info[i]) {
		printk(KERN_ERR "%s: PHY id 0x%08x is not supported!\n",
		       dev->name, fep->phy_id);
		return 0;
	}

	fep->phy =3D phy_info[i];

	printk("%s: Phy @ 0x%x, type %s (0x%08x)\n",
	       dev->name, fep->phy_addr, fep->phy->name, fep->phy_id);
	return 1;
}

-------------------------------------------------------------------------=
-------------------

void find_phy(struct net_device *dev)
{
	int i;

	for (i =3D next_phy_available; i <=3D MAX_PHY_ADDR; i++)
		if (check_phy(dev, i)){
			next_phy_available =3D i + 1;
			return;
		}
	printk("%s: No PHY device found.\n", dev->name);
}





So, how can I apply your method Thien? Could you give me a clue =
(again...lol)?
Tks a lot cause this part of linux code is very very unknown to me...

J=E9r=E9mie


-------- Message d'origine--------
De: Nghiem, Tien [mailto:TNghiem@oerlikon.ca]
Date: ven. 13/05/2005 20:25
=C0: Garcia J=E9r=E9mie; linuxppc-dev@ozlabs.org
Objet : RE: eth0: PHY id 0x00221619 is not supported! HELP
=20
Hi Garcia,

In the ibm_ocp_phy.c file, the function mii_phy_probe(struct mii_phy =
*phy, int mii_id) has not found the ID of your ethernet transceiver, so =
you can bypass it by doing the following:

         int rc;
         u32 id;
         struct mii_phy_def* def;
         int i;
       =20
         phy->autoneg =3D 0;
         phy->advertising =3D 0;
         phy->mii_id =3D mii_id;
         phy->speed =3D 0;
         phy->duplex =3D 0;
         phy->pause =3D 0;
        =20
        /* Take PHY out of isloate mode and reset it. */
         rc =3D reset_one_mii_phy(phy, mii_id);
        //if (rc)
        //        return -ENODEV;
=20
        /* Read ID and find matching entry */  =20
        //id =3D (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, =
MII_PHYSID2))
                                 & 0xfffffff0;
        //for (i=3D0; (def =3D mii_phy_table[i]) !=3D NULL; i++)
        //        if ((id & def->phy_id_mask) =3D=3D def->phy_id)
        //                break;
       =20
        def =3D mii_phy_table[0];
           =20
        /* Should never be NULL (we have a generic entry), but... */
         if (def =3D=3D NULL)
                return -ENODEV;
=20
         phy->def =3D def;

         /* Setup default advertising */
         phy->advertising =3D def->features;
=20
         return 0;

I don't know the PPC 405EP, but I did it for my custom board (MPC8260). =
It should work.

Tien


-----Original Message-----
From: linuxppc-dev-bounces@ozlabs.org
[mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of Garcia J=E9r=E9mie
Sent: Friday, May 13, 2005 11:15 AM
To: linuxppc-dev@ozlabs.org
Subject: eth0: PHY id 0x00221619 is not supported! HELP


Hi everybody,
We are developping a custom board which uses a ppc405EP and on which one =
we'd like to load a linux hardhat.
During the boot process, we're getting error messages about the ethernet =
PHY. That is really annoying cause we plan to moubnt the file system via =
nfs. So no ethernet no NFS...
Could someone give us a tip and tell us if the messages displayed before =
seem to be normal cause we had to modify some part of the kernel in =
order to get Linux booting.
What those ethernet messages mean? Everythin seems to happen in the =
"ibm_ocp_enet.c" eand "ibm_ocp_phy.c" filesPlease help....
So here we go ---->>>>>>>>>

Linux/PPC load: console=3DttyS0,19200 root=3D/dev/nfs rw ip=3Don
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-405ep_eval =
(root@sop-dhcp-10-16-5-126.amcc.com) (version gcc 3.3.1 (MontaVista =
3.3.1-3.0.10.0300532 2003-12-24)) #26 ven mai 13 5
AMCC Q80G Board
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS0,19200 root=3D/dev/nfs rw ip=3Don
hr_time_init: arch_to_nsec =3D 10485759, nsec_to_arch =3D 858993476
Calibrating delay loop... 199.47 BogoMIPS
Memory: 14416k available (1280k kernel code, 424k data, 64k init, 0k =
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
LSP Revision 1
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis =
Communications AB.
i2c-core.o: i2c core module version 2.6.2 (20011118)
i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
i2c-proc.o version 2.6.2 (20011118)
pty: 256 Unix98 ptys configured
eeprom.o version 2.6.2 (20011118)
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xef600300 (irq =3D 0) is a 16550A
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A
IBM gpio driver version 07.25.02
GPIO #0 at 0xc207d700
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: PHY id 0x00221619 is not supported!
eth0: PHY id 0x00221619 is not supported!
eth0: No PHY device found.
removing net dev
eth0: PHY id 0x00221619 is not supported!
eth0: PHY id 0x00221619 is not supported!
eth0: No PHY device found.
removing net dev
IBM IIC driver v2.0
ibm-iic: using compatibility value for OPB freq, fix your board specific =
setup
ibm-iic0: using standard (100 kHz) mode
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMPIP: routing cache hash table of 512 =
buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno =3D 2
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00
 <0>Rebooting in 180 seconds..


Tks a lot for your precious help
Dj=E9
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

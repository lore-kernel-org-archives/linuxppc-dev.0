Return-Path: <fengguang.wu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4t1D01xHzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 07:42:05 +1100 (AEDT)
Date: Sat, 21 Jan 2017 04:41:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, zhong@linux.vnet.ibm.com,
 aik@ozlabs.ru, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 alex.williamson@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 2/3] PCI: Make sure the driver could get correct BAR
 size from pci_resource_len()
Message-ID: <201701210423.KBRjZZql%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1484898113-24939-3-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Yongji,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yongji-Xie/PCI-Ignore-requested-alignment-for-IOV-BARs/20170121-031322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from drivers/ata/sata_sis.c:35:0:
   drivers/ata/sata_sis.c: In function 'sis_init_one':
   include/linux/pci.h:1648:44: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>' [-Wenum-compare]
    #define pci_resource_end(dev, bar) (((bar) > PCI_ROM_RESOURCE) ? \
                                               ^
   include/linux/pci.h:1655:4: note: in expansion of macro 'pci_resource_end'
       pci_resource_end((dev), (bar)) ==  \
       ^~~~~~~~~~~~~~~~
>> drivers/ata/sata_sis.c:223:8: note: in expansion of macro 'pci_resource_len'
          (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
           ^~~~~~~~~~~~~~~~
   include/linux/pci.h:1648:44: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>' [-Wenum-compare]
    #define pci_resource_end(dev, bar) (((bar) > PCI_ROM_RESOURCE) ? \
                                               ^
   include/linux/pci.h:1658:4: note: in expansion of macro 'pci_resource_end'
      (pci_resource_end((dev), (bar)) -  \
       ^~~~~~~~~~~~~~~~
>> drivers/ata/sata_sis.c:223:8: note: in expansion of macro 'pci_resource_len'
          (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
           ^~~~~~~~~~~~~~~~

vim +/pci_resource_len +223 drivers/ata/sata_sis.c

af36d7f0 drivers/scsi/sata_sis.c Jeff Garzik               2005-08-28   29   *  Hardware documentation available under NDA.
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   30   *
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   31   */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   32  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   33  #include <linux/kernel.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   34  #include <linux/module.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  @35  #include <linux/pci.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   36  #include <linux/blkdev.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   37  #include <linux/delay.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   38  #include <linux/interrupt.h>
a9524a76 drivers/scsi/sata_sis.c Jeff Garzik               2005-10-30   39  #include <linux/device.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   40  #include <scsi/scsi_host.h>
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   41  #include <linux/libata.h>
4bb64fb9 drivers/ata/sata_sis.c  Alan Cox                  2007-02-16   42  #include "sis.h"
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   43  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   44  #define DRV_NAME	"sata_sis"
2a3103ce drivers/ata/sata_sis.c  Jeff Garzik               2007-08-31   45  #define DRV_VERSION	"1.0"
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   46  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   47  enum {
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   48  	sis_180			= 0,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   49  	SIS_SCR_PCI_BAR		= 5,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   50  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   51  	/* PCI configuration registers */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   52  	SIS_GENCTL		= 0x54, /* IDE General Control register */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   53  	SIS_SCR_BASE		= 0xc0, /* sata0 phy SCR registers */
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07   54  	SIS180_SATA1_OFS	= 0x10, /* offset from sata0->sata1 phy regs */
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07   55  	SIS182_SATA1_OFS	= 0x20, /* offset from sata0->sata1 phy regs */
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07   56  	SIS_PMR			= 0x90, /* port mapping register */
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07   57  	SIS_PMR_COMBINED	= 0x30,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   58  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   59  	/* random bits */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   60  	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   61  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   62  	GENCTL_IOMAPPED_SCR	= (1 << 26), /* if set, SCRs are in IO space */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   63  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   64  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   65  static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31   66  static int sis_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31   67  static int sis_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   68  
3b7d697d drivers/scsi/sata_sis.c Jeff Garzik               2005-11-10   69  static const struct pci_device_id sis_pci_tbl[] = {
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04   70  	{ PCI_VDEVICE(SI, 0x0180), sis_180 },	/* SiS 964/180 */
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04   71  	{ PCI_VDEVICE(SI, 0x0181), sis_180 },	/* SiS 964/180 */
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04   72  	{ PCI_VDEVICE(SI, 0x0182), sis_180 },	/* SiS 965/965L */
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04   73  	{ PCI_VDEVICE(SI, 0x0183), sis_180 },	/* SiS 965/965L */
a3cabb27 drivers/ata/sata_sis.c  Uwe Koziolek              2007-06-14   74  	{ PCI_VDEVICE(SI, 0x1182), sis_180 },	/* SiS 966/680 */
a3cabb27 drivers/ata/sata_sis.c  Uwe Koziolek              2007-06-14   75  	{ PCI_VDEVICE(SI, 0x1183), sis_180 },	/* SiS 966/966L/968/680 */
2d2744fc drivers/ata/sata_sis.c  Jeff Garzik               2006-09-28   76  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   77  	{ }	/* terminate list */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   78  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   79  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   80  static struct pci_driver sis_pci_driver = {
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   81  	.name			= DRV_NAME,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   82  	.id_table		= sis_pci_tbl,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   83  	.probe			= sis_init_one,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   84  	.remove			= ata_pci_remove_one,
58eb8cd5 drivers/ata/sata_sis.c  Bartlomiej Zolnierkiewicz 2014-05-07   85  #ifdef CONFIG_PM_SLEEP
55c82a6c drivers/ata/sata_sis.c  Alan                      2014-01-01   86  	.suspend		= ata_pci_device_suspend,
55c82a6c drivers/ata/sata_sis.c  Alan                      2014-01-01   87  	.resume			= ata_pci_device_resume,
55c82a6c drivers/ata/sata_sis.c  Alan                      2014-01-01   88  #endif
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   89  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   90  
193515d5 drivers/scsi/sata_sis.c Jeff Garzik               2005-11-07   91  static struct scsi_host_template sis_sht = {
68d1d07b drivers/ata/sata_sis.c  Tejun Heo                 2008-03-25   92  	ATA_BMDMA_SHT(DRV_NAME),
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   93  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   94  
029cfd6b drivers/ata/sata_sis.c  Tejun Heo                 2008-03-25   95  static struct ata_port_operations sis_ops = {
029cfd6b drivers/ata/sata_sis.c  Tejun Heo                 2008-03-25   96  	.inherits		= &ata_bmdma_port_ops,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   97  	.scr_read		= sis_scr_read,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   98  	.scr_write		= sis_scr_write,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16   99  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  100  
1626aeb8 drivers/ata/sata_sis.c  Tejun Heo                 2007-05-04  101  static const struct ata_port_info sis_port_info = {
9cbe056f drivers/ata/sata_sis.c  Sergei Shtylyov           2011-02-04  102  	.flags		= ATA_FLAG_SATA,
14bdef98 drivers/ata/sata_sis.c  Erik Inge Bolsø           2009-03-14  103  	.pio_mask	= ATA_PIO4,
14bdef98 drivers/ata/sata_sis.c  Erik Inge Bolsø           2009-03-14  104  	.mwdma_mask	= ATA_MWDMA2,
bf6263a8 drivers/ata/sata_sis.c  Jeff Garzik               2007-07-09  105  	.udma_mask	= ATA_UDMA6,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  106  	.port_ops	= &sis_ops,
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  107  };
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  108  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  109  MODULE_AUTHOR("Uwe Koziolek");
142924cf drivers/ata/sata_sis.c  Chris Dunlop              2011-10-24  110  MODULE_DESCRIPTION("low-level driver for Silicon Integrated Systems SATA controller");
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  111  MODULE_LICENSE("GPL");
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  112  MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  113  MODULE_VERSION(DRV_VERSION);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  114  
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  115  static unsigned int get_scr_cfg_addr(struct ata_link *link, unsigned int sc_reg)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  116  {
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  117  	struct ata_port *ap = link->ap;
9b14dec5 drivers/ata/sata_sis.c  Alan Cox                  2007-01-08  118  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  119  	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
9b14dec5 drivers/ata/sata_sis.c  Alan Cox                  2007-01-08  120  	u8 pmr;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  121  
9b14dec5 drivers/ata/sata_sis.c  Alan Cox                  2007-01-08  122  	if (ap->port_no)  {
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  123  		switch (pdev->device) {
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  124  		case 0x0180:
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  125  		case 0x0181:
9b14dec5 drivers/ata/sata_sis.c  Alan Cox                  2007-01-08  126  			pci_read_config_byte(pdev, SIS_PMR, &pmr);
9b14dec5 drivers/ata/sata_sis.c  Alan Cox                  2007-01-08  127  			if ((pmr & SIS_PMR_COMBINED) == 0)
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  128  				addr += SIS180_SATA1_OFS;
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  129  			break;
8add7885 drivers/scsi/sata_sis.c Jeff Garzik               2005-09-08  130  
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  131  		case 0x0182:
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  132  		case 0x0183:
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  133  		case 0x1182:
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  134  			addr += SIS182_SATA1_OFS;
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  135  			break;
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  136  		}
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  137  	}
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  138  	if (link->pmp)
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  139  		addr += 0x10;
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  140  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  141  	return addr;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  142  }
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  143  
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  144  static u32 sis_scr_cfg_read(struct ata_link *link,
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  145  			    unsigned int sc_reg, u32 *val)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  146  {
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  147  	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  148  	unsigned int cfg_addr = get_scr_cfg_addr(link, sc_reg);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  149  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  150  	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
8e5443a0 drivers/ata/sata_sis.c  Tejun Heo                 2008-04-24  151  		return -EINVAL;
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  152  
aaa092a1 drivers/ata/sata_sis.c  Tejun Heo                 2007-10-18  153  	pci_read_config_dword(pdev, cfg_addr, val);
aaa092a1 drivers/ata/sata_sis.c  Tejun Heo                 2007-10-18  154  	return 0;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  155  }
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  156  
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  157  static int sis_scr_cfg_write(struct ata_link *link,
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  158  			     unsigned int sc_reg, u32 val)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  159  {
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  160  	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  161  	unsigned int cfg_addr = get_scr_cfg_addr(link, sc_reg);
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  162  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  163  	pci_write_config_dword(pdev, cfg_addr, val);
8e5443a0 drivers/ata/sata_sis.c  Tejun Heo                 2008-04-24  164  	return 0;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  165  }
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  166  
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  167  static int sis_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  168  {
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  169  	struct ata_port *ap = link->ap;
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  170  	void __iomem *base = ap->ioaddr.scr_addr + link->pmp * 0x10;
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  171  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  172  	if (sc_reg > SCR_CONTROL)
da3dbb17 drivers/ata/sata_sis.c  Tejun Heo                 2007-07-16  173  		return -EINVAL;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  174  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  175  	if (ap->flags & SIS_FLAG_CFGSCR)
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  176  		return sis_scr_cfg_read(link, sc_reg, val);
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  177  
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  178  	*val = ioread32(base + sc_reg * 4);
da3dbb17 drivers/ata/sata_sis.c  Tejun Heo                 2007-07-16  179  	return 0;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  180  }
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  181  
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  182  static int sis_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  183  {
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  184  	struct ata_port *ap = link->ap;
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  185  	void __iomem *base = ap->ioaddr.scr_addr + link->pmp * 0x10;
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  186  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  187  	if (sc_reg > SCR_CONTROL)
da3dbb17 drivers/ata/sata_sis.c  Tejun Heo                 2007-07-16  188  		return -EINVAL;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  189  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  190  	if (ap->flags & SIS_FLAG_CFGSCR)
82ef04fb drivers/ata/sata_sis.c  Tejun Heo                 2008-07-31  191  		return sis_scr_cfg_write(link, sc_reg, val);
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  192  
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  193  	iowrite32(val, base + (sc_reg * 4));
da3dbb17 drivers/ata/sata_sis.c  Tejun Heo                 2007-07-16  194  	return 0;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  195  }
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  196  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  197  static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  198  {
9a829ccf drivers/ata/sata_sis.c  Tejun Heo                 2007-04-17  199  	struct ata_port_info pi = sis_port_info;
ddfc87a0 drivers/ata/sata_sis.c  Uwe Koziolek              2007-05-25  200  	const struct ata_port_info *ppi[] = { &pi, &pi };
9a829ccf drivers/ata/sata_sis.c  Tejun Heo                 2007-04-17  201  	struct ata_host *host;
4adccf6f drivers/ata/sata_sis.c  Uwe Koziolek              2006-11-08  202  	u32 genctl, val;
f2c853bc drivers/scsi/sata_sis.c Arnaud Patard             2005-09-07  203  	u8 pmr;
3f3e7313 drivers/ata/sata_sis.c  Uwe Koziolek              2006-12-04  204  	u8 port2_start = 0x20;
72fee382 drivers/ata/sata_sis.c  Tejun Heo                 2009-09-01  205  	int i, rc;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  206  
06296a1e drivers/ata/sata_sis.c  Joe Perches               2011-04-15  207  	ata_print_version_once(&pdev->dev, DRV_VERSION);
a9524a76 drivers/scsi/sata_sis.c Jeff Garzik               2005-10-30  208  
24dc5f33 drivers/ata/sata_sis.c  Tejun Heo                 2007-01-20  209  	rc = pcim_enable_device(pdev);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  210  	if (rc)
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  211  		return rc;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  212  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  213  	/* check and see if the SCRs are in IO space or PCI cfg space */
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  214  	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  215  	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
cf0e812f drivers/ata/sata_sis.c  Tejun Heo                 2006-10-27  216  		pi.flags |= SIS_FLAG_CFGSCR;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  217  
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  218  	/* if hardware thinks SCRs are in IO space, but there are
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  219  	 * no IO resources assigned, change to PCI cfg space.
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  220  	 */
cf0e812f drivers/ata/sata_sis.c  Tejun Heo                 2006-10-27  221  	if ((!(pi.flags & SIS_FLAG_CFGSCR)) &&
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  222  	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16 @223  	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  224  		genctl &= ~GENCTL_IOMAPPED_SCR;
^1da177e drivers/scsi/sata_sis.c Linus Torvalds            2005-04-16  225  		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
cf0e812f drivers/ata/sata_sis.c  Tejun Heo                 2006-10-27  226  		pi.flags |= SIS_FLAG_CFGSCR;

:::::: The code at line 223 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pf9I7BMVVzbSWLtt--

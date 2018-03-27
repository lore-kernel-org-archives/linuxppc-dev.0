Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409PXj0nmnzF28Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 19:37:56 +1100 (AEDT)
Date: Tue, 27 Mar 2018 11:37:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: rsarmah@amcc.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/4xx: Adding PCIe MSI support
Message-ID: <20180327083742.GA22208@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ This is really really ancient code.  - dan ]

Hello Rupjyoti Sarmah,

The patch 3fb7933850fa: "powerpc/4xx: Adding PCIe MSI support" from
Mar 29, 2011, leads to the following static checker warning:

	arch/powerpc/platforms/4xx/msi.c:100 ppc4xx_setup_msi_irqs()
	warn: 'int_no >= 0' 'false' implies 'int_no < 0' is 'true'

arch/powerpc/platforms/4xx/msi.c
    79  static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
    80  {
    81          int int_no = -ENOMEM;
    82          unsigned int virq;
    83          struct msi_msg msg;
    84          struct msi_desc *entry;
    85          struct ppc4xx_msi *msi_data = &ppc4xx_msi;
    86  
    87          dev_dbg(&dev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
    88                  __func__, nvec, type);
    89          if (type == PCI_CAP_ID_MSIX)
    90                  pr_debug("ppc4xx msi: MSI-X untested, trying anyway.\n");
    91  
    92          msi_data->msi_virqs = kmalloc((msi_irqs) * sizeof(int), GFP_KERNEL);
    93          if (!msi_data->msi_virqs)
    94                  return -ENOMEM;
    95  
    96          for_each_pci_msi_entry(entry, dev) {
    97                  int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
    98                  if (int_no >= 0)
                            ^^^^^^^^^^^
    99                          break;
   100                  if (int_no < 0) {
                            ^^^^^^^^^^
Smatch is saying that this check could be removed, which is true.

   101                          pr_debug("%s: fail allocating msi interrupt\n",
   102                                          __func__);
   103                  }
   104                  virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
                                                                       ^^^^^^

It doesn't seem right to pass negative indexes to irq_of_parse_and_map().
It could result in a read before the start of the array in
of_irq_parse_oldworld(), I think.

   105                  if (!virq) {
   106                          dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
   107                          msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
   108                          return -ENOSPC;
   109                  }
   110                  dev_dbg(&dev->dev, "%s: virq = %d\n", __func__, virq);
   111  
   112                  /* Setup msi address space */
   113                  msg.address_hi = msi_data->msi_addr_hi;
   114                  msg.address_lo = msi_data->msi_addr_lo;
   115  
   116                  irq_set_msi_desc(virq, entry);
   117                  msg.data = int_no;
   118                  pci_write_msi_msg(virq, &msg);
   119          }
   120          return 0;
   121  }

regards,
dan carpenter

Date: Fri, 7 Sep 2001 04:24:36 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109071124.EAA14245@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org,
	jfd@krakatoa.gigabitnetworks.com, jfd@GigabitNetworks.COM
Subject: Auto-attaching to IDE drives
Cc: jfd@krakatoa.gigabitnetworks.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

In my ide_probe routine, I would like to bind to any/all IDE controllers
that the PCI discovery detects (as opposed to code like the below).

What is the procedure whereby this is performed? Should I do a pci_find_class()
and be done with it?

Thoughts?

					Thanks,
					-James

static void
mousse_ide_probe(void)
{

        struct pci_dev *pdev = pci_find_device(PCI_VENDOR_ID_PROMISE,
					       PCI_DEVICE_ID_PROMISE_20262,
					       NULL);
        if(pdev) {
                mousse_ide_regbase[0]=pdev->resource[0].start;
                mousse_ide_regbase[1]=pdev->resource[2].start;
                mousse_ide_ctl_regbase[0]=pdev->resource[1].start;
                mousse_ide_ctl_regbase[1]=pdev->resource[3].start;
                mousse_idedma_regbase=pdev->resource[4].start;
	}

        mousse_ide_ports_known = 1;
	return;
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

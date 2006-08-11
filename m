Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53115.mail.yahoo.com (web53115.mail.yahoo.com
	[206.190.49.65]) by ozlabs.org (Postfix) with SMTP id E2D5167B94
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 23:57:48 +1000 (EST)
Message-ID: <20060811135746.68402.qmail@web53115.mail.yahoo.com>
Date: Fri, 11 Aug 2006 06:57:46 -0700 (PDT)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: PCI DMA_MR Problem
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I got a problem when I set the pci dmamr for MPC8250
for DMA PCI transfering data on linux kernel 2.6.17.
When I set the values for the pci_dmamr registers,
then print the register values back, some bits can not
be set. Did anybody know what are the problem, or I
have to set other stuff.

Thanks.

The code like this:

volatile cpm2_map_t *immap = cpm2_immr;
immap->im_pci.pci_dmamr0 = 0x0042b00c;
immap->im_pci.pci_dmamr1 = 0x0042b00c;
immap->im_pci.pci_dmamr2 = 0x0042b00c;
immap->im_pci.pci_dmamr3 = 0x0042b00c;

printk("DMA0 MR = 0x%08x\n",
immap->im_pci.pci_dmamr0);
printk("DMA1 MR (0x%08x) = 0x%08x\n",
immap->im_pci.pci_dmamr1);
printk("DMA2 MR (0x%08x) = 0x%08x\n",
immap->im_pci.pci_dmamr2);
printk("DMA3 MR (0x%08x) = 0x%08x\n",
immap->im_pci.pci_dmamr3);

The results are following:
DMA0 MR (0xf0010500) = 0x0040b000
DMA1 MR (0xf0010580) = 0x0040b000
DMA2 MR (0xf0010600) = 0x0040b000
DMA3 MR (0xf0010680) = 0x0040b000



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: PQFADS PCI
Date: Thu, 8 Jul 2004 10:32:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407081032.53852.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

at the moment i have time again setting up pci in my PQ2FADS board of
Motorola. How i post earlier in the list my kernel can boot without
the CONFIG_PCI option. The pci on the board is very similar to the
8266 ads. There is an external PCI-Interrupt "Controller". IRQ6 is the
default interrupt line in 8266ads and PQ2FADS. Therefore i use the code
/arch/ppc/platforms/mpc8266ads_pci.c for my inits. My kernel hangs
in the function "mpc8266ads_init_irq(void)". The access " *(volatile
unsigned int *) PCI_INT_MASK_REG |= 0xfff00000;" in this function is the
reason for hanging (thanks to abatron !!). Then i ve checked the header
(ads8260.h). There are some definitions for PCI.
 #define PCI_INT_STAT_REG	0xF8200000
#define PCI_INT_MASK_REG	0xF8200004
I thinks these definitions are wrong. It has to be
#define PCI_INT_STAT_REG	0xF4730000
#define PCI_INT_MASK_REG	0xF4730004
because the pci interrupt controller has 0x04730000 in the board map.
But with the "correct" values it doesnt work, too.

Any ideas or am i totally wrong??

Best regards
Marco

---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

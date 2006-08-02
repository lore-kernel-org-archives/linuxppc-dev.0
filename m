Return-Path: <robinpv@aiware.co.jp>
Message-ID: <44D0382A.1090404@aiware.co.jp>
Date: Wed, 02 Aug 2006 14:29:14 +0900
From: robinpv <robinpv@aiware.co.jp>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: linux USB host problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
  I am using linux 2.6.16.1 for MPC5200 based platorm. It has PCI based USB Host (SM501 chip)
  I am facing problem in the USB host interrupts. When i plug in the USB i get the
below message.

new full speed USB device using vgxfb and address 2.
vgxfb 0000:00:10.0: Unlink after no-IRQ?  Controller is probably using the
wrong IRQ.

the capture of /pci/interrupts is
           CPU0
  1:          0   MPC52xx   Level     ohci_hcd:usb1
  7:        751   MPC52xx   Level     eth0
 40:       7899   MPC52xx   Level     mpc52xx_psc_uart
BAD:          0

The device address is assigned but after that interrupt is not coming.
After that if i unplug and plugin there is no notification.
the sm501 chip in which USB host is there, is connected on PCI bus.
The PCI mapping is as follows

        static char pci_irq_table[][4] =
            /*
             *      PCI IDSEL/INTPIN->INTLINE
             *        A      B      C      D
             */
        {
                {PIRQA, PIRQA, PIRQA, PIRQA},   /* SM501 */
                {PIRQD, PIRQD, PIRQD, PIRQD},   /* IDE */
                {PIRQC, PIRQC, PIRQC, PIRQC},   /* Ethernet */
                {PIRQB, PIRQB, PIRQB, PIRQB},   /* Bridge */
        };
        const long min_idsel = 16, max_idsel = 18, irqs_per_slot = 4;
        return PCI_IRQ_TABLE_LOOKUP;

I tried with acpi=off, but in vain.
Can some give inputs on this how to proceed.

Thanks & Regards,
Robin

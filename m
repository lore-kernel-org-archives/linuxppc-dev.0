Return-Path: <jsteve17@yahoo.com>
Received: from web33402.mail.mud.yahoo.com (web33402.mail.mud.yahoo.com
	[68.142.206.134]) by ozlabs.org (Postfix) with SMTP id 261FD67EB0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 20:27:39 +1000 (EST)
Message-ID: <20061006102738.87758.qmail@web33402.mail.mud.yahoo.com>
Date: Fri, 6 Oct 2006 03:27:38 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Re: 440SP External Interrupt IRQ
To: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200610060646.23125.sr@denx.de>
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

I'm sorry if this is an easy question, but how do my
schematics tell me that pint IRQ0 uses IRQ 48 in my
board specific PCI IRQ lookup table, where it is
matching up the idsel lines to an irq number?  For
instance, in arch/ppc/platforms/4xx/luan.c it maps PCI
interrupts like:

static inline int
luan_map_irq(struct pci_dev *dev, unsigned char idsel,
unsigned char pin)
{
	struct pci_controller *hose =
pci_bus_to_hose(dev->bus->number);

	/* PCIX0 in adapter mode, no host interrupt routing
*/

	/* PCIX1 */
	if (hose->index == 0) {
		static char pci_irq_table[][4] =
		/*
		 *	PCI IDSEL/INTPIN->INTLINE
		 *	  A   B   C   D
		 */
		{
			{ 49, 49, 49, 49 },	/* IDSEL 1 - PCIX1 Slot 0 */
			{ 49, 49, 49, 49 },	/* IDSEL 2 - PCIX1 Slot 1 */
			{ 49, 49, 49, 49 },	/* IDSEL 3 - PCIX1 Slot 2 */
			{ 49, 49, 49, 49 },	/* IDSEL 4 - PCIX1 Slot 3 */
		};
		const long min_idsel = 1, max_idsel = 4,
irqs_per_slot = 4;
		return PCI_IRQ_TABLE_LOOKUP;
	/* PCIX2 */
	} else if (hose->index == 1) {
		static char pci_irq_table[][4] =
		/*
		 *	PCI IDSEL/INTPIN->INTLINE
		 *	  A   B   C   D
		 */
		{
			{ 50, 50, 50, 50 },	/* IDSEL 1 - PCIX2 Slot 0 */
			{ 50, 50, 50, 50 },	/* IDSEL 2 - PCIX2 Slot 1 */
			{ 50, 50, 50, 50 },	/* IDSEL 3 - PCIX2 Slot 2 */
			{ 50, 50, 50, 50 },	/* IDSEL 4 - PCIX2 Slot 3 */
		};
		const long min_idsel = 1, max_idsel = 4,
irqs_per_slot = 4;
		return PCI_IRQ_TABLE_LOOKUP;
	}
	return -1;
}

Based on their schematics, I assume:
IRQ Line      IRQ#
  IRQ0        48
  IRQ1        49
  IRQ2        50
  IRQ3        51
  IRQ4        52
  IRQ5        53

I just hate assuming, and would like to understand how
they come up with the IRQ offset for the external
interrups.

-Jeff

--- Stefan Roese <sr@denx.de> wrote:

> Jeff,
> 
> On Friday 06 October 2006 05:49, Jeff Stevens wrote:
> > I am trying to figure out the PCI IRQ mapping on a
> > 440SP processor in linux-2.6.17.9.  I have a board
> > that is based off of the Luan development board,
> and I
> > am not sure which IRQ corresponds to each external
> > IRQ[0:5] pins on the processor.  Where can I find
> this
> > information?
> 
> In your schematics. Sorry but it's that simple.
> 
> Best regards,
> Stefan
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

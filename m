Date: Mon, 13 Aug 2001 13:18:19 -0700 (PDT)
Message-Id: <200108132018.NAA04740@krakatoa.gigabitnetworks.com>
From: James F Dougherty <jfd@GigabitNetworks.COM>
To: trini@kernel.crashing.org
Subject: Re: PCI IDE Adapter for PPC/Linux
Cc: dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

Thanks for the response; see my comments below:

>On Mon, Aug 13, 2001 at 12:20:28AM -0700, James F Dougherty wrote:
>>
>> (LOL) .... I have the Promise Ultra-66..... since it's
>> not working, this is what prompted me to look for an
>> alternative ..
>>
>> I have ported MontaVista HHL (Linux 2.4.2) to
>> a custom processor board, and have been
>> trying to run fdisk to setup a mountable root
>> drive.
>
>Have you tried the card in another PPC?  Are you seeing any other
>PCI related issues on your custom board?
>
Good point; the quick answer is no, since I have used a Broadcom 5701
Gigabit NIC driver on the PCI slot already and there have been no
problems with that. The interesting thing though is that in my bootloader,
I write the PCI ILINE register in config space with IRQ=3, for the PCI
slot, however, when it boots up, it is reporting IRQ=1? Perhaps my
map_pci_irq() code is broken... I did make a change to the 5701 driver
to support IRQ=3, perhaps this is what I should do for the Promise card.

Here is my map_irq() code:

static inline int
mousse_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
{
  long ctl;
  static char pci_irq_table[][4] =
	/*
	 *	PCI IDSEL/INTPIN->INTLINE
	 * 	   A   B   C   D
	 */
	{
		{  0,  0,  0,  0 },	/* IDSEL 11 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
		{  1,  1,  1,  1 },	/* IDSEL 13 - DC21143, IRQ1 */
		{  1,  1,  1,  1 },	/* IDSEL 13 - DC21143, IRQ1 */
		{  3,  3,  3,  3 },	/* IDSEL 14 - PCI slot */
		{  0,  0,  0,  0 },	/* IDSEL 15 - 82371 -unused */
		{  0,  0,  0,  0 },	/* IDSEL 16 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 17 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 18 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 19 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 20 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 21 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 22 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 23 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 24 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 25 - unused */
		{  0,  0,  0,  0 },	/* IDSEL 26 - unused */
		{  2,  2,  2,  2 },	/* IDSEL 27 - CPCI slot 6 */
		{  2,  2,  2,  2 },	/* IDSEL 28 - CPCI slot 5 */
		{  2,  2,  2,  2 },	/* IDSEL 29 - CPCI slot 4 */
		{  2,  2,  2,  2 },	/* IDSEL 30 - CPCI slot 5 */
		{  2,  2,  2,  2 },	/* IDSEL 31 - CPCI slot 6 */
	};

	const long min_idsel = 12, max_idsel = 16, irqs_per_slot = 1;

	if (idsel >= min_idsel && idsel <= max_idsel && pin <= irqs_per_slot){
	  ctl = pci_irq_table[idsel - min_idsel][pin-1];
	}

	return ctl;
}

Does this look right?

>> mousse-(17):[11:31pm]: [/>devfsd /dev
>> Started device management daemon for /dev
>> mousse-(18):[11:31pm]: [/>fdisk /dev/hda
>> modprobe: Can't locate module /dev/hda
>> modprobe: Can't locate module /dev/hda
>
>That's odd.  Do you have /dev/ide/host0/bus0/target0/lun0/anything?
(sigh), I wish :-)

>I _think_ you shouldn't see a modprobe error if the ide-disk driver is
>installed already, I think.  But I'm not sure.
>
Actually, I saw an error "modprobe: cannot locate block-major-3" when
I turned devfs off and rebuilt my kernel. With devfs enabled, I see
the ide controller in /proc/ide, however, nothing showsup in devfs.

Thoughts?

				Thanks again,
				-James


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

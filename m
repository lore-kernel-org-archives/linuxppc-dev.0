From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Linuxppc-Commit" <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Date: Thu, 20 Sep 2001 10:00:40 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJCEMADCAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3BA8DF9E.FD235CF6@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Sounds like a good idea.  Also, doing inline ... __init is rather silly.
> > How's the idea sound Dan?
>
> The idea is OK, but I would prefer a different implementation.  You
> are trying to do basically the same thing as all of the boards that
> use versions of OpenPIC, EPIC, etc.  Rather than have a fixed size
> array, and fill most of it with zero, a generic solution should be
> able to work with variable sized arrays......just pass the size
> somehow. The sizeof() works pretty well for this :-).  The boards
> initialize the array to whatever they need, and don't have to worry
> about others.

Isn't that exactly what I did (in cpci405.c)?

int __init
ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
{
	static char pci_irq_table[][4] =
	/*
	 *      PCI IDSEL/INTPIN->INTLINE
	 *      A       B       C       D
	 */
	{
		{28,	28,	28,	28},	/* IDSEL 15 - cPCI slot 8 */
		{29,	29,	29,	29},	/* IDSEL 16 - cPCI slot 7 */
		{30,	30,	30,	30},	/* IDSEL 17 - cPCI slot 6 */
		{27,	27,	27,	27},	/* IDSEL 18 - cPCI slot 5 */
		{28,	28,	28,	28},	/* IDSEL 19 - cPCI slot 4 */
		{29,	29,	29,	29},	/* IDSEL 20 - cPCI slot 3 */
		{30,	30,	30,	30},	/* IDSEL 21 - cPCI slot 2 */
        };
	const long min_idsel = 15, max_idsel = 21, irqs_per_slot = 4;
	return PCI_IRQ_TABLE_LOOKUP;
};

It seems to me, that nearly all other boards do it this way also.

Perhaps you were referring to the walnut/ep405 implementations, which still
had some zero's in the array (I corrected this by now).

Best regards,
Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

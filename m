Reply-To: <c_castanet@netcourrier.com>
From: =?iso-8859-1?Q?C=E9dric_CASTANET?= <c_castanet@netcourrier.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Force 6750 VME Board
Date: Mon, 19 Mar 2001 10:01:29 +0100
Message-ID: <000501c0b053$30221cd0$02888a8c@INFOINDUS.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <01031511102007.00679@pc-eng24.mc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
yes, it can work quickly whith minor changes on pci slots def and pci IRQ
routing.
in arch/ppc/kernel, replace PowerCoreCPCI6750_pci_IRQ_map and
PowerCoreCPCI6750_pci_IRQ_routes by the folowing def :

#ifdef CONFIG_PCORE6750
/* Force Computers PowerCore PCORE IRQ-map */

/* The first table contains an entry number
   for the second table the based on the device number.
   The second table describes the INTx interrupt wireing */

static char PowerCoreCPCI6750_pci_IRQ_map[] =
{
        0,   /* Slot 0  - unused */
        0,   /* Slot 1  - unused */
        0,   /* Slot 2  - unused */
        0,   /* Slot 3  - unused */
        0,   /* Slot 4  - unused */
        0,   /* Slot 5  - unused */
        0,   /* Slot 6  - unused */
        0,   /* Slot 7  - unused */
        0,   /* Slot 8  - unused */
        0,   /* Slot 9  - unused */
        0,   /* Slot 10 - unused */
        0,   /* Slot 11 - unused */
        0,   /* Slot 12 - unused */
        0,   /* Slot 13 - unused */
        0,   /* Slot 14 - unused */
        0,   /* Slot 15 - unused */
        0,   /* Slot 16 - unused */
        0,   /* Slot 17 - unused */
        0,   /* Slot 18 - unused */
        0,   /* Slot 19 - unused */
        0,   /* Slot 20 - unused */
        0,   /* Slot 21 - unused */
        0,   /* Slot 22 - unused */
        0,   /* Slot 23 - unused */
        1*4+1,   /* Slot 24  - UNIVERSE II */
        0,   /* Slot 25 - unused */
        1*4,   /* Slot 26 - PCI-ISA */
        1*4+0,   /* Slot 27 - DEC21143 */
        2*4+0,   /* Slot 28 - PMC I */
        3*4+0,   /* Slot 29 - PMC II */
        0,   /* Slot 30 - unused */
        0    /* Slot 31 - unused */
};
static char PowerCoreCPCI6750_pci_IRQ_routes[] =
{
      0,  0,  0,  0,    /* unused */
      9, 10, 11, 12,    /* PCI0:  INTA,INTB,INTC,INTD orig : 12 Was 15 */
     11, 12,  9, 10,    /* PMCI:  INTC,INTD,INTA,INTB orig : 12 Was 15  */
     12,  9, 10, 11     /* PMCII: INTB,INTC,INTD,INTA orig : 12, 11, 15, 9
*/
};
#endif /* CONFIG_PCORE6750*/

I think this change is enough to boot the kernel on the PCORE6750 VME but
you have to add the VME driver too.

I have a tar file of linux 2.2.14 that work basicaly whith the PCORE6750VME
whith vme driver. this is a 17Mo file, and it is not "cleanly modified" for
this board. But if you are interested contact me directly.

----------------------------------------------------------------------------
Mr Cedric CASTANET
SCT DPT INFORMATIQUE INDUSTRIELLE
30 BIS RUE EDMOND ROSTAND
31201 TOULOUSE CEDEX (FRANCE)
Tél 05.61.61.12.34
Fax : 05.61.61.12.22

web Dépt.: http://www.sct.fr.st
adresse e-mail : c_castanet@netcourrier.com
----------------------------------------------------------------------------


-----Message d'origine-----
De : owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part de Mark
Salisbury
Envoyé : jeudi 15 mars 2001 17:07
À : linuxppc-embedded@lists.linuxppc.org
Objet : Force 6750 VME Board



I see that the montavista packages support the cPCI version fo the force
6750,

has anyone tried it with the VME version?

any hints on where to begin?

thanks in advance.

	Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <200003242216.XAA00508@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 23:16:08 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10003241142540.18758-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Mar, this message from Michael Schmitz echoed through cyberspace:
>
>> >Another advantage of no longer using the information from the OF tree is that
>> >we can just call pci_assign_unassigned_resources() and get everything
>> >reassigned, without worrying about inconsistencies with the OF device tree.
>> >
>> >BTW, if you do want to keep the OF device tree consistent,
>> >pcibios_update_resource() is the place to do this.
>>
>> If this is called _after_ we have done the bus re-numbering, updating the
>> OF tree will be difficult since we need the old bus number to match the
>> PCI device with it's OF entry.
>
> On a somewhat related issue (the PCI mapping funnies for the Lombard and
> possibly other Rage Pro devices): what are the penalties if I 'correct'
> the PCI mapping for the Rage Pro within atyfb_of_init?

A good advice: don't do it ;-). If OF does something wrong with the ATI
device, then fix it in arch-specific PCI fixup code, so that all other
code using that device can be left untouched.

Put the special code in the special places, so that the general code
only needs to care for the general case ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

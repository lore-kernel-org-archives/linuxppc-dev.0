Message-Id: <199908150940.LAA00252@piglet.cpu.lu>
Date: Sun, 15 Aug 1999 11:40:23 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Various PMac PCI patches
To: mj@ucw.cz
cc: paulus@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990815103344.L145@albireo.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Martin,

Thanks for your comments. I'll give the PCI patches a bit more work,
including your suggestions below, update to 2.2.11, and resend them.

On  15 Aug, this message from Martin Mares echoed through cyberspace:
>    No driver should touch PCI_INTERRUPT_LINE at all. If it does,
> it's buggy and should be fixed instead of working around it in generic
> PCI code. The only correct way how to get the interrupt number is to
> look at pci_dev->irq (on some architectures, the interrupt numbers
> are too large to fit in the interrupt line configuration register).

OK, then I'll only update pci_dev->irq. We'll see if any driver
breaks ;-)

>> 2. I've hacked pmac_pcibios_fixup with a few changes:
>> 
>> - It now checks for PCI buses other than the first one, on all bridges.
>> This should help on the 7x00/8x00 machines (bandit and chaos host
>> bridges) as well as on the 9x00 (two bandit bridges; second bus would
>> be invisible up to now). If anyone has a 9x00, can  you test if this
>> works? For me it only detects one of two devices on bus 1....
> 
>    Isn't it possible to search for the bridges directly instead
> of scanning the PCI config space?  I see a lot of similarities between
> this and the peer host bridge problems on the PC.

Bridges, yes. But not PCI devices. What I've done is look at all the
bridges found by the platform-specific PCI code (contained in
struct bridge_data bridge_list), and scan any PCI busses off those
bridges (except bus 0, which gets scanned already).

>> - The IRQ fixup code already checks for the presence of interrupts, so
>> I'v changed Martin's comment. Also, I'm not sure if PMac PCI boards can
>> ever use more than one interrupt, as all PCI interrupt lines are OR'ed
>> together on the bridge....
> 
>    If they really are, just kill the whole comment, it's bogus.

OK, I'll do that. Paul, any idea whether the IRQ OR'ing is done on the
MPC106 as well? Geert, what about your board?

>> - I've added IO and memory space enable code from i386's fixup code,
>> minus some port address checks. This should be safe on all concerned
>> machines.
> 
>    I'm not sure whether the logic for not enabling VGA and IDE devices
> applies to PMAC as well, I think you can just remove it.

Probably not; at least on the Macs there's nothing special about VGA,
and I don't think there is any Mac with a built-in IDE controller that
identifies itself as such on the bus; rather they are integrated into
some multi-IO chip.

I'll drop that special case, then.

> Also, it would
> be better to update the PC-centric comment from my code :)

Sure ;-)

>    The rest looks OK to me.

Good!

;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-Id: <199909122102.XAA00251@piglet.cpu.lu>
Date: Sun, 12 Sep 1999 23:02:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PowerDomain 3940UWD
To: roikawa@rr.iij4u.or.jp
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990912025709X.roikawa@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  12 Sep, this message from Ryuichi Oikawa echoed through cyberspace:
>> I could imagine that certain Adaptec SCSI chips use a regular PCI
>> memory region for their registers, while others use a PCI I/O region.
>> There are chances that the PCI I/O region is not enabled on your board,
>> and therefore accessing it results in a machine check.
>  Sorry, but my question was:
>   It looks like the author of this driver assumes adaptec chips with
> 	temp_p->flags & AHC_MULTI_CHANNEL) ||
> 	temp_p->chip == (AHC_AIC7870 | AHC_PCI) ||
> 	temp_p->chip == (AHC_AIC7880 | AHC_PCI)
> cannot support MMIO and it even skips the check for MMIO ability(of course,
> check is done after enabling PCI_COMMAND_MEMORY bit), but PowerDomain3940UWD
> (AHC_MULTI_CHANNEL && (AHC_AIC7880 | AHC_PCI)) does support MMIO and works fine,
> so that I wonder if there are some broken cards or bioses with the above feature.

Ahhh... then you should get in touch with the author of the driver, and
ask about his reasons for doing so.

> Is this patch below dangerous? I'd like to use MMIO on the PPC.
[patch snip'ed]

I'd qualify it dangerous, as it assumes that you can do MMIO on _any_
Adaptec chip in a PowerPC machine....

>> Can you send me the output of lspci -vv, preferably once without the
>> aic7xxx driver in the kernel, and once with your fixes?
>  I attached current lspci -vv output and /proc/device-tree list at the
> end of this mail.

I'll comment below...

>> IRQs do get fixed, even on devices behind P2P bridges... iff OF did
>> assing IRQs, that is, as you found below.
>  Accoring to the list at the end, OF doesn't assign any IRQ to the adaptec
> SCSI controller behind the bridge and IO forwarding to the CH.A device is
> disable, though memory forwarding is enabled.

Yeah, OF didn't assign any IO region to controller 1. That's weired....
I wonder whether OF was confused because of two identical PCI devices...

>  If disabled IO forwarding is a problem, I think the fixing is a
> pcibios_fixupbus()'s job that is currently empty. It should be scanning
> all PCI devices' base addresses behind the bridge and setting/expanding
> IO/memory limits recursively. For that purpose, some methods will be
> necessary that can judge properly whether the base address is right or
> wrong because some broken logic board may write wrong values to the
> base address registers. And I have no idea on that metohd...

Right now, there are no methods implemented in Linux for assigning
resources to PCI devices _after_ startup; we're relying on the BIOS to
do that. If it does a bad job, then that has to be fixed in
pcibios_fixup(). However, there is work underway related to hotplug PCI
support, where dynamic resource assigment is a must.

pcibios_fixupbus() might be empty right now, but every machine type
under the PPC arch has it's own pcibios_fixup() routine; the one for
PowerMacs is in arch/ppc/kernel/pmac_pci.c. There is already some work
done there for fixing IRQ numbers; I'm workjing on adding even more
fixup. The IRQ problem you discovered is a good candidate for inclusion
as well.

>> Your fix looks OK to me; on PowerMacs, all PCI devices in any one slot
>> share the same interrupt, as the four PCI interrupt pins are OR'ed
>> together per slot.
>  I see. Then assignig IRQ's to the only the top of the device node per
> physical slot may be curious but reasonable, even if it is a non-interrupt
> generating PCI-bridge.
> 
>> > I don't know if it is OF(PowerMac8500, OF 1.0.5) version specific,
>> > or SCSI card specific, or PowerMac OF nature. Any ideas?
>> 
>> Either OF-specific in general, or one of the many bugs in OF 1.0.5.
>> Anyway, as I said, your patch wouldn't break anything, even if OF did
>> assign IRQs already.
> Thank you, then would someone apply the patch to the kernel development
> tree?

I'm only wondering about the more general case of a device without
IRQ... Will this patch make interrupts appear on those devices?

> lspci -vv:
> 00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02)
> 	I/O behind bridge: 00001000-00001fff

This IO wondow seems to be too small to accomodate both controllers....
I suppose OF assigned it too small?

> 01:04.0 SCSI storage controller: Adaptec AIC-7882U
> 	Region 0: I/O ports at <unassigned>

..... here OF didn't assign any IO region.

> 01:05.0 SCSI storage controller: Adaptec AIC-7882U
>
> and list of /proc/device-tree:
> /proc/device-tree/bandit/pci-bridge:
> name             "pci-bridge"
>  
> /proc/device-tree/bandit/pci-bridge/ADPT,3940UW:
> name             "ADPT,3940UW"
> 
> /proc/device-tree/bandit/pci-bridge/pci9004,8278:
> name             "pci9004,8278"

That's the easy way to assign differing device names in OF... Although,
if I remeber right, the OF code onboard should generate differing names
by itslef, shouldn't it?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

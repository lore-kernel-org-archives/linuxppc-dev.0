To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerDomain 3940UWD
In-Reply-To: Your message of "Thu, 9 Sep 1999 20:14:48 +0200 (CEST)"
	<199909091814.UAA00323@piglet.cpu.lu>
References: <199909091814.UAA00323@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990912025709X.roikawa@rr.iij4u.or.jp>
Date: Sun, 12 Sep 1999 02:57:09 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Michel Lanners <mlan@cpu.lu>
Subject: Re: PowerDomain 3940UWD
> > #ifdef MMAPIO
> >           if ( !(temp_p->flags & AHC_MULTI_CHANNEL) ||
> >                ((temp_p->chip != (AHC_AIC7870 | AHC_PCI)) &&
> >                 (temp_p->chip != (AHC_AIC7880 | AHC_PCI))) )
> >           {
> > 	   ...... select MMIO and does ioremap ....
> >            ...... if it fails select normal IO ....
> > 	  }
> > #endif

> I could imagine that certain Adaptec SCSI chips use a regular PCI
> memory region for their registers, while others use a PCI I/O region.
> There are chances that the PCI I/O region is not enabled on your board,
> and therefore accessing it results in a machine check.
 Sorry, but my question was:
  It looks like the author of this driver assumes adaptec chips with
	temp_p->flags & AHC_MULTI_CHANNEL) ||
	temp_p->chip == (AHC_AIC7870 | AHC_PCI) ||
	temp_p->chip == (AHC_AIC7880 | AHC_PCI)
cannot support MMIO and it even skips the check for MMIO ability(of course,
check is done after enabling PCI_COMMAND_MEMORY bit), but PowerDomain3940UWD
(AHC_MULTI_CHANNEL && (AHC_AIC7880 | AHC_PCI)) does support MMIO and works fine,
so that I wonder if there are some broken cards or bioses with the above feature.

Is this patch below dangerous? I'd like to use MMIO on the PPC.

--- aic7xxx.c.orig      Thu Sep  9 23:00:59 1999
+++ aic7xxx.c   Thu Sep  9 23:03:06 1999
@@ -9660,9 +9660,11 @@
           }

 #ifdef MMAPIO
+#if !defined(__powerpc__)
           if ( !(temp_p->flags & AHC_MULTI_CHANNEL) ||
                ((temp_p->chip != (AHC_AIC7870 | AHC_PCI)) &&
                 (temp_p->chip != (AHC_AIC7880 | AHC_PCI))) )
+#endif
           {
             unsigned long page_offset, base;

> Can you send me the output of lspci -vv, preferably once without the
> aic7xxx driver in the kernel, and once with your fixes?
 I'm very sorry, but I can't show the lspci output without the
aic7xxx driver because the SCSI card is now connected to the root
device.
 I attached current lspci -vv output and /proc/device-tree list at the
end of this mail.

> IRQs do get fixed, even on devices behind P2P bridges... iff OF did
> assing IRQs, that is, as you found below.
 Accoring to the list at the end, OF doesn't assign any IRQ to the adaptec
SCSI controller behind the bridge and IO forwarding to the CH.A device is
disable, though memory forwarding is enabled.
 If disabled IO forwarding is a problem, I think the fixing is a
pcibios_fixupbus()'s job that is currently empty. It should be scanning
all PCI devices' base addresses behind the bridge and setting/expanding
IO/memory limits recursively. For that purpose, some methods will be
necessary that can judge properly whether the base address is right or
wrong because some broken logic board may write wrong values to the
base address registers. And I have no idea on that metohd...
 
> Your fix looks OK to me; on PowerMacs, all PCI devices in any one slot
> share the same interrupt, as the four PCI interrupt pins are OR'ed
> together per slot.
 I see. Then assignig IRQ's to the only the top of the device node per
physical slot may be curious but reasonable, even if it is a non-interrupt
generating PCI-bridge.

> > I don't know if it is OF(PowerMac8500, OF 1.0.5) version specific,
> > or SCSI card specific, or PowerMac OF nature. Any ideas?
> 
> Either OF-specific in general, or one of the many bugs in OF 1.0.5.
> Anyway, as I said, your patch wouldn't break anything, even if OF did
> assign IRQs already.
Thank you, then would someone apply the patch to the kernel development
tree?


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp


Attached lists from here------

lspci -vv:
00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 80800000-808fffff
	Prefetchable memory behind bridge: 80800000-807fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:04.0 SCSI storage controller: Adaptec AIC-7882U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at <unassigned>
	Region 1: Memory at 80800000 (32-bit, non-prefetchable)

01:05.0 SCSI storage controller: Adaptec AIC-7882U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at 1000
	Region 1: Memory at 80801000 (32-bit, non-prefetchable)

and list of /proc/device-tree:
/proc/device-tree/bandit/pci-bridge:
name             "pci-bridge"
vendor-id        00001011 (4113)
device-id        00000001
revision-id      00000002
class-code       00060400 (394240)
devsel-speed     00000001
fast-back-to-back
AAPL,interrupts  00000017 (23)
AAPL,slot-name   "A1"
device_type      "pci"
reg              00006800 00000000 00000000 00000000 00000000
#address-cells   00000003
#size-cells      00000002
ranges
bus-range        00000001 00000001
power-consumption 007270e0 007270e0
assigned-addresses
AAPL,address
driver-ist       000651a0 00000007 00000000 00000000 00000000 00000000
 
/proc/device-tree/bandit/pci-bridge/ADPT,3940UW:
name             "ADPT,3940UW"
vendor-id        00009004 (36868)
device-id        00008278 (33400)
revision-id      00000000
class-code       00010000 (65536)
interrupts       00000001
min-grant        00000008
max-latency      00000008
devsel-speed     00000001
fast-back-to-back
AAPL,slot-name   "A1"
fcode-rom-offset 00000000
device_type      "scsi-2"
model            "ADPT,942106-00"
compatible       "ADPT,AIC-7880"
ADPT,fcode-date  "04/07/99"
reg              00012000 00000000 00000000 00000000 00000000
                 02012014 00000000 00000000 00000000 00000100
                 02012030 00000000 00000000 00000000 00010000
power-consumption 00000000 00000000 007270e0 007270e0
                 00000000 00000000 007b98a0 007b98a0
assigned-addresses 82012030 00000000 80820000 00000000 00010000
                 82012014 00000000 80800000 00000000 00000100
AAPL,address     80820000 80800000
driver-ist       00065fb0 00000001 00000000 00000000 00000000 00000000
driver-descriptor 6d74656a 00000000 0b414450 542c3339
                 34305557 00000000 00000000 00000000
                 00000000 00000000 04108000 00000004
                 0d2e4164 61707465 63204348 494d0000
                 00000000 00000000 00000000 00000000
                 00000000 00000000 00000000 00000000
                 00000000 00000000 00000000 00000000
                 00000001 73637369 00000000 01000000
driver-ptr       0006c590 (443792)

/proc/device-tree/bandit/pci-bridge/pci9004,8278:
name             "pci9004,8278"
vendor-id        00009004 (36868)
device-id        00008278 (33400)
revision-id      00000000
class-code       00010000 (65536)
interrupts       00000001
min-grant        00000008
max-latency      00000008
devsel-speed     00000001
fast-back-to-back
AAPL,slot-name   "A1"
reg              00012800 00000000 00000000 00000000 00000000
                 01012810 00000000 00000000 00000000 00000100
                 02012814 00000000 00000000 00000000 00001000
                 02012830 00000000 00000000 00000000 00010000
assigned-addresses 81012810 00000000 00001000 00000000 00000100
                 82012830 00000000 80810000 00000000 00010000
                 82012814 00000000 80801000 00000000 00001000
AAPL,address     f2001000 80810000 80801000
driver-ist       00065fb0 00000002 00000000 00000000 00000000 00000000

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

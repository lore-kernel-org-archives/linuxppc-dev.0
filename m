Message-Id: <200012011956.UAA00670@piglet.grunz.lu>
Date: Fri, 1 Dec 2000 20:56:28 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dual IRQ 23 (was: USB?; 2.2.18 no boot?; aic7xxx?)
To: jeglin@4pi.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p04330100b64a0cac23a1@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  28 Nov, this message from Stefan Jeglinski echoed through cyberspace:
> lspci -vv is attached at the end. The key point is that the entry for
> the Adaptec 2940UW card and the Orangelink USB card BOTH say:
>
> 	Interrupt: pin A routed to IRQ 23

> 00:0d.0 SCSI storage controller: Adaptec AIC-7881U
[snip]
> 	Interrupt: pin A routed to IRQ 23

> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
[snip]
> 	Interrupt: pin A routed to IRQ 24
>
> 00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100
> (rev 11) (prog-if 00 [Normal decode])
>
[snip]
> 01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd
> (rev 01) (prog-if 10 [OHCI])
[snip]
> 	Interrupt: pin A routed to IRQ 1
       This is most certainly wrong -> ^
>
> 01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
[snip]
> 	Interrupt: pin A routed to IRQ 23
                        and this too ->^^

Bot of these devices should get IRQ25. Why? Because on Macs, all four
IRQ lines of a PCI slot are OR'ed together on the bridge chip.
Therefore, there is one single fixed IRQ per PCI slot. So, the devices
behind the PCI-to-PCI bridge in slot 00:0f should all have the same IRQ,
which should be, following the obvious logic, IRQ 25.

Either a problem with the P2P bridge code in Linux, or with detecting
the IRQ's out of OF, as Ben suggested.

Stefan, you could try hardcoding that IRQ in the PCI fixup code, or in
the driver, and see whether that works...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

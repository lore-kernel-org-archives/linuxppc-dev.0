Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis <hollis-lists@austin.rr.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PReP and generic PCI resource assignment
Date: Wed, 8 Aug 2001 20:34:30 -0500
Cc: Matt Porter <mporter@mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
References: <01080800112002.00491@silence.internal> <20010808102731.24623@smtp.adsl.oleane.com>
In-Reply-To: <20010808102731.24623@smtp.adsl.oleane.com>
MIME-Version: 1.0
Message-Id: <01080820343003.00492@silence.internal>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 08 August 2001 05:27, Benjamin Herrenschmidt wrote:
> >The problem is that root in this case is the PCI memory resource of the
> > host bridge, which correctly starts at 0xc0000000... but NOT in bus
> > terms. In bus terms it starts at 0x0. (CPU physical 0xc0000000 = PCI bus
> > 0x0 [IO mem].) So the new resource is assigned 0xc1000000, which is
> > written back to the BAR with pcibios_update_resource... which is way
> > wrong.
>
> The resource is in CPU space. The problem must be with
> pcibios_update_resource, which is responsible for doing the proper
> offset. If you look closely, it substracts hose->pci_mem_offset from the
> resource before writing it to the BAR.
> If your hose pci_mem_offset is wrong, then it can't work. It should be
> 0xc0000000 on PReP.

Yes, it is. I misinterpretted my debug output... :/

At any rate, relocating PCI resource 1 on this controller from 0x0 to
0x01000000 causes my VGA console to go backwards endian. I don't know why
this would be the case... Re-moving it back to 0x0 fixes the symptom. Any
ideas on why this could happen? I think VGA is all IO, no memory at all?

I'm curious about PCIBIOS_MIN_MEM... Why does that exist, and why was it
given that value?

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis <hollis@austin.rr.com>
Cc: Matt Porter <mporter@mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PReP and generic PCI resource assignment
Date: Wed, 8 Aug 2001 12:27:31 +0200
Message-Id: <20010808102731.24623@smtp.adsl.oleane.com>
In-Reply-To: <01080800112002.00491@silence.internal>
References: <01080800112002.00491@silence.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The problem is that root in this case is the PCI memory resource of the host
>bridge, which correctly starts at 0xc0000000... but NOT in bus terms. In bus
>terms it starts at 0x0. (CPU physical 0xc0000000 = PCI bus 0x0 [IO mem].) So
>the new resource is assigned 0xc1000000, which is written back to the BAR
>with pcibios_update_resource... which is way wrong.

The resource is in CPU space. The problem must be with
pcibios_update_resource, which is responsible for doing the proper
offset. If you look closely, it substracts hose->pci_mem_offset from the
resource before writing it to the BAR.
If your hose pci_mem_offset is wrong, then it can't work. It should be
0xc0000000 on PReP.

>Now if resources could be assigned properly in the first place this code path
>wouldn't be taken, but quite a few things fail (request_resource's and
>pci_find_parent_resource's) and it's proving difficult to track down why
>(maybe I've been staring at this too long).
>
>Anyways, when I change "root->start" above to be 0, the symptom is fixed, but
>that's clearly a hack. I don't see how anything PReP (system IO nor IO
>memory) could escape generic resource assignment unscathed though.

The fix is to have pci_mem_offset set properly when setting up the
pci_controller structure.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200108271626.MAA23394@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCSI PMC card
Date: Mon, 27 Aug 2001 12:18:49 -0400
References: <85256AB5.004EE95C.00@pine.cspi.com>
In-Reply-To: <85256AB5.004EE95C.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been tracing through the PCI resources for 2 days now and I have
finally gotten to the source of the hang condition. When I go off and try to
read the PCI_SUBSYSTEM_ID or the PCI_VENDOR_SUBSYSTEM_ID I hang hard. I have
been crawling back up the PCI bus scanning and I find that even if I try to
read the SUBSYSTEM_ID immediately after the card is found on the bus ie in
pci_scan_device. The system hangs. The strange thing is I can see the correct
PCI_VENDOR_ID without failure. Have you ever seen a card that does not
respond at all the the SUBSYTEM_IDs? On the PMCSPAN it is ok. I'll keep
digging in. If anyone has played with a sym53c895 SCSI card and knows some
firmware problems, please let me know.


Thanks
Brian



On Monday 27 August 2001 10:21 am, you wrote:
> On Fri, Aug 24, 2001 at 03:23:10PM -0400, Brian Waite wrote:
> > Ok now I moved up to a 2.4.9 kernel from the linuxppc_2_4_stable tree and
>
> I
>
> > see the same problem. Here is the output of debug being defined in both
> > drivers/pci.c and arch/ppc/kernel/pci.c. Below are the dumps of 2 boots,
>
> one
>
> > without the SCSI card attached and one with the SCSI card attached to the
> > baseboard. Does anything looks suspicious? This card did work on the base
> > under 2.2.18 when I initiaslly tested it.
>
> Everything looks good...excepting the unassigned resource (which isn't
> used by the tulip driver anyway).  I've never seen a hard hang except
> on a new bridge design bringup so you're going to have to trace the
> flow through all the resource assignment process.
>
> > PS I can't seem to get my 2.4 devel tree to boot on the 2400, the
> > decompress_kernel fails with fffffffd.
>
> I think Gabriel Paubert is the only other person I've seen using  Linux
> on a 2400 lately...maybe he'll chime in.  It could be a temporary effect
> of the bootloader reorg right now...prep is being touched.
>
> Regards,

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Fri, 13 Oct 2000 09:19:04 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board
Message-ID: <20001013091904.B24968@beef.az.mvista.com>
References: <20001012101130.A2964@cx258813-a.chnd1.az.home.com> <Pine.LNX.4.21.0010131718080.5959-100000@ipnpcu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0010131718080.5959-100000@ipnpcu5>; from grave@ipno.in2p3.fr on Fri, Oct 13, 2000 at 05:20:04PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 13, 2000 at 05:20:04PM +0200, Xavier Grave wrote:
> Hi all,
>
> I've downloaded the linuxppc_2_5 tree with bitkeeper and compiled it for
> my prep board I always have the same message :
> PCI: Cannot allocate resource region 0 of device 00:0d.0
> PCI: Cannot allocate resource region 1 of device 00:0e.0
> PCI: Cannot allocate resource region 1 of device 00:11.0
> PCI: Cannot allocate resource region 2 of device 00:11.0
> PCI: Failed to allocate resource 2 for Symbios Logic Inc. (formerly
> NCR) 53c895
>
> and after the sym53c8xx driver give the following :
>
> sym53c895-0: Downloading SCSI SCRIPTS.
> scsi0 : sym53c8xx - version 1.6b
> scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
> lun 0 Inquiry 00 00 00 ff 00
> sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
> SCSI host 0 abort (pid 0) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> sym53c8xx_reset: pid=0 reset_flags=2 serial_number=1
> serial_number_at_timeout=1
>
> Any idea why this continue to fail ?

Standard 2.4 PCI resource handling problems.  #define DEBUG in
arch/ppc/kernel/pci.c and show us your output.  The request_resource()
call is failing.

BAR2 (resource region 2) is the on chip RAM on LSI Logic's 53c8xx SCSI
chips, it's looking for an 8KB allocation in PCI memory space.  If it
doesn't get placed, then the 895 driver can't kick off the bus master
driven transfer to download the scripts into the 895's on-chip RAM.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

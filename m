Date: Thu, 12 Oct 2000 10:11:30 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board
Message-ID: <20001012101130.A2964@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.21.0010121107090.10161-100000@ipnpcu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0010121107090.10161-100000@ipnpcu5>; from grave@ipno.in2p3.fr on Thu, Oct 12, 2000 at 11:14:54AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 12, 2000 at 11:14:54AM +0200, Xavier Grave wrote:
>
> Hi all,
>
> I'm new to this list. I'm working on a VME Board from motorolla
> (MVME2303) and I have a 2.2.17 kernel running without problem.
>
> The board have a Pci Mezzanine Card with a NCR 53c895 chip for my SCSI
> disk. When I try to boot the latest kernel (I'm trying from 2.4.0-test6 up
> to 2.4.0-test10) I have the following error message during boot :
>
> PCI: Cannot allocate resource region 1 of device 00:11.0
> PCI: Cannot allocate resource region 2 of device 00:11.0
> PCI: Failed to allocate resource 2 for Symbios Logic Inc. (formerly
> NCR) 53c895
>
> which leads to the following :
> sym53c895-0: Downloading SCSI SCRIPTS.
> scsi0 : sym53c8xx - version 1.6b
> scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
> lun 0 Inquiry 00 00 00 ff 00
> sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
> SCSI host 0 abort (pid 0) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> sym53c8xx_reset: pid=0 reset_flags=2 serial_number=1
> serial_number_at_timeout=1
> sym53c895-0: unable to abort current chip operation.
> SCSI host 0 abort (pid 0) timed out - resetting
>
> Anyone have an idea how to solve this ?

Try the latest linuxppc_2_5 tree.  See
http://www.fsmlabs.com/linuxppcbk.html for instructions.

The sym53c8xx driver uses PCI mem accesses which broke on previous
kernel on PReP memory maps since they don't map CPU<->PCI 1:1.
ioremap now compensates for this on non 1:1 maps.

Tested on MTX and legacy PReP systems (Blackhawk and Utah). YMMV.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

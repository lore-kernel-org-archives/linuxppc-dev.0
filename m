From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Date: Fri, 12 Oct 2001 10:10:12 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
References: <200110090238.f992cCY63439@aslan.scsiguy.com>
In-Reply-To: <200110090238.f992cCY63439@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0DJ3Z8EP8VA9F3K8X2OZ"
Message-Id: <20011012140752.FUZG10438.tomts12-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_0DJ3Z8EP8VA9F3K8X2OZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Justin,

> >aic7xxx_abort returns 8194
>
> You need to boot with "aic7xxx=verbose" for the driver to output
> data that will help me track down your problem.  My first guess
> is an interrupt routing problem, but verbose messages will allow
> me to tell for sure.
>
> >>SCSI subsystem driver Revision: 1.00
> >>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>
> The latest is 6.2.3, but I don't believe there are any fixes since
> 6.2.1 that will help your particular problem.

Okay, here are the results with verbose turned on with the latest 2.4.11
kernel from Ben.  They are in two parts.  The first is what dmesg has to
say about the scsi subsystem.  The second part is a gzipped piece of the
relevant /var/log/messages file.

Here is what dmesg says:

SCSI subsystem driver Revision: 1.00
ahc_pci:1:2:0: Reading SEEPROM...done.
ahc_pci:1:2:0: internal 50 cable not present
ahc_pci:1:2:0: external cable not present
ahc_pci:1:2:0: BIOS eeprom not present
ahc_pci:1:2:0: Low byte termination Enabled
ahc_pci:1:2:0: Downloading Sequencer Program... 450 instructions downloaded
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/255 SCBs

  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300N
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140N          Rev: 1498
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: L.27
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:1): 3.300MB/s transfers
scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:3): 3.300MB/s transfers
scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi2 : MESH
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
Attached scsi removable disk sdc at scsi0, channel 0, id 5, lun 0
(scsi0:A:1:0): Sending SDTR period c, offset f
(scsi0:A:1:0): Received SDTR period c, offset f
        Filtered to period c, offset f
(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 1 synchronous at 20.0MHz, offset = 0xf
SCSI device sda: 6281856 512-byte hdwr sectors (3216 MB)
 /dev/scsi/host0/bus0/target1/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8
(scsi0:A:3:0): Sending SDTR period c, offset f
(scsi0:A:3:0): Received SDTR period c, offset f
        Filtered to period c, offset f
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 3 synchronous at 20.0MHz, offset = 0xf
SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target3/lun0: [mac] p1 p2 p3 p4 p5 p6 p7
SCSI device sdc: 196608 512-byte hdwr sectors (101 MB)
sdc: Write Protect is off
 /dev/scsi/host0/bus0/target5/lun0: [mac] p1 p2 p3 p4 p5 p6

The error messages for /var/log/messages are gzipped and attached as
part2.log.gz

I hope this tells you something.  If I can provide any additional
information in order to help track this down.  Please let me know.

Thanks again,

Kevin

--------------Boundary-00=_0DJ3Z8EP8VA9F3K8X2OZ
Content-Type: application/x-gzip;
  name="part2.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="part2.log.gz"

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

--------------Boundary-00=_0DJ3Z8EP8VA9F3K8X2OZ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

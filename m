From: phandel@cise.ufl.edu
Date: Wed, 21 Jun 2000 12:56:22 -0700 (PDT)
To: Mike DeSimone <desimone@arlut.utexas.edu>, deischen@iworks.InterWorks.org,
        dledford@redhat.com
cc: Giuliano Pochini <pochini@shiny.it>, linuxppc-dev@lists.linuxppc.org
Subject: Adaptec 2930 only at 10MB/sec [was Re: Slow Adaptec]
In-Reply-To: <v04020a08b57676893fce@[129.116.176.243]>
Message-ID: <Pine.LNX.4.21.0006211248390.671-100000@handpe3.apple.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 21 Jun 2000, Mike DeSimone wrote:

> >Is there any boot parameter or so to make it work in "ultra" mode ?
>
> I think what you want is in this clip from
> /usr/src/linux/drivers/scsi/aic7xxx.c:
>
>  *  A Boot time option was also added for not resetting the scsi bus.
>  *
>  *    Form:  aic7xxx=extended
>  *           aic7xxx=no_reset
>  *           aic7xxx=ultra
>  *           aic7xxx=irq_trigger:[0,1]  # 0 edge, 1 level
>  *           aic7xxx=verbose
>  *
>
> So you might try aic7xxx=ultra or aic7xxx=ultra,verbose.

I tried your latter suggestion, yet my dmesg still indicates only
10MB/sec on my PowerCenter Pro 210mhz/224MB RAM / kernel 2.2.16:

(scsi0) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 0/17/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Warning - detected auto-termination
(scsi0) Please verify driver detected settings are correct.
(scsi0) If not, then please properly set the device termination
(scsi0) in the Adaptec SCSI BIOS by hitting CTRL-A when prompted
(scsi0) during machine bootup.
(scsi0) Cables present (Int-50 YES, Ext-50 NO)
(scsi0) Downloading sequencer code... 423 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.28/3.2.4
       <Adaptec AIC-7860 Ultra SCSI host adapter>
scsi1 : 53C94
scsi : 2 hosts.
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST52160N          Rev: 0285
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DDRS-39130        Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 6, lun 0
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
  Vendor: TEAC      Model: CD-ROM CD-516S    Rev: 1.0D
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
scsi : detected 4 SCSI generics 2 SCSI cdroms 2 SCSI disks total.
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.09
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4238282 [2069 MB] [2.1
GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17850000 [8715 MB] [8.7
GB]


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

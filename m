Date: Tue, 26 Jan 1999 20:56:49 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: linuxppc-dev@lists.linuxppc.org
cc: Cort Dougan <cort@persephone.cs.nmt.edu>, Mike McQuade <mmcquade@aa.net>,
        Matt Porter <mmporter@home.com>,
        Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>,
        VALETTE Eric <valette@crf.canon.fr>,
        "Tom Ho [4615]" <tho@glenvan.glenayre.com>,
        Troy Benjegerdes <hozer@drgw.net>, Michael Lundkvist <ml@epact.se>,
        Joseph MONTRI <montri@onera.fr>,
        "William E. Schaffer" <wschaffe@telesciences.com>,
        Jim Somerville <somer@nortelnetworks.com>,
        Greg Stovall <Greg.Stovall.gstovall@nt.com>,
        Sjur Jonas Vestli <s.vestli@ieee.org>, Gary Thomas <gdt@linuxppc.org>
Subject: New version of preploader, linux-2.2.0-final on MVME2600 and others.
In-Reply-To: <Pine.LNX.3.96.990123112604.6129B-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990126202238.2291I-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




[Note: I have added a direct message to most people who have
shown a direct interest in getting Linux on MVME/CompactPCI/MTX boards.]

Here it is, after a few crazy days I've finally tracked down a very
annoying bug (due to stale TLB entries from the bootloader into the loaded
kernel images). I also slightly reorganized my ftp server: at 
<URL:ftp:://vcorr1.iram.es/pub/linux-2.2/> you'll find the following:

- mvme2600.config: a basic config file to get linux running on MVME2600 
(and probably 3600) boards.

- mvme2600.config.initrd: the same with initrd support

- zImage-2.2.0-final: the image I'm currently running on the server

- zImage.initrd-2.2.0-final: the same image with an initrd disk,
  unfortunately it seems that I picked the wrong initrd.gz which insists
  on using PMAC partitions instead of standard PC partitions.  But using
  it on a serial console is not fun, so I might have missed something in
  the boxes surrounded by rows of `A'. I don't know where to get the
  correct initrd.gz, but at least it decompresses it and can boot from it
  so if a kind sould could send me the initrd.gz for PreP systems... 

- mvme2600.patch-2.2.0-final: the patch file of my source code relative
  to Linus' 2.2.0-final. I have switched to Linus' tree and don't plan
  to go ever back to vger due to the numerous problames I had to access
  it from here (the mirrors of 2.2.0 allow me to upgrade when I want, not
  when vger lets me). This includes a patch to drivers/scsi/ncr53c8xx.c
  to avoid the CACHE TEST FAILED messages and a preliminary driver for
  the Universe PCI<->VME bridge and an example driver for a specific
  board (which I've been running for days at 500 interrupts/second).

- preploader.tgz which I have not yet integrated into the source tree
  (I shall have a look at Troy's patches to integrate it tomorrow).
  I'm not yet happy with some of the fixes to work around some machines
  which provide wrong residual data. So expect more tweaks soon.

Please comment, test and report...

	Cheers,
	Gabriel.







[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

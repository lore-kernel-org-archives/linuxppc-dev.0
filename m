Message-ID: <38B6596F.2AF01EF9@pop.agri.ch>
Date: Fri, 25 Feb 2000 11:29:03 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCMCIA on PowerBook G3
References: <38B64309.80D4D15B@mpifr-bonn.mpg.de> <38B646F6.DFB8D167@pop.agri.ch> <38B64AAC.98522C83@mpifr-bonn.mpg.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albrecht Dreﬂ wrote:
>
> Andreas Tobler wrote:
> > As you've sent in an earlier message you're aware of the CardBus patch.
>
> I know...  But in this case, I would like to use the PCMCIA package with a
> Adaptec 1480 scsi card (just a test, because we need scsi for tapes, and the new
> PowerBooks don't have the built-in MESH any more).  Afaik, there is only a
> driver which needs all the pcmcia stuff to run.

What do mean exactly 'only one driver'?

The Adaptec 1480 is a CARDBUS not a PCMCIA card. It is 32 bit. When you
apply the patch from Ryuichi Oikawa then the PCI probing should give the
information further to the cb_enabler I think.
I had the same behaviour when NOT applying this patch. Then I got also
this messages:

cardmgr[284]: unsupported card in socket 0
kernel: cs: cb_alloc(bus 1): vendor 0xffff, device 0xffff
kernel: cs: no valid ROM images found!

When you look into config from /etc/pcmcia you'll see the device:
device "apa1480_cb"
  class "scsi" module "cb_enabler", "apa1480_cb"

Here the driver is integrated after the cb_enabler which is responsible
for correct notifying the CardBus Card.

I don't have experiences with scsi, but as soon as the PCI probing
works, the cardmgr should be able to tell you at least what card you
inserted.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Date: Fri, 12 Oct 2001 12:38:28 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
References: <200110121622.f9CGMmY11334@aslan.scsiguy.com>
In-Reply-To: <200110121622.f9CGMmY11334@aslan.scsiguy.com>
MIME-Version: 1.0
Message-Id: <20011012163608.GLTX14703.tomts20-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Justin,

On October 12, 2001 12:22, Justin T. Gibbs wrote:
> >Here is what dmesg says:
> >
> >SCSI subsystem driver Revision: 1.00
> >ahc_pci:1:2:0: Reading SEEPROM...done.
> >ahc_pci:1:2:0: internal 50 cable not present
> >ahc_pci:1:2:0: external cable not present
>
> What is your real cable configuration?  This implies that we found
> *no* cables on the card.  I'm sure that is not correct.  Can you also
> tell me the exact markings on the card?  I'd like to fix the cable
> detection logic.

This card is the Adaptec PCI card that apples shipped (ships?) as part of
it Build-To-Order process.  The card is identified as an Adaptec 2930CU
and it has the following numbers (taken from Open Firmware)
1686806-04
Rom # 4.0
rev. 3

The card has no internal cables connected.  It is used to drive provide
external scsi support.  Apple installed the card and it ships with a
converter to convert it to the db 25 like connector previously used by
Apple for its scsi devices.

> From the messages file, it appears that the timing out device is
> simply not bothering to complete commands it has accepted.  We
> abort these stuck commands successfully and even try them again,
> but the device won't cooperate.  This appears to be your Quantum
> Fireball - a drive with a very spotty history.

Never a day of trouble with it under Mac or Linux up till the point I used
the new driver.  Still works fine under the old aic7xxx driver.

> Perhaps the drive
> will function correctly if tagged queing is disabled for it.  You
> can do this only for target 1 with the "tag_info" option.  There may
> also be firmware updates for this drive.

Can you be more specific about how to use the "tag_info" option.  Where is
this option set (in the driver source code?) Or is it passed to the kernel
liek the aic7xxx=verbose option.  If the latter, what syntax should I be
using so that I can test that option.

Thanks for you time with it.  I really apreciate it.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

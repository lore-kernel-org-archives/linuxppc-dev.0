Message-Id: <200110121622.f9CGMmY11334@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X 
In-Reply-To: Your message of "Fri, 12 Oct 2001 10:10:12 EDT."
             <20011012140752.FUZG10438.tomts12-srv.bellnexxia.net@there>
Date: Fri, 12 Oct 2001 10:22:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Here is what dmesg says:
>
>SCSI subsystem driver Revision: 1.00
>ahc_pci:1:2:0: Reading SEEPROM...done.
>ahc_pci:1:2:0: internal 50 cable not present
>ahc_pci:1:2:0: external cable not present

What is your real cable configuration?  This implies that we found
*no* cables on the card.  I'm sure that is not correct.  Can you also
tell me the exact markings on the card?  I'd like to fix the cable
detection logic.

>From the messages file, it appears that the timing out device is
simply not bothering to complete commands it has accepted.  We
abort these stuck commands successfully and even try them again,
but the device won't cooperate.  This appears to be your Quantum
Fireball - a drive with a very spotty history.  Perhaps the drive
will function correctly if tagged queing is disabled for it.  You
can do this only for target 1 with the "tag_info" option.  There may
also be firmware updates for this drive.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

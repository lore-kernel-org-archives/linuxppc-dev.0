From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
Date: Thu, 27 Jul 2000 23:21:38 +0200
Message-Id: <20000727212138.24053@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.4.10.10007272243590.20355-100000@zirkon.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10007272243590.20355-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> looking at the mediabay code, the media bay (at least when containing a CD)
>> seems to be reset.  (set_media_bay is called, feature_set(reset) is
>called on
>> the bay, messages confirms call to set_media_bay with a "kernel: media
bay 0
>
>I don't think that's the IDE device reset, just a reset for the media bay
>controller (or the IDE controller) itself.

There should also be a reset of the disk itself (via the reset line).

>That might be a problem - the mediachange call might conflict with the VFS
>still holding open channels to the device?

Yep. That's a "generic" problem with the current sleep code (and with
media-bay removal in general). linux 2.2 is not really prepared to handle
hot-swap of IDE disks.

>You know, I just remebered the same revalidate call. It's used for disks
>when the partition table was changed, and I recall it fails when there are
>other open channels to the disk as well. Moreover, check_media_change
>should _check_ for media change, not behave as if the media changed (which
>may be difficult to do across a sleep if the CD-ROM always reportss 'maybe
>the media was changed while I was asleep'. In that case, maybe reading in
>the superblock and comparing it with a cached copy should be done (that's
>so obvious, it may have been implemented ten years ago :-).

In any way, I still have my problem of setting nIEN in the IDE control
register of some powerbooks causing a hang of the entire machine (bus not
ack'ing ?). Other IDE registers work fine and the IDE control register
seems to work fine in normal conditions, the hang only happens when
setting this inside my set_feature code. I'm wondering if it's due to a
very crappy CD-ROM drive, a very-crappy Apple home-made IDE controller,
or be missing something obvious...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

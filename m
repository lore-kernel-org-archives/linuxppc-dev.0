Date: Sun, 6 Dec 1998 19:59:52 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        VALETTE Eric <valette@crf.canon.fr>
Subject: Re: Why only relocating the first three PCI base address???
In-Reply-To: <Pine.LNX.3.96.981204165003.7673A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.981206195543.17076N-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 4 Dec 1998, Cort Dougan wrote:

> 
> The only board I know of that needs to be relocated on prep is the ncr
> controller on some machines.  The first 3 base addrs (the only ones it
> uses I think) were too high.  So I moved the relocation code out of the
> driver (it was a big hack that Gerard let me keep there this long) into
> the prep specific code.
> 
> }But maybe the fact that it needs to be relocated is due to a specific bug
> }of the adaptec board ?

Actually, my PreP bootloader takes a very radical approcah at this: 
it scans the PCI bus and reallocates all resources of all devices it finds
to make them fit in as little space as possible.

The code for PCI<->PCI bridges haas not been written however, since I've
not been able to get any such beast. 

The main argument to do this was to correctly allocate resourecs to an s3
Trio which claims it needs 8Mb but actually requires 64. This made
the board unusable with the S3 frame buffer enabled since PPCBug would
believe the PCI configuration space header and cause conflicts on the bus.

	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

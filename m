Message-ID: <38C42DE9.45EB8A99@amberdata.demon.co.uk>
Date: Mon, 06 Mar 2000 22:15:05 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: IBM 850 - Open Firmware or not? and more on the ide byteswap game...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did the IBM 850 implement Open Firmware as described in the PReP spec?
I'm guessing not, which is a pity. Can anybody enlighten me for certain?

btw I've figured out why the 850 needs byteswapping of the IDE hard
drives to work properly - I just realized that NT/ppc ran little endian,
and the firmware understands little-endian FDISK style partition tables.
Since we understand them too, but we are running big-endian, we end up
in a mess. Why are we running big-endian btw?

This causes my first drive (which is byteswapped so I can boot from it)
to consume a lot more cpu when doing IO than the second drive (which is
in native endian format).

I guess that AIX had a hack whereby it created a little-endian FDISK
partition table with the bootloader in a PReP boot partition and then
played around without byteswapping with the rest of the disk. I'll have
to find one running AIX and have a look at the disk with linux and see
what I see.

Maybe we could adopt this trick - how easy would it by to write a new
chunk of partition table code which grokked the partition table in
byteswapped format? The we would just have to remember to byteswap the
kernel image before writing it to the boot partition and everything
would be neat. Actually I guess we could define our own partition table
format within the second partition (isn't this what solaris does on
intel? what did it do on PPC - has anybody actually seen a live
Solaris/PPC machine?).

I would also guess that really the 850 was for NT, and the closely
related 7248 43P machines were what you were supposed to use for AIX
(and I think they had onbard SCSI which gets around the whole problem).


Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39F5C071.C563540E@mvista.com>
Date: Tue, 24 Oct 2000 13:01:37 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Subject: Re: SBC8260, kernel 2.4.0-test8, initrd
References: <0G2X009AGV5CS2@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:

> I try to boot linux 2.4.0test8 on my sbc8260 with an initrd.

A couple of things look a little amiss here.....


> initrd at:     00480312 00481408

This isn't big enough to be a valid ram disk.  Something happened
when you created it, it doesn't have enough "stuff" in it.


> Sending BOOTP requests.... OK
> IP-Config: Got BOOTP answer from 10.1.20.2, my address is 10.1.20.1

...and it also looks like you have IP autoconfiguration selected.
It has precedence over the ram disk because it is then going to
look for an NFS root (see below).  You either need 'ip=off' in
the kernel arguments (for testing) or remove this part of the
configuration.

> Kernel panic: VFS: Unable to mount root fs on 01:00
> Rebooting in 180 seconds..

....and then it finally bails out because the ram disk isn't valid
and you don't have root NFS configured so it doesn't find an NFS server.



	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

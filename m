Date: Thu, 27 Jul 2000 10:59:29 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Stephan Leemburg <pmud-bugs@jvc.nl>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
In-Reply-To: <397FE132.1690D2DD@execpc.com>
Message-ID: <Pine.LNX.4.10.10007271058170.18614-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think I have a fix to prevent a system hang when trying to access a cdrom
> after sleeping.  I have a small util "wakebay" that simply does a
> CDROM_MEDIA_CHANGED ioctl on a specified device.  I added a the line "wakebay
> /dev/hdc" to PMUD's wakeup script on my PDQ.  This seems to get the desired
> response from the drive, in that it locks the door and spins the disk when it
> should, and if its not there, mounted, or otherwise, does nothing.
>
> my code can be grabbed from http://www.execpc.com/~jpgarcia
>
> Can this be done automatically at the kernel level?

Should be called from the IDE notify chain perhaps. See the last function
in ide-pmac().

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

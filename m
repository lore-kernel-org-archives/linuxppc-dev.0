Date: Thu, 3 Jul 2003 00:11:40 -0800
From: Ethan Benson <erbenson@alaska.net>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fsck_hfs on PPC???
Message-ID: <20030703081140.GG930@plato.local.lan>
References: <20030702225425.220d046a.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030702225425.220d046a.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 02, 2003 at 10:54:25PM -0400, Bill Fink wrote:
>
> Has anyone been able to get Apple's fsck_hfs with Roman Zippel's
> Linux patch to a usable state on PPC?
>
> I was able to build it with the following additional patch:

>
> But when I try and run it on an HFS+ partition:
>
> gwiz# fsck_hfs /dev/hda9
> /dev/rhda9: No such file or directory
> Can't stat /dev/rhda9
> /dev/hda9 is not a character device
> CONTINUE? [yn] n

heh, it seems to be rather bsd centric.  bsd has this silly concept of
having a r device for raw access, whereas the normal one is used for
filesystems.  ive never noticed that the r device is a char device though...

> So I create a raw device with:
>
> 	raw /dev/raw/raw3 /dev/hda9
>
> And then create a symbolic link:
>
> 	ln -s /dev/raw/raw3 rhda9
>
> But:
>
> gwiz# fsck_hfs /dev/rhda9
> ** /dev/rhda9
>
> does not appear to do anything.  Using the "-f" force option
> doesn't appear to have any effect either.
>
> gwiz# fsck_hfs -f /dev/rhda9
> ** /dev/rhda9
>
> It just immediately returns.
>
> I'm guessing fsck_hfs has only been tested on PC Linux.
> Has anyone gotten it to work on PPC or have any ideas
> about further things to try or investigate.

i don't think architecture has anything to do with the problems your
seeing, it looks to me like it will only work on *BSD.

but i haven't looked at its source, and won't.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

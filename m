Date: Sun, 21 Oct 2001 23:28:11 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Dave Ray <g4tinker@yahoo.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, almost
In-Reply-To: <20011021225419.11793.qmail@web13107.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110212322060.26280-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 21 Oct 2001, Dave Ray wrote:

> Has anyone explored sound on the G4 towers? I
> understand they use an 12c-based sound card similar to
> the iBook2.

Texas, aka Tumbler. AFAIK exact same chipset as the iBook2's are outfitted
with.

> I tried the iBook sound hack on the G4 tower to see
> what happens. It appears to be partly successful. The
> sound driver loads and registers the deq, but when I
> try to do anything that writes to the device I get
> silence and "can't locate module..." errors in the
> syslog. Below are the details. I'm guessing the hack
> is partly successful but the "tumbler" is failing.

Looking at the messages, it looks like everything is loading and initing
correctly. The messages below, however:

> Oct 19 20:54:38 garuda modprobe: modprobe: Can't
> locate module sound-slot-1
> Oct 19 20:54:38 garuda modprobe: modprobe: Can't
> locate module sound-service-1-0

seem to indicate something is trying to open /dev/mixer1 instead of
/dev/mixer0 (which /dev/mixer should either be a symlink pointing to, or a
dev node with the same major/minor numbers). What does your /dev/mixer
look like? It shuld be major 14, minor 0. Check
/usr/src/linux/Documentation/devices.txt for all the major/minor numbers
for devices (including sound devices).

In other words, the Texas chip is probably functioning fine - you have to
tell it to do something now, though...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

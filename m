Message-Id: <v0313030db3ece7c8caa1@[192.168.1.1]>
In-Reply-To: <19990827163237.012324@mailhost.mipsys.com>
References: <v03130308b3ec440550d3@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 27 Aug 1999 20:20:13 -0500
To: linuxppc-dev@lists.linuxppc.org,
        Linux/mac68k List <linux-mac68k@mac.linux-m68k.org>
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: mac-2.3.14.diff: adb
Cc: Benjamin Herrenschmidt <bh40@calva.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Fri, Aug 27, 1999, David D. Kilzer <ddkilzer@computer.org> wrote:
>>Well, drivers/macintosh is PPC ADB code.  If drivers/macintosh shouldn't
>>exist, then shouldn't it be changed or moved at a higher level?
>>
>>In reality, there is some ADB mouse code in drivers/char, too, so I wonder
>>if drivers/char/adb would make more/less sense than drivers/adb?

Benjamin Herrenschmidt <bh40@calva.net> wrote:
>I personally like drivers/macintosh, from my point of view, it makes
>things clearer. except for macserial, which should be killed in favor of
>a more generic zilog driver, most of those drivers are really mac-centric
>stuffs with no "generic" userland interface. Also, drivers/char is
>already enough of a mess like this.
>
>I didn't look at the those new patches, but the adb code in
>driver/macintosh was abstracted to use a generic "adb controller"
>sub-driver interface some time ago and so adb.c should be platform
>independant (useable as-is on PPC and 68k). mac_keyb.c too, with all it's
>specific mouse support.

Joshua Thompson did some rewriting of the adb.c code (and moved some header
files around) in order to fully integrate the m68k and PPC ADB code.

>David, did you make a generic (m68k/ppc) cuda driver too ?

Joshua Thompson made the patch, but I didn't include it in the patch I
submitted to Jes Sorensen (m68k maintainer) since I thought he only wanted
m68k stuff.  Joshua submitted the PPC side of the patch to Paul Mackerras.

Jes doesn't want to patch anything into drivers/macintosh.  He believes
that ADB code should be split into the bus code (drivers/adb) and into
device code (drivers/char/adb or drivers/char) and that drivers/macintosh
should go away.

I'm afraid that the m68k stuff is going to appear in drivers/[char/]adb
while the PPC stuff is going to remain in drivers/macintosh, and we'll be
worse off than we were before the merge!

Do we need to raise this issue on linux-kernel to get it resolved,
especially since the NeXT port (another m68k-based system) uses ADB as well?

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-Id: <200007121306.OAA00655@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 14:06:05 +0100
Subject: general module gottcha...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wed, Jul 12, 2000, Derek Homeier wrote:
> On Wed, 12 Jul 2000, Iain Sandoe wrote:
>>
>> > I did compile dmasound as module (I noticed that after applyiing your
patch,
>> > dmasound was unselected in .config - is there a reason for this?).
>>
>> Yes, the CONFIG_DMASOUND changed to a set of CONFIG_DMASOUND_XXXX for the
>> various different platforms.  Note there is no such thing as 'dmasound.o'
>> any more :-)
>>
>> you have to modprobe:
>> soundcore
>> dmasound_core <params>
>> dmasound_awacs
>>
> Ay, that may be the rub! I think I've still seen 'dmasound.o' when I did
> a lsmod. I did not change conf.modules, that's for sure.
> I have no idea, though, where I might have got the old dmasound.o from,
> because I made a 'mrproper' before the last compiles.

This is because (as things stand) modules_install does *not* remove un-built
modules - just overwrites rebuilt ones with the new versions...

This is probably the only sensible behaviour (gurus?)...

I am (usually) paranoid and do a:
 rm -rf /lib/modules/kernel-version-i'm-working-on

before doing modules_install :-)

> I can imagine that
> would have messed up everything a bit, though I'm wondering how the
> module got loaded with the wrong kernel version at all...

Hmmm.. it's probably a little too tolerant - I have module versioning
switched on in all my compiles and that is quite successful at whining when
you've forgotten to delete/update something.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

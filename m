Message-Id: <200101041317.NAA24882@hyperion.valhalla.net>
Date: Thu, 04 Jan 2001 13:17:11 +0000
Subject: Re: problems when recompiling dmasound modules
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "Michel Ddnzer" <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 4, 2001, Geert Uytterhoeven wrote:
> On Thu, 4 Jan 2001, Iain Sandoe wrote:
>> > Whenever I rebuild my linux-pmac-devel tree when the kernel version changed
I
>> > get bitten by this:
>> > The sound modules don't get rebuilt so their version doesn't match the
kernel
>> > version and they can't be insmoded.
[...]
>> and viola!
>> it seemed to work as before...
>>
>> (so maybe that wasn't what you were saying at all ;-)
>
> Real men
heeeey.... ;-)
>don't have the time to do `make mrproper' and `make menuconfig' every
> time the kernel changed,

true enough - although for those of us using rsync (even when doing your cp
-rl method for maintaining trees) it often takes less time than figuring out
which changes to options depend on which *when the version changes*.

(and, OK, I don't often hand-edit .config - but every now and then ;-)....

> so they rely on `make oldconfig' and `make dep'
> instead...

vi Makefile, change EXTRAVERSION to append -ids (my usual kinda practice)...

make oldconfig dep vmlinux modules

 - builds dmasound_core & dmasound_awacs

make_install creates a new /lib/modules/2.4.0-test13-pre3-ids and the
modules appear to be installed...

so... it seems to work for me.

> Sorry Michel, no clue...

IIRC there was, about 8 months ago, a problem with modversions.h
dependencies in the dmasound driver...  it doesn't seem to be there in the
set of code I just pulled.

so... am I still missing the problem?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

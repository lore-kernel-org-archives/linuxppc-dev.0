Message-Id: <200007091225.NAA19777@hyperion.valhalla.net>
Date: Sun, 09 Jul 2000 13:25:17 +0100
Subject: Re: X still locks up
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Gwyn Judd <b.judd@xtra.co.nz>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sun, Jul 9, 2000 Gwyn Judd wrote:
> On Sun, Jul 09, 2000 at 01:58:42AM +0100, Iain Sandoe wrote:
>>
>> > On Sat, Jul 08, 2000 at 11:06:40PM +0100, Iain Sandoe wrote:
>> >> Three things:
>> >>
>> >> 1/ did you try the backported audio stuff I posted yesterday - there were
>> >> some issues that were resolved between 2.2.xx and 2.3/4.xx these should be
>> >> present in the backport.  It does work OK against 2.2.17pre10-ben1.
>> >
>> > Oh whoops can you send that to me or tell me where I can get it? I
>> > thought it was part of bens kernel.
>>
>> Well, I wish it might be one day - but it's quite new (yesterday) and it
>> will take a bit more testing before it's accepted.
>>
>> here's the URL:
>>
>> http://quimby.gnus.org/circus/dmasound_backport.patch.bz2
>>
>> (but there's no reference to it anywhere higher up so use something like
>> anarchie/interarchy get via http - or whatever).
>
> Okay I tried that one by applying the patch to the current stable kernel
> (2.2.17 I believe).

It was against 2.2.17pre7 (linuxcare linux-pmac-stable tree) - but tested
against Ben's pre10-ben1 as well rsync'ed as of yesterday.

>Once gnome started up I got an error message "No
> mixers found".

Are you using modules - or complied in?  Modules currently require a
different insertion thingy:

modprobe soundcore
modprobe dmasound_core
modprode dmasound_awacs

I asked Geert about this - will get back to you/list when this is resolved.

check you have action with cat /proc/modules and cat /dev/sndstat before
doing anything too exotic.

suggestion ;-) boot 'single' do the modprobes and a simple check before
going to init 5.

Also please remind me what machine you are on and whether you have any OSS
stuff enabled as well.

>When I tried to play an mp3 through xmms X locked up
> completely although I was able to change VT's, however I was unable to
> kill X or reboot properly. Oh well at least fsck is getting a work-out
> this week :).

Does Magic SysRq work for you (alt-F13) on my G3
try:
 alt-f13-k  (kill processes in current vt)
 alt-f13-s  (emergency sync)
 alt-f13-e  (kill everything except init)

This *should* at least save some fsking time :-)

thanks for the report...
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

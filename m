Date: Sun, 22 Jul 2001 15:30:20 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: kernel ftp ?
Message-ID: <20010722153020.A13085@altus.drgw.net>
References: <20010716111241.M29668@work.bitmover.com> <Pine.LNX.4.10.10107162014480.20269-100000@zirkon.biophys.uni-duesseldorf.de> <20010716115734.P29668@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010716115734.P29668@work.bitmover.com>; from lm@bitmover.com on Mon, Jul 16, 2001 at 11:57:34AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think the point I'm trying to make is that _nobody_ can afford to
> provide infinite bandwidth for free.  I don't support the Mvista choice
> of doing so one little bit, I think it is self destructive.  Even if
> they are making money from Linux/PPC, why throw it away needlessly?

I don't think mvista is throwing away money needlessly.. if you notice, we
have rsync mirrors, but NOT ftp... rsync only sucks bandwidth if people
are grabbing the tree for the first time, just like bk clone does. In
fact, BK takes MORE bandwidth than rsync on a 'clone' operation because it
has to ship the complete revision history along.

> Last year there was so much money floating around the valley that noone
> worried about a few grand a month.  This year people are being laid off
> right and left, partially because of wasteful decisions.  I'm from the
> MidWest of the US, where people are well known for "waste not, want not".
> I don't see why bandwidth shouldn't fall under that as well.  And BK rocks
> as a mirroring service, it's amazingly good.  One of our developers is
> behind a modem.  BK works great (he hates life because surfing the net
> sucks, but the BK part is fine).
>
> I think 5 years from now you'll see people using BK, or things like it, for
> doing mirroring all over the world.  It works.

I think rsync has beaten you to the punch... it's already used to mirror
most of the major source repository out there, and it doesn't care if the
data is source code, tarballs, pictures, or whatnot. It also only
transfers data that has changed, like bk. I will admit that BK is finer
grained that rsync and transfers less uneeded stuff, but they are both
still on the same order of magnitude.

Out of curiosity, I tried doing a 'bk pull' of 266 changesets, and checked
how much bandwidth it took as well as how much bandwidth rsync took to
update the corresponding 'exported' source tree. (I used the stats from
'ifconfig' to figure out how much bandwidth.. this was on an otherwise
unused system)

RX bytes:135187230 (128.9 Mb)  TX bytes:5130187 (4.8 Mb)
cd linuxppc_2_4_devel; bk pull
RX bytes:138261336 (131.8 Mb)  TX bytes:5805084 (5.5 Mb)


RX bytes:140682043 (134.1 Mb)  TX bytes:8804424 (8.3 Mb)
rsync -avz --rsh=ssh --delete narn:/scratch/linuxppc_2_4_devel-rsync linuxppc_2_4_devel-rsync

wrote 1107822 bytes  read 4288794 bytes  38138.63 bytes/sec
total size is 113771809  speedup is 21.08
RX bytes:145793519 (139.0 Mb)  TX bytes:10484712 (9.9 Mb)


BK took about 3 MB, and rsync took abut 5 MB. So yes, BK is more
efficient, but the extra rsync traffic is not going to cause mvista any
great deal of trouble.


--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

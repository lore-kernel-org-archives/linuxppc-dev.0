Message-Id: <200101040956.JAA16492@hyperion.valhalla.net>
Date: Thu, 04 Jan 2001 09:56:34 +0000
Subject: Re: problems when recompiling dmasound modules
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel Ddnzer" <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Whenever I rebuild my linux-pmac-devel tree when the kernel version changed I
> get bitten by this:
> The sound modules don't get rebuilt so their version doesn't match the kernel
> version and they can't be insmoded.
> I can investigate to find a solution myself but I figured it should be easier
> for Geert or one of the other dmasound hackers to fix it.

I just did (after an absence of nearly six months ;-) :

rsync ppc.samba.og::linux-pmac-devel - which picked up 2.4.0-t13-p3
make mrproper
make menuconfig (selected, amongst other things, sound card support built
in, pmac sound as module)
make dep vmlinux modules modules_install
  - I saw it compile the damsound_core, dmasound_awacs
copied the kernel to my MacOS partition...
rebooted
modprobe dmasound_awacs

and viola!
it seemed to work as before...

(so maybe that wasn't what you were saying at all ;-)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

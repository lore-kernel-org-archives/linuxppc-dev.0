From: Benjamin Herrenschmidt <bh40@calva.net>
To: Christof Petig <christof.petig@wtal.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.17pre9-ben1 gmac problems on iBook
Date: Wed, 12 Jul 2000 12:58:57 +0200
Message-Id: <20000712105857.3860@mailhost.mipsys.com>
In-Reply-To: <396C4490.F4ACF357@wtal.de>
References: <396C4490.F4ACF357@wtal.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>- make yaboot's partition of type Apple_Bootstrap (anything else didn't work
>for me)

I usually use Apple_HFS so I can tweak it from MacOS, but that's probably
not what most users want to do ;) Usually, I have an HFS standard
partition used for data exchange between MacOS and Linux, I also use it
for the bootstrap stuffs.

>- 1MB is fine (800k is minimum (still true?))

That depends if you put your kernel on it or not. I do, but it's not
necessary. Again, most users will probably want the kernel to be on the
ext2 partition.

>- splitting the swap partition is a good choice if you have a running system
>- move it up/downwards to the second position (moving partitions is a nice
>feature)
>- if you want MacOS press option while booting

This can be a bit slow. Another solution is to use set OF to boot a
script that will itself boot either yaboot or MacOS depending if you
press a given key. Such a script is bundled with ybin, but it currently
requires some tweaking to get the OF boot path for both MacOS and yaboot
right in the script itself.

>- "video=ofonly" is a good last resort help

On iBooks. Note that recent kernels (like my just released 2.2.17pre10-
ben1) have a working video driver for iBooks.

Fortunately, SuSE people have been working hard on some Linux-based tools
to help configuring the bootloader and OF boot path properly. Those tools
are GPLd, so they'll be useable on other distributions as well. They are
still adding final touch to them, so I don't think you should jump on
them immediately, but that's a real good thing in the long term. (Thanks
Olaf ! ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

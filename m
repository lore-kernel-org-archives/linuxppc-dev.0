From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15369.65261.546405.15780@argo.ozlabs.ibm.com>
Date: Sun, 2 Dec 2001 21:14:05 +1100 (EST)
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
In-Reply-To: <3C08CFF0.18A1FBC7@wanadoo.fr>
References: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
	<3C08CFF0.18A1FBC7@wanadoo.fr>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel writes:

> For the valkyriefb driver on my Pmac 6400, I can confirm from a first
> short test that it still works. This is with your patch applied to
> today's 2.4.17-pre1-ben0 kernel.

Do you still have macos on the 6400?  If so can you confirm whether,
if you set the screen resolution and colour depth in macos, that the
value you have set in macos is the default that linux will use?

The nvram locations that the video drivers look in for the default
resolution and depth, 0x140f and 0x1410, were locations that I found
empirically on a 7500 with a control display, and IIRC they also
seemed to work with the platinum and probably the valkyrie as well.
But from about when Apple started to use the ATI chips it seems that
macos changed the way it stored the way it stores the defaults, and
certainly now it is driver-dependent.

Therefore unless someone can reverse-engineer how the macos ATI driver
stores its defaults, I don't think there is any point having the nvram
stuff in the atyfb driver, and it probably isn't doing any good in the
matrox or imstt drivers either.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel drivers and ioctls and mutexes?
Date: Thu, 29 Nov 2001 11:58:07 +0100
Message-Id: <20011129105807.1293@mailhost.mipsys.com>
In-Reply-To: <20011129024133.EGCO16262.tomts14-srv.bellnexxia.net@there>
References: <20011129024133.EGCO16262.tomts14-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Can anyone tell me if your need mutexes to prevent problems when ioctls
>initiated from userland that change dev structure values are used in
>kernel drivers?
>
>For example in NIC modules a broken link can cause nway_start on some
>cards but a userland ioctl can (asynchronously) cause the same things to
>happen?  Should I be using mutexes inside the driver to prevent this or is
>there some synchronization mechanism I am missing here?  Given how nway
>negotiations are started and given them may take a few seconds to
>complete, something should shield the nway start routine from being
>re-entered.

It depends on your driver, mutexes may or may not be the right solution.

I've implemented ethtool ioctl support in sungem and have done my own
synchronisation mecanism, basically the ioctl to restart autoneg will
interrupt any pending autoneg and restart one, there should be no
re-entrancy, except if I missed a case ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

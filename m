From: benh@kernel.crashing.org
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
Date: Wed, 13 Feb 2002 18:28:47 +0100
Message-Id: <20020213172847.23608@mailhost.mipsys.com>
In-Reply-To: <87k7th2ujl.fsf@theorie.physik.uni-muenchen.de>
References: <87k7th2ujl.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Debian systems, this is done by a small daemon named ifd in the
>laptop-net package.
>
>Unfortunately, it uses the SIOCGMIIPHY and SIOCGMIIREG ioctls for link
>detection, which on my Pismo reproducibly lead to machine check
>oopses.  I've managed to track down the problem, a patch is included
>below.  Basically, instead of really reading the registers it fakes
>and returns a register setting from the cached status of the device.
>Right now, it is fairly ugly, since it only works for that relevant
>one bit.

Can you tell me more about those machine checks ? I suspect they happen
if you try to read the registers while the interface is shutdown, in
which case the GEM chip is down.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39D7967A5D
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 16:43:26 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148169389.13249.44.camel@localhost.localdomain>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
	<1148169389.13249.44.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RpFnLMwU1QEuxSDcoe4j"
Date: Mon, 22 May 2006 08:42:52 +0200
Message-Id: <1148280172.6228.79.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RpFnLMwU1QEuxSDcoe4j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-05-21 at 09:56 +1000, Benjamin Herrenschmidt wrote:

> What do you mean by lost interrupts ?

Well, when our interrupt handler isn't run for each expected interrupt.

> DBDMA sends edge interrupts. Thus, if it emits interrupts A, then B and
> C, and for any reason, your kenrel is not able to service interrupts (is
> doing something with IRQs disabled) from before B happens to after C
> happens, you'll indeed get called only twice (A and C) and "B" will be
> sort-of lost.

Right. But I have a hard time believing that we had such a high latency,
I expect an interrupt about every 10ms under normal alsa programming.

> First thing about that is: what the heck is causing us to have such a
> latency !!! that would be useful to figure out. A way to do that would
> be maybe to "detect" when C happens that we missed B (see below how to
> do that) and print something along with the regs->nip & lr (or even a
> backtrace). That might give us an idea of there interrupts are
> re-enabled after the long latency which could perhaps lead us to the
> cause of the latency.

Yeah ok, we might be able to figure out what's causing this, but on an
otherwise idle system I assumed actual hardware problems, but it also
never happened on my machine, only on my brother's (same as your pbook).

> Now for detecting lost interrupts (and for being immune to them), the
> technique is not to just assume IRQ -> 1 period completed, but instead,
> when an irq happens, to go read the DBDMA descriptors in memory to see
> which ones have actually been completed. Their status field should be
> updated as their get comleted. Thus, you keep track of the "previous"
> last completed descriptor and you walk from that to recycle them.

Right, that's how snd-powermac does it. It has the nasty side-effect of
polluting the cache a lot though, since dbdma commands are 16 bytes
long. Am I wrong?

> Since we can only update the framecounter on a per-period basis,=20

Alsa calls this thing the 'pointer' :) The frame counter we currently
use is the frame counter register of the i2s bus controller, and I don't
see why we shouldn't do that instead of reading back all the dbdma
command status fields.

> the
> driver would benefit from having lots of very small periods. I don't
> know if we can provide "hints" to userland about that though.=20

Yes, we can set the minimum period count or maximum period length. Not a
hint though, it then makes it required.

> Using the
> i2s frame counter means we need some kind of calibration... it might
> still be counting if for the reason the DBDMA "misses" something or gets
> stopped....

Since the i2s bus is not shut down it also counts when we are not
transferring data. We currently calibrate on the first interrupt. That's
fine, since having multiple periods means that we don't need to be
absolutely precise here. If we miss one, that's fine, we can make it up
the next time by saying that 2 have elapsed.

johannes

--=-RpFnLMwU1QEuxSDcoe4j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHFdaqVg1VMiehFYAQKARQ/9FU2kNV2x7RCFjzOyfHEFVJqmVF2EKPeH
F+UOHAJ0kcOA5OkuB3jamjOiNuHTsM0vxEzTrsj3U/3UGLu8xmffIu4C1oo/sYgE
4w94ikFwYCLTg87T6DyHXLajH8iSNT/GmFaIw3vW2bdOZuwCPBLC2M63b3UucBes
ZGYxiahIXK42R2cjln0a5+hS6WSrJhWEz5g+Esui/0ZJitcYjREiJnhWdhW1QYNC
yZaBWVPm+tHjewX+FXsRMfl59SlWdoI1fFFbwMRcvhDzsDIh81R1FUKbxCcqxjl/
hQ6Li8tECaGX4IQ/I7gYe7XmlHTITssdPx4JB9WzcDlmL9a5ujlFtbz1E/BZNJqM
nNFgrq62qAx+MmQaab9nJLH5ZSAFy9aZIwkOEy7EfD/UFkecXtgpaRZPQUkwfE4D
6jG48nwcYFaOPd4/sFyWDx0itrF2JsMKxxhZe4XZk3Xg2ltX910uQdnXE8s8ejTU
yPTjFEt045NK245ve/C6Axz4aGMScAJVV7ozJQ6SiVO2EbPUmh8ToIyI0JUcwJXE
6tdg9VEpNFq8W0S/y/zCn6tILZMFGApmAVju6KCQZu+vI7JCGAkP7heZP/VAvQNG
T/4EYMSXq7uctchcyp7kderfqKguao74AimISySth+7xd+fUYOaFfyQFfYZSk0Le
OX1lLhRHsO0=
=ZQxV
-----END PGP SIGNATURE-----

--=-RpFnLMwU1QEuxSDcoe4j--

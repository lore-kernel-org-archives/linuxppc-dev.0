Date: Mon, 29 Jan 2001 12:05:10 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: correct use of lock_kernel() - help!  please
In-Reply-To: <20010129102946.9388A2EFC9@apollo.valhalla.net>
Message-ID: <Pine.GSO.4.10.10101291155220.23722-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 29 Jan 2001, Iain Sandoe wrote:

> AFACIT we could hold the kernel locked for *several seconds*

If you sleep inbetween, it's no problem. The kernel lock is released
automatically during sleep and reget after sleeping.

> What do I really need to protect with lock/unlock pairs?

SMP protection. Only a single processor can hold the kernel lock at the
same time. The preferred solution is of course to use semaphores /
spinlocks.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

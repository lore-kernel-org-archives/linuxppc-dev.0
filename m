Message-ID: <3D18E933.7020402@embeddededge.com>
Date: Tue, 25 Jun 2002 18:05:39 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Frank Rowand <frowand@mvista.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> Actually, some ports have no virtual mapping prior to
> early_serial_init()

Ummmm....something doesn't seem right then.  The kernel has
to be mapped in order for it to be running at this time,  and
the I/O can actually move around.

I did lots of this work to get kgdb, and more importantly xmon,
to initialize this early.  On the 8xx, the serial port is actually
moved at least three times as the VM and the driver initializations
are done.

Early in kgdb/xmon, they rely on the same mapping that is used by
the boot loader that brought the kernel to being.  If I can make this
work on 8xx, it should work on anything :-)  The 8xx can only do DMA
I/O, so it's particularly challenging to chase memory around that
can be used for these buffers.


> That doesn't seem to be the general purpose case, though.  When
> you have kgdb functionality in the kernel for functional board
> ports, later debug seems to be the general use of it.

You always want to start up kgdb as soon as possible.  It gives you
the opportunity to debug driver initialization.

> It would seem that moving the default location has more general
> usefulness for existing board ports.

Huh?  All of the existing board ports use it as it is today.  How
can you say removing a useful feature would be useful to existing
systems? :-)

> ....  IMHO, it is most important
> to have features like kgdb functioning in a general purpose way
> in the tree.

I don't know what that statement means.  All of the other architectures
use an early kgdb initialization, which is where we got the idea to
do the same a while back.  The kgdb/xmon used to initialize later, and
didn't make it very useful until a substantial amount of system initialization
was done.

> Is being expected to move kgdb_map_scc() to an earlier custom
> location too much?

Why don't you just use the normal serial port setup to enter kgdb
on those ports that have trouble, and do nothing in this early function?

>  ...  It only needs to be earlier until things
> are functional past setup_arch.

What board ports have trouble with the early initialization?  Any mostly
standard programmed I/O uart should work.  It's only the high performance
DMA only ports like 8xx and 8260 that seem to be the challenge.


Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

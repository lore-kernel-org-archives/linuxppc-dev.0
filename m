Date: Fri, 22 Dec 2000 21:54:19 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Huber <huber@mclx.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethernet issue with lombard
In-Reply-To: <20001219220143.C6309@missioncriticallinux.com>
Message-ID: <Pine.LNX.4.10.10012222028040.27072-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It seems to be easier to kill the network on a 10Mbit connection,
> rather than a 100Mbit connection.
>
> I can kill the network easily with ping -f <ip of local host>
>
> There aren't any helpful messages in any logs (actually, nothing
> relating to ethernet).  No errors are shown in ifconfig eth0.

One thing I could notice is quite high packet drop rates that start at
packet sizes above about 560 (580 gives a slow increase of the dots, 768
has them running rather fast). It took extended periods of flooding at
560 bytes to bring the interface down (on the order of 600k packets) and
up to that point it logged a large number of TX overruns but no RX errors.
The hangup has the packet counts frozen but shows just a few RX errors
which slowly accumulated. The connection appears to freeze even before the
dots start running wild.

There's one clear pattern I can see: After each freeze and subsequent
restart of the network adapter, both the dropped packet and frame error
count increased by one. Does the BMAC require special treatment after a
frame error?

That's with 2.2.18pre18 on a switched 100 Mibt network (3com 3300) with no
load worth mentioning.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

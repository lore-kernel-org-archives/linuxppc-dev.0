Date: Wed, 20 Sep 2000 10:34:23 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <14791.61311.118516.747495@argo.linuxcare.com.au>
Message-ID: <Pine.GSO.4.10.10009201023340.21745-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> For
> example, inb(0x3f8) won't access the first serial port (this is on
> machines such as prep and some chrp which have a lot of PC-style
> devices).

You know that the serial driver supports pci cards? So it's somehow a bad
example and even for broken drivers it shouldn't be that much of a problem
to add:

#if __broken__
#define xxx_inb(base, port) inb(port)
#else
#define xxx_inb(base, port) readb(base + port)
#endif

All the 8390 based drivers do something like this. (Although currently
they abuse inb/outb for that.)

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

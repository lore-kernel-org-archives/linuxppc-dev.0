From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14793.16409.167430.562490@argo.linuxcare.com.au>
Date: Thu, 21 Sep 2000 09:54:17 +1100 (EST)
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <Pine.GSO.4.10.10009201023340.21745-100000@zeus.fh-brandenburg.de>
References: <14791.61311.118516.747495@argo.linuxcare.com.au>
	<Pine.GSO.4.10.10009201023340.21745-100000@zeus.fh-brandenburg.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel writes:

> > example, inb(0x3f8) won't access the first serial port (this is on
> > machines such as prep and some chrp which have a lot of PC-style
> > devices).
>
> You know that the serial driver supports pci cards? So it's somehow a bad
> example and even for broken drivers it shouldn't be that much of a problem
> to add:

You know that prep and chrp machines usually have a super-I/O chip
that has serial ports at I/O 0x3f8 and 0x2f8?  How does support for
pci cards in the serial driver help you there?

> #if __broken__
> #define xxx_inb(base, port) inb(port)
> #else
> #define xxx_inb(base, port) readb(base + port)
> #endif

I can just see Ted T'so adding that extra cruft to the serial driver,
and then Linus accepting the patch.  Not.

> All the 8390 based drivers do something like this. (Although currently
> they abuse inb/outb for that.)

Inb/outb are the *correct* things to use for accessing PCI I/O space.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: "Elan Feingold" <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Driver question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 26 Aug 2001 14:53:47 CDT."
             <NDBBLJKOJGKDOFBHNPGEGEIKCEAA.elan@nxnetworks.com>
Date: Sun, 26 Aug 2001 22:46:00 +0200
Message-Id: <20010826204606.0BC8A10CBE@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NDBBLJKOJGKDOFBHNPGEGEIKCEAA.elan@nxnetworks.com> you wrote:
>
> Thanks to all those who helped me get my custom 860 board up and running!
> My next question is about mapping some physical memory to user space.  I
> have some devices with memory mapped registers.  One of them lives at
> 0x84000800 (above 2Gb!).  I have been trying to mmap() this into user space

That's a physical address, right?

> memory, without success (the kernel doesn't like the >2Gb).

Ummm... you must have been doing something wrong.

> >From what I understand, there are usually a few options.  Usually one can
> use mmap() -- although I don't know if I can -- or one can write a device
> driver to work with kmalloc and friends.

You can use mmap(), but of course  you  need  a  device  driver  that
provides such a mmap() interface.

> What would be the easiest way to gain access to that physical memory
> (non-cached, of course) from user space?  Obviously, it would be nice to map
> it in at that very address in user space, but I don't think that's going to
> happen.  Any tips would be greatly appreciated, as I'm new to this game.

No. You should really use mmap(), but you will end  up  with  virtual
addresses  (a  virtual  kernel  address  in your device driver, and a
virtual user address in  your  application)  which  differ  from  the
physical address.

See drivers/char/ip860_mem.c for examples of how to  export  physical
address  ranges  (in  the  example  it's VMEBus memory) to user level
applications. You can find the file in the kernel sources on our  FTP
server, see
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Certainly there are things in life that money  can't  buy,  but  it's
very funny - Did you ever try buying them without money? - Ogden Nash

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

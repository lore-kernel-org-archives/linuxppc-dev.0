Message-ID: <000b01c38e8a$0f4ef650$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam> <20031008223518.A10052@home.com> <008c01c38e2d$27feac20$2803050a@JackyLam> <20031009063812.A11979@home.com> <001901c38e7b$0f6ed830$0202a8c0@homevl9biy3v7e> <20031009093720.A13184@home.com>
Subject: Re: General porting question
Date: Fri, 10 Oct 2003 01:23:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > You can not use virt_to_* on the address returned by
> > > pci_alloc_consistent().
> >
> >     Why?
>
> Because virt_to_*() is only defined for staticly mapped kernel virtual
> addresses...consistent_alloc() is not guaranteed to return a staticly
> mapped kernel virtual address so you can't use virt_to_*().  It is not
> a generic address translation API.
>
> >     By the way, this problem will only affect the consistency of dma
buffer.
> > In my case, it will only cause wrong output sound. But my card seems
don't
> > consume the dma and doesn't give any interrupt in return. It's fine on
PC
> > and I can receive interrupt if I write to the card's register to force
an
> > interrupt. What other possible porting problem can be here? Really
> > strange....
>
> Endianness issues as another person pointed out.  You still have to
> solve these address munging issues.

    Thanks. I will spend more time to understand those mapping stuff.....I
still cannot understand very clearly...

    Concerning endianness, I think the read/write to register of PCI card is
ok because it is done by inl()/outl() which already handled the endian
conversion. The remaining is the data written to dma buffer. I don't care it
now because the card seems don't start to consume the data.

    I look through the code many times. I can't find out any porting related
issues beside endianness and memory mapping that will make x86 and PPC
different. Any idea?

Best regards,
Jacky

P.S.: By the way, in embedded system, I know how much PCI memory are used.
Why don't we just give up some on board memory, say 1MB, and map "simply"
the memory with uncachable flag. Then this region of memory can be use by
PCI cards without need to take care all those mapping stuffs.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

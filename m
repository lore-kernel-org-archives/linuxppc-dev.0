Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 25 Jul 2003 14:59:23 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Wolfgang Denk <wd@denx.de>, Kent Borg <kentborg@borg.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IO, ANSI vs GCC structs 
In-Reply-To: <5.1.0.14.2.20030725123123.03855f58@mail.ebshome.net>
Message-ID: <Pine.LNX.4.44.0307251454321.22864-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 25 Jul 2003, Eugene Surovegin wrote:
> At 12:22 PM 7/25/2003, Wolfgang Denk wrote:
> > > accessed through a structure?  Is it acceptable to do:
> > >
> > >   #define MYHW  (MY_MBAR+42)
> > >
> > >   ...
> > >
> > >   out_be32(MYHW, 0xco1df00d);
> >
> >...I would not accept such code.
> >
> >There is one fundamental difference: a field in a struct has a  type,
> >i.  e.  the  compiler "knows" how big it is (8, 16, 32, ... bits), if
> >special attributes apply (volatile), etc.
>
> Although functions like out_be32 also *know* the size :).
>
> IMHO, it's not a good idea to access IO remmaped registers simply through C
> struct, it's better and safe to use out_* and in_*.

Wouldn't best practices also include using a base address rather than
a constant, so that when a new board places the hardware in a different
location all you have to do is find it?

out_be32(my_bar + offsetof(myregs_t, sna_reg), 0xdeadbeef);

> There are issues that C struct cannot deal with - load/store reodering (of
> course you can insert wmb() and friends if you know what you are doing :).
>
> I think the best practice is to use C struct (for readability) and
> out_*/in_* on structure members for actual access.

I've always written low level I/O routines for everything in a driver
because it is easier to adapt when someone changes how they want to do
access to the device. The code all calls the low level IO routines.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

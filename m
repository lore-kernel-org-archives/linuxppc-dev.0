To: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Wolfgang's updates 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 Mar 2001 09:49:21 GMT."
             <EADB10BAC266A14A85ECBF8686A73E3108AFC4@kolkrabbi.flaga.is>
Date: Tue, 13 Mar 2001 15:30:30 +0100
Message-Id: <20010313143035.B02D7281DB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <EADB10BAC266A14A85ECBF8686A73E3108AFC4@kolkrabbi.flaga.is> you wrote:
>
> > * AMD   flash chip support
> > * INTEL flash chip support
...
> >   PCMCIA port, and for real PCCARD interfaces like CompactFlash or
> >   harddisk adapter cards, but without need for the full PCMCIA
> >   package; also usable for boot devices).
...
> Isn't this exactly what mtd is dooing, i.e. generating a general
> interface to flash devices.

It's not a general  interface,  just  an  ordinary  character  device
driver.

Yes, you probably can  replace  it  by  MTD,  and  this  is  what  we
eventually plan for the future. But our flash driver pre-dates MTD by
som  time,  and  has  been  around  since  2.2.5 or so. It is used by
several of our customers, and we will have to maintain  it  for  some
time anyway.

And I  don't  really  see  a  problem  with  having  two  independend
solutions for similar problems.

For instance, so far MTD does not even  compile  for  CFI  conformant
flash chips; last time I tried I got this:

cfi_cmdset_0002.c:304: #error not support big endian yet



The other patch to enable IDE devices like harddisks or  CompactFlash
as  boot  devices  using  the  PCMCIA port of the MPC8xx is - AFAIK -
something that is not even addressed by MTD. Nor was there any  other
working solution for it.

> Isn't this a duplication of work, and deemed to be rejected from the
> official kernel because the mtd is allready in the official kernel?

Even with MTD - why generally reject  an  alternative  solution?  For
instance, we have several types of filesystems, too.

The "one size fits all" method does not apply  to  embedded  devices,
and that's what I have in mind.

If you don't like it, you don't have to use it. It does not hurt you.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

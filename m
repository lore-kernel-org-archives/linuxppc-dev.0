Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <5.0.2.1.2.20010306110653.02979ea8@mail.munich.netsurf.de>
Date: Tue, 06 Mar 2001 11:22:43 +0100
To: Wolfgang Denk <wd@denx.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: "unhandled relocation type 18" ??? 
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010306080226.6846A287E8@denx.denx.de>
References: <Your message of "Tue, 06 Mar 2001 08:25:41 +0100." <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 09:02 06.03.2001, Wolfgang Denk wrote:

>In message <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg>
>you wrote:
> > On Mon, 5 Mar 2001, Wolfgang Denk wrote:
> > > when trying to "insmod" a  kernel  module  that  uses  floating-point
> > > functions  like  "sin", we get error messages:
> > >
> > >     unhandled relocation type 18
> >
> > Does it also complain about a missing symbol for `sin'?
>
>No, it does not.
>
>We made sure to link the module with  the  math  library  to  resolve
>those references.
>
>But we still get those  error  messages;  the  first  is  always  for
>lshrdi3  -  which is linked with our module (but also provided by the
>kernel - could there be any problems?), and then we get a  long  list
>of errors for pack and unpack functions - whatever they are.

18 is a PLTREL24 relocation, so a b/bl has to be involved, but it should be
a REL24 relocation, the PLT usage points to compilation of a module with
-fpic/-fPIC?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

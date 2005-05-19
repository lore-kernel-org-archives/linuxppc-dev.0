Return-Path: <wd@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 May 2005 08:20:29 +1000."
	<1116541230.5153.8.camel@gaston>
Date: Fri, 20 May 2005 01:14:41 +0200
Sender: wd@denx.de
Message-Id: <20050519231446.29487C1512@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without Open
	Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Ben,

in message <1116541230.5153.8.camel@gaston> you wrote:
>
> > I have some concerns about the memory foot print and  increased  boot
> > time  that  will  result  from  the proposed solution. 
> 
> Like everybody it seems, which is funny in a way as I expect pretty much
> none (or a few Kb maybe). The kernel side code for managing a
> device-tree may represent more, but heh, have you seen the size of a

I am not so narrow-minded to think only about U-Boot. I try to  think
about  the  whole system, including boot loader, kernel, and any data
that might need to get passed between these two.

And please believe me, there are many, many systems out  there  where
"a few Kb" really matter.

> ppc64 kernel anyways ? I don't think that is very relevant. On the

I am aware that you think so, and I try to raise  your  awareness  of
the fact that there is a huge number of small machines out there.

Please keep in mind that the same interface will be forced sooner  or
later  on small 8xx systems with maybe just 4 MB flash and 8 or 16 MB
RAM.

And when you sell 100,000 of these units per year then "a few Kb" may
cost a lot of money. Or may cause that other, prorietary OS get used.

> bootloader side, I don't expect any significant impact. The device-tree
> can be very small, and the code required on the bootloader side ranges
> from nothing for a pre-built one, to a little bit if the bootloader has
> to be able to change/add properties/nodes.

It is IMHO wrong to have only the boot loader side in mind. We should
consider the whole system.

> > There are many embedded systems where resources are tight and requirements
> > are  aven tighter.  
> 
> Amen. (Though heh, this is ppc64, you can't be _that_ tight :)

I think you are aware that there are several people out there working
on a similar boot interface for the "small" PPC systems, too.


> >It  would  be probably a good idea to also ask for feedback
> > from these folks - for example by posting your RFC on the celinux-dev
> > mailing list.
> 
> I will do when I have a little bit more mature proposal.

Thanks in advance.


> > But my biggest concern is that we  should  try  to  come  up  with  a
> > solution  that  has  a  wider  acceptance.
> 
> No other solution will be accepted on the kernel side. At least for
> ppc64

This is not exactly a constructive position. When  each  architecture
comes  up with it's own solution for the same problem and then claims
that no other solution will be accepted we will stick  with  what  we
have now: a mess.

If this is really your position we may as well stop here.

> > As is, your proposal will add just another incompatible way of  doing
> > the  same  thing  (of course we will have to stay backward compatible
> > with U-Boot to allow booting older kernels, too).
> 
> My proposal is the only supported way to boot a ppc64 kernel. There are

Yes, of course. And using ATAGS is the only supported way to boot  an
ARM kernel, and so on.

If everybody claims that his way of doing things is the only accepted
solution we can really save all the time we are  wasting  on  such  a
discussion.


> talks about backporting support for that to ppc32 as well. Other
> architectures are welcome to use it too though :) The device-tree in the

Ummm.. Ben, I have really high respect for you, but such  a  position
is  simply  arrogant.  With the same right the ARM folks can say that
ATAGS is the way to go and other architectures are welcome to use it.
Actually they might have older rights.

> > Why don't we try to come up with a solution that is acceptable to the
> > other architectures as well? 
> 
> This has been discussed over and over again, that is the best way to
> never come up with a solution as everybody will want something different
> and nobody will ever agree.

With such a position I really wonder why you ever asked?

> The present proposal is implemented today on the ppc64 kernel already,
> and we have decided to not go backward on this requirement. 

The why the heck do you call this a RFC or a proposal? To me it seems
that you don't propose but dictate a  solution  -  a  solution  which
pretty   much  ignores  everything  but  your  own  requirements.  If
everything has been decided already I can as well shut up.

But please never claim that this has been _discusssed_.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have made mistakes, but have never made the mistake of  claiming  I
never made one.                                     - James G. Bennet

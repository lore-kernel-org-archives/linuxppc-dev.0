Message-ID: <007a01c2e1e2$493c43e0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLOEKGFKAA.joakim.tjernlund@lumentis.se> <3E63C905.5000306@embeddededge.com>
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Date: Tue, 4 Mar 2003 01:09:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I have been playing with the copy_page() function in arch/ppc/kernel/misc.S
> > and gained about 30% speed up for my mpc860, rev D4 MHz.
>
> Have you found the discussion in linuxppc-dev about the work Paul has done
> on this in general for PowerPC?  It may help avoid repeating some work and
> provide some guidance.....

I have searched but I did not find anything conclusive. Pointers?

> And don't forget....many applications aren't heavily 'copy-centric' and it
> may be beneficial to not blow away the caches in those cases.  That is, if

If you are referring to the copy_page() that I attached in my first mail, then
yes it uses more icache, but if you have seen my later post where I took it
back and stated that just enabling dcbz in the existing version of copy_page()
would give the same speed up, I don't follow you. How am I wasting caches?

In the end I would like to modify copy_tofrom_user() so that dcbz is used on kernel space
addresses but not on user space without adding a lot of code. Ideas welcome.

> you apply systems engineering methods to your testing instead of just focusing
> on such a low level detail, you may discover you are wasting your time and
> from an overall system application you may be providing little benefit or
> even a overall degradation in system performance.

I am just trying make 8xx perform a little better and I focus on areas I know something
about such as crc32, the enet.c driver and in this case various memory copy stuff. Hopefully
the end result will be useful to me and others.

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3805582E.2D32F329@primenet.com>
Date: Thu, 14 Oct 1999 04:12:30 +0000
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: Michael Meissner <meissner@cygnus.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC function returning long long
References: <38041087.62AB190@primenet.com> <Pine.HPX.4.10.9910130940210.7415-100000@gra-ux1.iram.es> <19991013082759.A7133@elmo.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Meissner wrote:
> 
> On Wed, Oct 13, 1999 at 10:06:02AM +0200, Gabriel Paubert wrote:
> >
> > On Wed, 13 Oct 1999, Bob Doyle wrote:
> >

[snip]

> The above doesn't work with -mreg-names and/or -pedantic.  Instead you should
> write:
> 
> unsigned long long get_timebase(void) {
>         unsigned long long retval;
>         unsigned long junk;
>         __asm__ __volatile__ ("\n\
> 1:      mftbu   %1\n\
>         mftb    %L0\n\
>         mftbu   %0\n\
>         cmpw    %0,%1\n\
>         bne     1b"
>         : "=r" (retval), "=r" (junk));
>         return retval;
> }

Thanks, thats just what I was looking for... 

I've found several tutorials on x86 GNU inline asm but none on the
PowerPC.
If I were to write a HOWTO would anyone volunteer to proof read
and/or contribute code examples?  I suspect I'm not the only one 
struggling through this.

Bob Doyle
doyle@primenet.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

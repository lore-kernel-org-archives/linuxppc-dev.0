Message-ID: <19991013082759.A7133@elmo.cygnus.com>
Date: Wed, 13 Oct 1999 08:27:59 -0400
From: Michael Meissner <meissner@cygnus.com>
To: Gabriel Paubert <paubert@iram.es>, Bob Doyle <doyle@primenet.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC function returning long long
References: <38041087.62AB190@primenet.com> <Pine.HPX.4.10.9910130940210.7415-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.9910130940210.7415-100000@gra-ux1.iram.es>; from Gabriel Paubert on Wed, Oct 13, 1999 at 10:06:02AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 13, 1999 at 10:06:02AM +0200, Gabriel Paubert wrote:
> 
> 
> 
> On Wed, 13 Oct 1999, Bob Doyle wrote:
> 
> > 
> > I was playing with the inline assembler and the ppc
> > timebase facility and created the following function -
> > 
> > unsigned long long get_timebase(void) {
> >         unsigned long tbu;
> >         unsigned long tbl;
> >         unsigned long junk;
> >         __asm__ __volatile__ ("
> > 1:      mftbu   %2
> >         mftb    %1
> >         mftbu   %0
> >         cmpw    %0,%2
> >         bne     1b"
> >         : "=r" (tbu), "=r" (tbl), "=r" (junk));
> >         return ((unsigned long long)tbu << 32) | tbl;
> > }
> 
> Rather write: 
> unsigned long long get_timebase(void) {
>         unsigned long long retval;
>         unsigned long junk;
>         __asm__ __volatile__ ("
> 1:      mftbu   %1
>         mftb    %0+1
>         mftbu   %0
>         cmpw    %0,%1
>         bne     1b"
>         : "=r" (retval), "=r" (junk));
>         return retval;
> }

The above doesn't work with -mreg-names and/or -pedantic.  Instead you should
write:

unsigned long long get_timebase(void) {
        unsigned long long retval;
        unsigned long junk;
        __asm__ __volatile__ ("\n\
1:      mftbu   %1\n\
        mftb    %L0\n\
        mftbu   %0\n\
        cmpw    %0,%1\n\
        bne     1b"
        : "=r" (retval), "=r" (junk));
        return retval;
}

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

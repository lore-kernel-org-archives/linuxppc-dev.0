Message-ID: <19991014003539.B7713@elmo.cygnus.com>
Date: Thu, 14 Oct 1999 00:35:39 -0400
From: Michael Meissner <meissner@cygnus.com>
To: Bob Doyle <doyle@primenet.com>, Michael Meissner <meissner@cygnus.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC function returning long long
References: <38041087.62AB190@primenet.com> <Pine.HPX.4.10.9910130940210.7415-100000@gra-ux1.iram.es> <19991013082759.A7133@elmo.cygnus.com> <3805582E.2D32F329@primenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3805582E.2D32F329@primenet.com>; from Bob Doyle on Thu, Oct 14, 1999 at 04:12:30AM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999 at 04:12:30AM +0000, Bob Doyle wrote:
> 
> Michael Meissner wrote:
> > 
> > On Wed, Oct 13, 1999 at 10:06:02AM +0200, Gabriel Paubert wrote:
> > >
> > > On Wed, 13 Oct 1999, Bob Doyle wrote:
> > >
> 
> [snip]
> 
> > The above doesn't work with -mreg-names and/or -pedantic.  Instead you should
> > write:
> > 
> > unsigned long long get_timebase(void) {
> >         unsigned long long retval;
> >         unsigned long junk;
> >         __asm__ __volatile__ ("\n\
> > 1:      mftbu   %1\n\
> >         mftb    %L0\n\
> >         mftbu   %0\n\
> >         cmpw    %0,%1\n\
> >         bne     1b"
> >         : "=r" (retval), "=r" (junk));
> >         return retval;
> > }
> 
> Thanks, thats just what I was looking for... 
> 
> I've found several tutorials on x86 GNU inline asm but none on the
> PowerPC.
> If I were to write a HOWTO would anyone volunteer to proof read
> and/or contribute code examples?  I suspect I'm not the only one 
> struggling through this.

I don't know whether he reads this list, but the two PowerPC GCC maintainers
are David Edelsohn <edelsohn@gnu.org> and myself <meissner@cygnus.com>.  We can
probably offer suggestions, though I suspect we probably don't have as much
time to actually write anything.

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3AFAE055.3396344C@mvista.com>
Date: Thu, 10 May 2001 11:39:17 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Brian Kuschak <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105092010530.29518-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Wed, 9 May 2001, Brian Kuschak wrote:


> >
> > static __inline__ void atomic_set(atomic_t *v, int a)
> > {
> > c004f9e8:       38 00 00 01     li      r0,1
> >         int t;
> >
> >         __asm__ __volatile__("\n\
> > c004f9ec:       7d 60 f8 28     lwarx   r11,r0,r31
> > c004f9f0:       60 0b 00 00     ori     r11,r0,0
> > c004f9f4:       7d 60 f9 2d     stwcx.  r11,r0,r31
> > c004f9f8:       40 a2 ff f4     bne-    c004f9ec <d_alloc+0x90>
> >
> >         atomic_set(&dentry->d_count, 1);
>
> Is there any reason for atomic_set to use this sequence. I believe that a
> simple store (stw in this case) would be ok. This looks like a very
> convoluted and bloated way to set a variable. An aligned stw is guaranteed
> to set the variable atomically wrt all other processors.

Sorry I wasn't around for the beginning of this discussion (I was off with
visiting family...), but I'll jump in now.

I put this version of atomic_set() into Brian's source.  It is one of the
things that helped reduce the severity of the dcache symptoms.  You can't
just use a stw in atomic_set(), because the other atomic operations depend
upon the stwcx.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

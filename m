From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15857.16374.833902.735605@argo.ozlabs.ibm.com>
Date: Sat, 7 Dec 2002 11:25:26 +1100
To: Matt Porter <porter@cox.net>
Cc: Dan Malek <dan@embeddededge.com>,
	Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
In-Reply-To: <20021206112901.A18257@home.com>
References: <3DF0A4D9.4030603@intracom.gr>
	<IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se>
	<20021206085909.B17918@home.com>
	<3DF0D6B6.2050307@embeddededge.com>
	<20021206112901.A18257@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter writes:

> On Fri, Dec 06, 2002 at 11:56:22AM -0500, Dan Malek wrote:
> > Matt Porter wrote:
> >
> >  > ....  If you
> > > want the kernel virtual address then you can apply __va to that.
> >
> > Errr....no, you can't.  That would give you the cached mapping.
> > You need to hang on to both the dma_handle (the phys address token)
> > and the virtual address returned by the function.  That's why both
> > are returned.
>
> That's what I said...but you clipped it out.  Once again,
> consistent_alloc provides the caller everything they need.
> An uncached mapping, a phys address, and from that you can use
> __va() to get the cached mapping.

Matt, you know this I'm sure, but other people reading this might not:

You should NOT use the cached mapping unless you really know *exactly*
what you are doing.

The PowerPC architecture specifies that accessing a given physical
address through an uncached mapping, when there exists a copy of that
physical location in cache, is a programming error.  Different
implementations will do different things in this case.

> Seemed clear enough to me the first time.  My definition of a
> "kernel virtual address" is the lowmem cached mapping.  If
> I meant the uncached mapping I would have said it was a "kernel
> vmalloc address" or something. :)

A "kernel virtual address" is, to me (and to Dan as well, I expect),
any virtual address in the kernel portion of the address space
(i.e. above TASK_SIZE).  (Of course, you are free to adopt Humpty
Dumpty's attitude in Through the Looking Glass: "'When I use a word,
Humpty Dumpty said in rather a scornful tone, 'it means just what I
choose it to mean - neither more nor less.'" ;-)

Regards,
Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

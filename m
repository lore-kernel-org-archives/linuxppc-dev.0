From: Gareth Hughes <gareth@valinux.com>
To: Dan Malek <dan@mvista.com>
Date: Fri, 19 Jan 2001 17:53:27 +1100
Message-ID: <3A67E467.74544C4C@valinux.com>
MIME-Version: 1.0
CC: michdaen@iiic.ethz.ch, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: PPC Lockup (ati-pcigart-branch)
References: <3A67B401.8282A00F@relog.ch> <3A67BAC3.94EFEA3A@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Michel Dänzer wrote:
> >
> > [CC'ing linuxppc-dev, hopefully someone there knows what might be up...]
> >
> > This is where it dies:
> >
> >         /* FIXME: We should really have a kernel call for this...
> >          */
> >         entry->virtual = __vmalloc( (pages << PAGE_SHIFT),
> >                                     GFP_KERNEL,
> >                                     PAGE_KERNEL);
>
> This isn't very much information, but only one thing can really
> be wrong........
>
> What is the value of 'pages'?  I suspect it is huge (and perhaps
> wrong).  The GFP_KERNEL flag will cause vmalloc() to wait for pages
> to become available (i.e. it will swap other things out).  If this
> value in incorrect, this call will wait forever for pages that are
> never going to arrive.  Worse, it is going to keep sucking up pages
> and holding them, so nothing else is going to run either.  Is "pages"
> really the number of pages, or a size that was never converted to pages?

Pages is definitely the number of pages (at least when I wrote the
code...).

> ...and for the 'FIXME' comment, you want a function that does
> what? vmalloc?  Why don't you just call it (or one of the more
> appropriate variants if necessary)?

This was originally when I was passing a flag to make the memory
uncached.  This wasn't needed, and we really should be using
vmalloc_32(...) instead (which will result in exactly the same code, but
it is cleaner).

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

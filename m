Message-ID: <3A67BAC3.94EFEA3A@mvista.com>
Date: Thu, 18 Jan 2001 22:55:47 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: michdaen@iiic.ethz.ch
CC: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Lockup (ati-pcigart-branch)
References: <3A67B401.8282A00F@relog.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> [CC'ing linuxppc-dev, hopefully someone there knows what might be up...]
>
> This is where it dies:
>
>         /* FIXME: We should really have a kernel call for this...
>          */
>         entry->virtual = __vmalloc( (pages << PAGE_SHIFT),
>                                     GFP_KERNEL,
>                                     PAGE_KERNEL);

This isn't very much information, but only one thing can really
be wrong........

What is the value of 'pages'?  I suspect it is huge (and perhaps
wrong).  The GFP_KERNEL flag will cause vmalloc() to wait for pages
to become available (i.e. it will swap other things out).  If this
value in incorrect, this call will wait forever for pages that are
never going to arrive.  Worse, it is going to keep sucking up pages
and holding them, so nothing else is going to run either.  Is "pages"
really the number of pages, or a size that was never converted to pages?

...and for the 'FIXME' comment, you want a function that does
what? vmalloc?  Why don't you just call it (or one of the more
appropriate variants if necessary)?


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

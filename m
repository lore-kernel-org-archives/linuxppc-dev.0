Date: Thu, 23 May 2002 09:54:51 -0400
From: Dan Brennan <dmb8@optonline.net>
Subject: Re: eieio rule-of-thumb?
To: acurtis@onz.com
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Message-id: <3CECF4AB.7393E521@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <NCBBIINEHIPFGJPLBEIFAEIBDHAA.acurtis@onz.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you are using the 8260 the eieio does nothing. From the 603e User's
Manual:

The Enforce In-Order Execution of I/O (eieio) instruction is used to
ensure memory
reordering of noncacheable memory access. Since the 603e does not
reorder
noncacheable memory accesses, the eieio instruction is treated as a
no-op.

Allen Curtis wrote:
>
> > For access to PCI devices, use:
> >
> > {in,out}{b,w,l}               access to PCI I/O space (little endian)
> > {read,write}{b,w,l}   access to PCI memory space (little endian)
> >
> > For access to non-PCI devices on PPC platforms, use:
> >
> > {in,out}_8
> > {in,out}_{le,be}{16,32}
> >
>
> All of these make sense, but what about the Internal Memory Map? Are you
> suggesting that these macros should be used to access internal control
> structures, buffer descriptors, etc and ignore the structures defined in
> cpm_8260.h and imap_8260.h? In a typical system, this is where most of the
> non-cacheable I/O will occur. In many cases you probably do not care what
> order things happen at the micro level, in some cases you do. If you
> understand the problem you can optimize your solution, otherwise put the fix
> everywhere out of paranoia.  :)
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

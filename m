Message-ID: <3A6DADEF.D525DFCD@cisco.com>
Date: Tue, 23 Jan 2001 10:14:39 -0600
From: Mike Beede <mbeede@cisco.com>
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Dan Malek <dan@mvista.com>, Roman Zippel <zippel@fh-brandenburg.de>,
        michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101221945230.19978-100000@zeus.fh-brandenburg.de> <3A6C8C6E.3C19F151@mvista.com> <3A6C9852.4090201@valinux.com> <3A6CA6A9.7794B603@mvista.com> <3A6CAAA2.6090607@valinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Hartmann wrote:
>
> > Dan Malek wrote:
> > Ummm...of course it is virtually contiguous.  How could it be
> > different?  You request a size, and it returns a base virtual address.
> > If there were holes in it, how would you know?
>
> Look at vread in vmalloc.c, I think it would handle holes in a
> vmalloc'ed area (From a brief reading of the code.)  I've seen postings
> about this on linux-kernel.  I don't see a vwrite implementation, but I
> would assume you would have to do something similar for writes.

Separate calls to vmalloc can return noncontiguous regions, but the
memory
from a single call is contiguous.  Unless you mean *physically*
contiguous,
which isn't guaranteed at all. (I don't think you do--just thought I'd
be
clear).  After all, what good would it do to allocate multiple regions
and
return a pointer to the first?

	Mike
--
Mike Beede
Cisco Systems

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

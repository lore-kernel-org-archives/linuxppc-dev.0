MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16209.58174.726345.22844@nanango.paulus.ozlabs.org>
Date: Sun, 31 Aug 2003 21:59:58 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Wouter Cloetens <wouter@mind.be>
Cc: Trevor Woerner <ppc339@vtnet.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.4.22] Re: PPC405 support in later 2.4.x kernels
In-Reply-To: <20030829150115.GD1204@roadkill.intern.mind.be>
References: <20030829150115.GD1204@roadkill.intern.mind.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wouter Cloetens writes:

> On Thu, 31 Jul 2003 23:32:41 -0400, Trevor Woerner wrote:
> > I grabbed 2.4.22-pre8 and found the ppc4xx code back, but the strangest
> > thing is now happening: I've lost my user-space.
>
> I had the same problem with 2.4.22. I diffed 2.4.21-pre7 with 2.4.22
> and found some 405-specific code to be missing in the fault handler.
> The attached patch fixes the problem.

The patch is half of an optimization.  We have ended up with code
which never sets execute permission on the PTEs (my fault).  We should
either just add code (in the TLB miss handler or elsewhere) to set
execute permission on all pages, or else do the full lazy-flush
optimization, which involves the change in do_page_fault plus another
change to flush_icache_page to make it turn off hardware execute
permission rather than flushing the page.  (The latter half doesn't
seem to be in linuxppc-2.4 or linuxppc_2_4_devel, which is
interesting.)

I'll check in a proper fix in the next day or so.  In the meantime the
patch to do_page_fault will fix the problem.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

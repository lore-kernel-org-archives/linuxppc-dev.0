Message-ID: <3C63091A.4D9EA2D8@mvista.com>
Date: Thu, 07 Feb 2002 16:09:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Val Henson <val@nmt.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr> <20020207144308.C19569@boardwalk> <3C62F74F.DE090C2C@mvista.com> <20020207145844.F19569@boardwalk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Val Henson wrote:

> On Thu, Feb 07, 2002 at 02:53:19PM -0700, Mark A. Greer wrote:
> >
> > Val Henson wrote:
> >
> > > Also, I don't think this was a particularly good test of highmem since
> > > I don't think many bounce buffers were used, or that the kernel had
> > > much reason to map/unmap many highmem pages.  Unfortunately, my SCSI
> > > controller isn't working quite right and I can't test with a hard disk
> > > as a result.  Any ideas for stressing the system harder?
> >
> > You could try lowering max_low_mem.  You can do this by setting "Code
> > maturity level option"/"Prompt for advanced kernel configuration options"
> > and then going under where you selected HIGH_MEM and setting max_low_mem
> > size to something small.
> >
> > It will likely take some trial and error to get it stressed enough.
> > You'll have to start a bunch or processes and look at where they're
> > getting their memory
>
> See, I don't think that user processes using highmem pages is testing
> highmem much.  So we have user pages mapped by PTE's - what's changed?
> Not a whole lot.  It's when we use bounce buffers in the kernel or ask
> the kernel to map user pages or otherwise trigger the kmap/kunmap code
> that I'm interested in.

I agree.  What I had in mind was causing the kernel to kmap pages for some
reason like to copy user data into the buffer cache of a block device (see
generic_file_write).  I would make a pgm to allocate some mem (like the size
of your lowmem), mlock it down, then fork some processes that do short writes
to a block device or something like that.  I think that would do it.

Did you mentioned that your scsi ctlr or drive was bad?  If so, you'll have to
find some other block device, /dev/ram? maybe??

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 7 Feb 2002 14:58:44 -0700
From: Val Henson <val@nmt.edu>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020207145844.F19569@boardwalk>
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr> <20020207144308.C19569@boardwalk> <3C62F74F.DE090C2C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C62F74F.DE090C2C@mvista.com>; from mgreer@mvista.com on Thu, Feb 07, 2002 at 02:53:19PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 07, 2002 at 02:53:19PM -0700, Mark A. Greer wrote:
>
> Val Henson wrote:
>
> > Also, I don't think this was a particularly good test of highmem since
> > I don't think many bounce buffers were used, or that the kernel had
> > much reason to map/unmap many highmem pages.  Unfortunately, my SCSI
> > controller isn't working quite right and I can't test with a hard disk
> > as a result.  Any ideas for stressing the system harder?
>
> You could try lowering max_low_mem.  You can do this by setting "Code
> maturity level option"/"Prompt for advanced kernel configuration options"
> and then going under where you selected HIGH_MEM and setting max_low_mem
> size to something small.
>
> It will likely take some trial and error to get it stressed enough.
> You'll have to start a bunch or processes and look at where they're
> getting their memory

See, I don't think that user processes using highmem pages is testing
highmem much.  So we have user pages mapped by PTE's - what's changed?
Not a whole lot.  It's when we use bounce buffers in the kernel or ask
the kernel to map user pages or otherwise trigger the kmap/kunmap code
that I'm interested in.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

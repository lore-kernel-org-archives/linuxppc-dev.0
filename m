Message-ID: <3BB353D0.F4AA371D@mvista.com>
Date: Thu, 27 Sep 2001 12:29:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	John Francis <johnfrancsis@yahoo.com>,
	Greg Johnsong <johnson@research.canon.com.au>
Subject: Re: structs and defs for IDMA on MPC8xx???
References: <3BB33EBA.DF2DCA44@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> are threre any structs for IDMA in the recent kernel sources?

No, they would be in 'commproc.h'.  Again, just use a similar
method to all of the other device drivers for the CPM.  There
is a standard BD structure that is part of all devices for
DMA purposes, and simply add the information needed by IDMA.

> I need a way to access the IDMA's parameter RAM,

Don't confuse "parameter ram" and IDMA buffer descriptors.  If
you notice, the parameter ram is defined as the offset into the
appropriate pages of the CPM memory.  This information for IDMA
is not currently defined in 'commproc.h' and you will need to do that.

> I know Greg Johnson <gjohnson@research.canon.com.au> proposed some stuff
> last year. But they never made it into the linuxppc_2_4_devel, did they?

I don't recall anyone sending a patch to do this.  If they did,
I apologize for missing it and I'll look through the archives to
find it.

> I could think of something like
>
> /* Buffer descriptors used by IDMA
> */
> typedef struct idma_buf_desc {

There you go, the IDMA buffer descriptor.  Why didn't you just
edit commproc.h to include this, get it working, and send a patch :-)?

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

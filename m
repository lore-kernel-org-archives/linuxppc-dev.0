Subject: Re: Questions about 8xxrom
To: DBrown03@harris.com ("Brown, David (dbrown03)")
Date: Mon, 29 May 2000 12:25:07 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <BE1C564723B3D21191FD0000F840E39801D81549@rfcmx2.rfc.comm.harris.com> from "Brown, David (dbrown03)" at May 26, 2000 09:48:53 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000529022507.5F4463C9DF@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

"Brown, David (dbrown03)" writes:
> My flash starts at FF800000, and the zImage.initrd is stored at the
> beginning of flash.
...
> After all that, it still fails, while decompressing initrd.

I suspect Dan's comments last week explain that this doesn't currently work:

Dan Malek wrote:
> A very important note.....Because of the initrd logic in the Linux
> kernel, you can't uncompress a ram disk from Flash rom, it must be
> in RAM (pages are discarded when this is done).  The "magic" functions
> assume if loaded above 16 Mbytes, and a ram disk is attached, the
> ram disk portion of the image must be copied to ram.  If loading in
> ram above 16 Mbytes this will result in an unnecessary copying of
> the ram disk image, so it is probably best to load the image somewhere
> below 16 Mbytes if in memory.  There are lots of other assumptions
> and "special" memory locations used within these functions to support
> a variety of loading options on various boards and products.  It is
> best you realize this is a bunch of bits for production use and don't
> try to modify it for something else.  Lots of people depend on this
> image as it is.

Dan, any chance you could clarify what would need to be done in order to
decompress the initrd directly from flash?  We also want to do this
eventually, and would like to avoid the wasted copy to RAM.

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

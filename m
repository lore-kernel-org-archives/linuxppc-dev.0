Message-ID: <3AD1FD10.B410748F@mvista.com>
Date: Mon, 09 Apr 2001 14:18:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: nunninger@web.de
Cc: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about memorylocation of ramdisk
References: <3AD1B573.457F6DC6@enst.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nunninger wrote:


> ..... Some time later the kernel
> uncompresses the ramdisk and places it right behind the kernel in
> memory. Thus the
> uncompressed ramdisk reaches from 0x7d000 up to 0x47d000. However
> this is clearly the location where the compressed ramdisk resides
> which will be overwritten before being uncompressed completely.


Not exactly....I _think_ it is supposed to work like this.

When the kernel starts up, it "allocates" the area occupied by
the compressed ram disk from it's available space before it does
anything else.  The uncompressed ram disk is then stuffed into
the file system buffer cache, which could be randomly scattered
about memory in buffer cache size blocks.  These blocks are marked
so they are always resident in the cache.  After this is done, the
compressed ram disk area is placed back into the free page pool.


> ...... I
> can not put the binary file into flash though as I have only 512kB
> of Flash available currently.

...and if you could, you will discover the ramdisk is copied to
RAM before the kernel is started.  This is because of the logic
I described above about the kernel returning this space to the
free page pool.  Pages of Flash in the page pool are not a good thing :-).


> ...... I assume this is
> due
> to the problem described above.

Probably not.  I use ramdisks greater than 4 MB quite often without
trouble.  Since this is a custom board, you may want to ensure you
don't have some memory related problems, like an incorrectly programmed
memory controller.  It could be that your access patterns across
some boundaries (like 4M or 8M or something) aren't actually to the
area of part you assume.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

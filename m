Message-ID: <39819284.865441FD@apus.co.at>
Date: Fri, 28 Jul 2000 16:02:44 +0200
From: Reni Pachernegg <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Malloc returns non valid adress
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

Im using the kernel version 2.14 on a  special embedded ppc-system. The
livefs is copied from a flash-card to a ramdisk of 6MB. Total memory is
16 MB.
I found the following error:
	When trying to alloc more memory than available alloc is returning an
adress as if everything was ok.
	When trying to access the memory it hangs up with an infinite loop of
page fault exceptions.
I drag everything down to the function vm_enough_memory in mmap.c, where
the amount of free mem is calculated by adding buffermem >> PAGE_SHIFT
(later versions: buffermem_pages).  Buffermem is exactly set to the size
of the ramdisk, which means the ramdisk is treated like any block buffer
whiche can be freed any time if needed.
When I set :
	free = 0
instead of
	free = buffermem
everything works ok and malloc returns NULL whenever there isnt enough
memory available.
I suppose this is neither the best solution nor the real reason for the
error.
Could anybody give me a hint where to search for it ro what to do?

regards Rene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

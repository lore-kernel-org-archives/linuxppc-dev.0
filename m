Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id CBC502BDB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 01:50:35 +1000 (EST)
Received: from icarus.com (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id i91FoYe19450
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Oct 2004 08:50:34 -0700
Message-ID: <415D7CCA.6090907@icarus.com>
Date: Fri, 01 Oct 2004 08:50:34 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Performance of mmap/munmap on linuxppc 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I need to allocate, reallocate(down), and release lage image
buffers, and I've been thinking in terms of using mmap and
anonymous mapping to get the memory:

       void*ptr = mmap(0, cur->size_, PROT_READ|PROT_WRITE,
                       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

I also munmap the tail of this region when I know how big the
image really is, and munmap the rest when the image is done.
I'm doing this the hard way (instead of using malloc/realloc)
because I want to guarantee that the realoc functionality doesn't
move the data.

So am I shooting myself in the foot performance-wise here?
I'm using a 233MHz 405GPr. I expect to be allocating/freeing
these image buffers 30-50 times a second for 4meg-ish regions,
or somewhat slower for regions 60meg or so. I have no swap.


-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

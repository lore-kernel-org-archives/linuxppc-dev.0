Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (unknown [71.74.56.124])
	by ozlabs.org (Postfix) with ESMTP id BE2D5B70F6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 06:12:32 +1000 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o8GKCKBK019048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 15:12:20 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id o8GKCKtX019047
	for linuxppc-dev@ozlabs.org; Thu, 16 Sep 2010 15:12:20 -0500
Date: Thu, 16 Sep 2010 15:12:20 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@ozlabs.org
Subject: Help with finding memory read performance problem
Message-ID: <20100916201220.GC18608@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



For our code we needed a fast memory compare of 5 buffers.  I've implemented
said routine in asm and it works fine and is very fast in the test bench. 
However when integrated with the app it is much less performant and we 
are trying to figure out why.

The app in question gets the 5 4MB buffers in the kernel via kmalloc and
then uses them for DMA.  No other methods are being called for the memory
besides kmalloc.  This is an embedded system on the 460EX, so there is no
drive, only RAM.  Within the user code mmap is called on these buffers
physical address and they are given to the compare routine.  The result 
is slow.  If I allocate buffers in user space then the performance is
excellent.  

Next I implemented my compare routine within a kernel module so that it
was using the kernel virtual addresses for each of the buffers. I did 
not see any change between this and the mmap approach.  

For comparison sake, using the kernel memory is about 19s whereas user
memory is about 11s for the same size / configuration of buffer.  In the
test bench the algorithm is about 8s.  The processor is not doing any
other intensive tasks during these tests and the times are repeatable.

Is something happening to mmap'd memory that causes the access to it to
be slow?  Is there a way to speed that up?  Why are the kernel memory
access slower than user memory?  

What is the best overall approach?  Is it to DMA into user memory and
then run the routines there?  Is kmalloc not the best approach for 
kernel DMA memory?

This is on linux 2.6.31.5 on 460EX

thanks
ayman

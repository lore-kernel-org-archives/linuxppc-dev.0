Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BF3A67A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 03:43:42 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgmX6-0000GH-Pl
	for linuxppc-embedded@ozlabs.org; Thu, 18 May 2006 19:43:32 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 May 2006 19:43:32 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 May 2006 19:43:32 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: remap_page_range vs. map_user_kiobuf
Date: Thu, 18 May 2006 10:43:08 -0700
Message-ID: <e4ibnd$1ia$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


My setup is Linux 2.4.33 w/ bigphysarea patch. My application is
using a virtual device driver to mmap a bigphysarea chunk, which
uses the remap_page_range function. This works well, and for my
devices that are aware of this and take advantage, the contiguous
physical memory is a real boon.

However, I also have a device driver that is not made specifically
aware of this heap. In its "read" method, it uses a map_user_kiobuf
to map user memory into the kernel. I do this as part of preparing
to DMA the read. This driver gets a -EFAULT back from map_user_kiobuf
when it is passed a user buffer that is mapped from the bigphysarea
heap.

It appears that get_user_pages (in mm/memory.c) does not like the
VM_RESERVED flag and returns -EFAULT if it tries to get reserved
pages in this manner. Am I reading this right?

Is there a way I can map the bigphysarea heap into user space such
that map_user_kiobuf works on these heaps, or am I stuck with
making all drivers aware of this bigphysarea heap?

(This is an embedded system, so this is possible to do, if painful.)

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

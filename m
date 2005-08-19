Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 61D7C67EEE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 04:44:54 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7JIirl01770
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Aug 2005 11:44:53 -0700
Message-ID: <430628A5.7090505@icarus.com>
Date: Fri, 19 Aug 2005 11:44:53 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: NO_CACHE and mmaped pages
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I think the answer is "Yes", but I want to get a second opinion.

I need memory that is mapped into user space (so that I can manage
it as a BIG heap) but is not cached by the CPU, a PPC405GPr running
kernel 2.4.30something.

A possible solution is to in my driver support mmap and implement the
nopage function. The pages that I create in the nopage will be allocated
by the consistent_alloc function, which returns pages marked as NO_CACHE,
and so should be uncached.

The question is, "Is this NO_CACHE status/flag preserved when it is
mapped into the user address space? So far as I can see browsing the
do_no_page function in memory.c, that bit is indeed preserved in the
mapping. Am I right?

Alternatively, is there a way to change a region of memory no
unpaged, a la mlock for locking pages? I would rather not keep a
table of page pointers for 256Meg of memory just so I can do a
consistent_free later:-(

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

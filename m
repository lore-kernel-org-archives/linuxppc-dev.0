Message-ID: <37C65FF0.A5FBD535@agelectronics.co.uk>
Date: Fri, 27 Aug 1999 10:52:48 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Zero Pages / Cache Coherency
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm currently trying out the pre-zeroing of pages in the idle task, and
I'm a little worried about its effect on cache-coherency. I can't prove
to
my satisfaction that none of the pages being cleared by zero_paged() is
in the cache, and I'm not sure that turning off caching in the PTE will
have any effect on cache lines already allocated in L1 or L2.

Obviously, any incoherency would be extremely rare, but ensuring that
the page is invalidated from the caches before it is zeroed has the
added bonus of removing the need for a flush_page_to_ram() in my
modified anonymous memory allocator.

Any comments? 

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

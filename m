Message-ID: <37BBAAC5.E156BD06@switchboard.ericsson.se>
Date: Thu, 19 Aug 1999 08:57:09 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to enable data cache for MPC860
References: <035401bee95c$46cc26c0$68f102de@sjzhu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>   I have a MPC860 board, which there are some memory space like VRAM or ISA.
> I donot know how to enable data cache for DRAM, and will not effect
> the accessing VRAM and ISA.

You will need to use the mmu and use page tables that describes the IO
regions
as non-cacheable, and the dram tables as cacheable.
using the mmu will probably increase the performance because the cpu can
use
speculative instruction fetch.

have a look in head.S in the linux kernel source.
you will see how the cache is turned on and tables are reserved.
and finnaly is the mmu turned on.

please note that the cache should be invalidated, which not is done in
the
linux source code. it should be done in the bootcode that runs before
linux.
have a look in the manual.

i think motorola has some example code too if you look around at their
website.

cheers /

magnus

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

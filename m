Message-Id: <200102261835.NAA26566@mal-ach.watson.ibm.com>
To: "kerler" <kerler@mailandnews.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dynamic modification exception handler 
In-Reply-To: Message from "kerler" <kerler@mailandnews.com>
   of "Mon, 26 Feb 2001 19:06:27 +0800." <017201c09fe4$52a1cff0$5ef1d092@chn.agilent.com>
Date: Mon, 26 Feb 2001 13:35:25 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The suggested sequence for 604 and 604-derived processors is:

     dcbst (or dcbf)          ;# flush data block to memory
     sync                     ;# ensure flush made it to memory
     icbi                     ;# invalidate block from icache
     sync                     ;# wait for icbi to be globally performed
     isync                    ;# refetch instructions

	The dcbst must be performed before the icbi, because otherwise the
processor instruction prefetch mechanism could refetch the (stale) block
from memory before the dcbst/dcbf has actually been written back to
memory.  The sync between them is required for the same reason, because
icbi could be performed locally before the dcbst has sent the block to
memory.

	The dcbst/sync/icbi sequence can be batched up to amortize the
cost of the sync operations, but it should be written so all the dcbst's
are performed, then a sync, then all the icbi's:

     mr        r5, r3
     mtctr     blocks
$1:
     dcbst     r0, r5
     addi      r5, r5, 32
     bdnz      $1
     sync
     mr        r5, r3
     mtctr     blocks
$2:
     icbi      r0, r5
     addi      r5, r5, 32
     bdnz      $2

     sync
     isync


David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

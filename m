Message-ID: <3F0D95B2.6030702@embeddededge.com>
Date: Thu, 10 Jul 2003 12:34:58 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Anil Giri <anil@india.tejasnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: _PAGE_WRITETHRU option in 8xx
References: <1057841040.3f0d5f9022327@pop-mail.india.tejasnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anil Giri wrote:

>   I am using linuxppx_2_4_20 from denx and i can;t find the _PAGE_WRITETHRU
> option in include/asm-ppc/pgtable.h for 8xx. Is it replaced or ommitted?

Write through cache mode per page on 8xx is not easy to set.  It requires
additonal overhead in the TLB Miss handler that will affect all page misses
and is a performance loss for all applications.  Additionally, you can't
arbitrarily set this mode on a page because it causes conflicting cache
modes in the VM map.  You would have to add yet another special memory
space and management functions like we have for managing DMA coherent memory.

 From a systems engineering perspective, write through cache is seldom a
performance benefit.  For small address ranges and access, it is better to
use uncached memory because you don't replace lines more useful to others.
If you are heavily accessing cached data that must be synchronized with
other operations, copyback with explicit cache push provides better performance.

For debugging, you can globally select write through instead of copyback,
and obviously I'm not recommending using write through for normal operation.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

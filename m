Message-ID: <3BD3A110.40703@metaparadigm.com>
Date: Mon, 22 Oct 2001 12:31:12 +0800
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
References: <3BD38515.40808@metaparadigm.com> <20011021195758.E1419@cpe-24-221-152-185.az.sprintbbd.net> <3BD39166.7020600@metaparadigm.com> <20011021202843.B4933@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> On Mon, Oct 22, 2001 at 11:24:22AM +0800, Michael Clark wrote:
[snip]
>>Okay, changed to BMAC and it works okay - should BMAC detection come
>>before GMAC?
>>
>
> Er, say again?  And ignore what I just sent out (got confused fer a
> second).


It seems that GMAC and BMAC support some common hardware. What I was
suggesting is whether BMAC should be linked earlier so it's init
function runs before GMAC. Although I release this is not necessarily a
real solution for what may be a bug in GMAC (just means I and up using
BMAC which works and allows me to have both compiled in).

Some of GMAC initialisation seems to be delayed and done asynchronously.
Shouldn't link be detected and the interface brought up before return
from the init function? Otherwise it is impossible to use this driver
with IP autoconfig and NFS root.

~mc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

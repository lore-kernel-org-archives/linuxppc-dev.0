Message-ID: <3DE4DAE1.9060602@embeddededge.com>
Date: Wed, 27 Nov 2002 09:46:57 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: wilhardt@synergymicro.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455 and lwarx
References: <3DE3EF0B.F3204162@synergymicro.com> <3DE4C207.8020500@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> No, it is documented somewhere in Motorola docs that lwarx/stwcx. only
> work on writeback cacheable space. Earlier processors allow non-cacheable
> space, I believe that this restriction was introduced with the 7440/7450.

There are implementation options in the PowerPC specification that will
produce different "working" behavior when these instructions are not
used properly.  As Gabriel mentioned, the programmer interface specifies
these instrucitons work properly only on cached, writeback data spaces.
This is because the finest granularity implementation is a cache line and
the synchronization information is stored in the cache tag.  Processors
that aren't MP capable, like the 4xx, appear to operate as if they have
a single global flag to support lwarx/stwcx so the cache mode of the
desitination address (and the address itself) is irrelevant.  This
"restriction" has been around forever, MP systems won't work properly
without it (and all 6xx and "bigger" cores are MP capable).

Why do you want to use these instructions on a data space that isn't
cached?  Further, why are you running this class of processor with
uncached memory?

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

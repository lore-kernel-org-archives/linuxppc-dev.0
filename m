Message-ID: <3CFF0F88.5020600@embeddededge.com>
Date: Thu, 06 Jun 2002 03:30:16 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMbench results for large page patch
References: <20020605070832.GF2630@zax> <20020606042939.GU2630@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

 > ....There are a couple of things largepte still does better
> on, main memory latency (expected) and exec proc (unexpected).  The
> difference is small though.

The exec proc does lots of VM updates and TLB management.  The pinned
TLBs on the 4xx require additional management overhead to ensure they
aren't flushed when it is viewed as quicker to just flush the TLB.
The exec proc tests don't accomplish any useful work once the system
resources are allocated, so you are continually turning over the TLB and
any additional managemant will appear in this overhead.


> 	largepte still does as well or better than nopintlb in
> essentially every case.

Which is expected....now if we could just extend this to applications, we
would really have something :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

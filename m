Message-ID: <3E399074.3040203@embeddededge.com>
Date: Thu, 30 Jan 2003 15:52:04 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can software discover MPC8xx variant?
References: <1043848594.10504.41.camel@zambia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Zeffertt wrote:

> Can anybody tell me if there is a way to identify which processor from
> the MPC8xx family software is running on.

I haven't checked recently, but I believe the PVR still has the same
core type for all 8xx processors.  This is arguably a valid thing to
do since all of the PPC cores are the same in these processors.  There
are some mmu and cache differences, but they all behave in the same
generic manner.

> ....  I hoped I could use the IMMR
> special purpose register.  However, this only tells you the silicon
> revision, which can have the same value even if the processors are
> different!

Right.  The processors also have a CPM microcode revision number stored
in the DPRAM.  Since the real difference among the processors is the CPM,
you can read this number and likely detect the CPM configuration.  Perhaps
from all three values you can detect the processor variant.  From a software
perspective, it really doesn't matter if you can determine the actual
part number printed on the package (that's only for human consumption), but
you can detect the silicon configurations if you wish to dynamically adapt
to the different CPM configurations.

 From the first day of Linux on 8xx, we decided it wasn't worth the baggage
to try and dynamically detect all of these details (and we weren't sure we
could).  In the interest of small, efficient, embedded kernels we adpoted
the direction of configuring specifically for a known part.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

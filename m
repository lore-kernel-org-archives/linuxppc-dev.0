Message-ID: <3FD89141.2050205@embeddededge.com>
Date: Thu, 11 Dec 2003 10:46:09 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch> <20031210090327.A18009@home.com> <3FD83398.3020000@bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Grandegger wrote:

> Increasing the page size from 4 to 8 kB should, in theory, halve the
> page misses (if no large TLB pages are used).

It depends entirely on locality of reference.  Without doing any
kind execution analysis (which isn't the proper engineering practice)
you could assume it would help instruction pages and have little effect
on data pages.

> ... Unfortunately, increasing
> the page size seem not straight forward as it's statically used in
> various places and maybe the GLIBC needs to be rebuild as well.

The MIPS port uses various (but static) page sizes depending upon
the requirements of the processor core.  IIRC, their glibc can handle
this at run time.  Maybe Drow can add some comments here.  In any case
there are already kernel and user reference ports we should leverage
if we intend to go down this path.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

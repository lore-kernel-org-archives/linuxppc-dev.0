Message-ID: <3937BF76.BB429A58@embeddededge.com>
Date: Fri, 02 Jun 2000 10:06:46 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: Steve Tarr <tarr@lucent.com>,
        LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Motorola MPC8260-ADS Boot hassel
References: <430.959920193@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> >relocated to:  00400000 0040B288
> >board data at: 00407140 00407164 <= this is within range on line above
> >relocated to:  00200100 00200124

> The secondary boot code is being relocated over the top of the board data
> (before it is relocated). Perhaps this is your problem?

This is telling you everything is fine.  The initial board data in
this case is part of the first relocated image.  This is moved to
the following address (0x200100).  It's irrelevant in this case to
move the data, but to simplify the logic it is always done.  In the
case where the initial board data is part of the flash rom or (the
right way) passed to you by the boot rom, it must be relocated.

> -       if (current == bdflush_tsk)
> +       if (bdflush_tsk == 0 || current == bdflush_tsk)


This is the real solution to the problem.  Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

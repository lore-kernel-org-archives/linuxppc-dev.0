Message-ID: <3E63F89E.9030408@embeddededge.com>
Date: Mon, 03 Mar 2003 19:51:42 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <005401c2e0e4$27a1b6b0$020120b0@jockeXP>	 <3E63C6BE.6020002@embeddededge.com>	 <006a01c2e1da$e108ddd0$020120b0@jockeXP> <1046737789.885.15.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> If you know precisely what version of the chip has this bug fixed,
> then you can define a CPU feature bit, and enclose the dcbz in
> a CPU feature conditional section. That way, they will get nop'ed
> out on faulty CPUs.

The problem is we don't know because it was never a documented
problem.  It was very difficult to find, so I'm not surprised it
didn't always show up on the silicon errata.  Further, there may
not be enough information in the cpu identification registers to
determine this level of silicon revision.

We just can't nop the dcbz, we have to add explicit instructions
to perform the function if dcbz or other cache instructions don't
work properly.  It's also in an area where we have to be sensitive
to cache utilization.  We could end up with a situation where there
are lots of nops (using cpu features) or branches where reloading
the i-cache could kill all of the optimization we gained by making
the d-cache more efficient.

Thanks.

	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3BF4A2D4.5080302@embeddededge.com>
Date: Fri, 16 Nov 2001 00:23:32 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Armin Kuster <akuster@mvista.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel on walnut
References: <3BDD855B.8D3FC72F@inn.ericsson.se> <3BE971BC.34591FF1@inn.ericsson.se> <3BEBF4E5.B60BD9E3@inn.ericsson.se> <3BF2A361.5FBB0246@mvista.com> <3BF4041F.A732B099@inn.ericsson.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:


> But "time dd if=/dev/zero of=testing bs=1024k count=100" on a nfs mouted fs
> used to be 18s and is now 21s, a 16% slowdown not that I care much but still
> quite a large difference.

What versions of kernels/drivers are you comparing?  Do you do this
back-to-back with the same NFS server, or have you introduced more
variables into your testing?  This is why specially prepared network
performance testers are better suited for discussion.

Many versions of the 405GP Ethernet driver didn't use (and didn't have)
cache coherency functions properly.  It was basically lucky, and when
errors occurred you usually didn't see them because the packets were
discarded and retransmitted.  Recent versions of the driver now use
properly mapped and managed cache coherent memory.  When I was making
the driver changes for the new cache attributes, I was thinking we should
be experimenting with cached pages and invalidates/flushes traded off
against uncached pages.  There will certainly be a performance difference.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

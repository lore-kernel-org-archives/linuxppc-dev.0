In-Reply-To: <16544.16999.648530.393071@cargo.ozlabs.ibm.com>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com> <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
Cc: Amit Shah <amitshah@gmx.net>, linuxppc-dev@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Date: Tue, 11 May 2004 11:46:07 -0400
To: Paul Mackerras <paulus@samba.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 10, 2004, at 11:03 PM, Paul Mackerras wrote:

> ......According to page
> 2-63 of the MPC750 users manual: "Of the broadcast cache operations,
> the MPC750 snoops only dcbz, regardless of the HID0[ABE] setting."

But, read the following sentence.  "Any bus activity caused by other
cache instructions results directly from performing the operation on
the MPC750 cache."  A dcbz has to be broadcast, others do not because
their operations appear just as standard load/store ops.

The only thing we should have to do in software is the icbi, which is
no big deal to broadcast.

My experience has been that MPC750s work in a SMP environment
on a 60x bus.  Maybe I was just lucky?  The way I read the manual,
they should work with a proper memory controller.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

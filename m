Date: Thu, 15 Feb 2001 16:06:58 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: calling giveup_altivec on machine with no altivec!?
Message-ID: <20010215160658.P26702@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My Motorola MTX just crashed after the following code in _swithc_to
executed:

	if ((prev->thread.regs && (prev->thread.regs->msr & MSR_VEC)))
		giveup_altivec(prev);


Somehow prev->thread.regs->msr & MSR_VEC turned out true. I'm suspecting
something got overwritten somewhere..

This is an SMP machine so I'm wondering if there wasn't a race condition
on something with task structs..


--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3D124351.1020800@embeddededge.com>
Date: Thu, 20 Jun 2002 17:04:17 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
References: <20020620203455.GG16052@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> The first benefit of all of these changes is that it gets PCI working on
> MBX (and any other 8xx system with PCI).

No, it doesn't.  It just enables the 8259 to kinda work.  The PCI on MBX
does not work well, and this does nothing to improve it.  Does anyone have
a working MBX anymore?

> Comments?

There is more to these patches than just the interrupt change.  Why is
the CPM microcode, and so much of commproc.c changed?

Of course, I don't like it, but oh well.......It's just another hack that
doesn't do anything different.  Most importantly, I hate shit like this:

	request_irq(CPM_IRQ_OFFSET + CPMVEC_SMC2, ......

because you have to program the CPM with only the CPM vector number, not the
vector plus offset.  I want a real cascaded interrupt design, not just another
hack that opens the possibility to calling a generic PC function with the
wrong parameters.  The OpenPIC/EPIC are hacked just as badly, and there are
new integrated controllers coming that would benefit from a real design improvement
instead of just another hack.

I'm most concerned with the updates outside of just the interrupt stuff, and
I hope someone tests this.

Whatever you want......Have fun........


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

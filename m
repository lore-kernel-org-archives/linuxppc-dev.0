Message-ID: <39460E0C.CBEE73AD@agelectronics.co.uk>
Date: Tue, 13 Jun 2000 11:33:48 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC BOF at Ottawa Linux Symposium July 19
References: <OF1ED8D32F.3AA2FD26-ON852568F9.0061D9AD@pok.ibm.com> <20000610182014.H31097@medea.fsmlabs.com> <39453A10.55C5F4D6@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> As a workstation/server BOF, I don't know how much interest exists to
> discuss this.  The easy answer is a set of orthogonal directory trees,
> but I think the highest priority should be on maintaining a set of
> common files.  Having experienced splitting some processor dependent
> files, I would still take the #ifdefs over tracking similar changes
> across multiple files.

I'd go with that some of the way, but I think MMU_init() in mm/init.c
goes a bit too far. It feels like every time I port my patches to a new
release kernel somebody has added extra boards and I have to sort switch
statements out by hand.

As an example, looking at 2.2 and 2.3, the actions performed by
xxx_find_end_of_memory() haven't changed very much. There probably
wouldn't be much problem introducing a ppc_md.find_end_of_memory call(),
and patches to add new machines would apply much cleaner.

I don't think the world is ready for my dream of eliminating _machine
completely, but if there's any interest I can attempt a test refactoring
of mm/init.c. This needn't be an all at once change; the idiom I'm
thinking of goes something like:
	if (ppc_md.do_whatever())
		ppc_md.do_whatever();
	else {
#ifndef CONFIG_8xx
	switch(_machine)
	...
#else
	8xx_do_whatever();
#endif
	}

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@mvista.com>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Date: Thu, 23 Aug 2001 13:08:18 +0200
Message-Id: <20010823110818.2847@smtp.adsl.oleane.com>
In-Reply-To: <20010823074100.31846@smtp.wanadoo.fr>
References: <20010823074100.31846@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>I'm now able to run a very simple binary as init - basically "Hello,
>>world!" implemented with one write() syscall, and none of the libc
>>initialisation junk present.  A one write hello world with the normal
>>crt0 (statically linked) fails.
>
>Ok. So this would mean the problem is with the libc junk ? Hrm.
>I didn't trace that far yet, but I suspect the libc I've been
>using (the "normal" 6xx one) lacks some cache stuffs. I'm
>pretty convinced that we must inval the entire instructions cache
>each time we used to do icbi's (either that or handle the cache
>aliasing issues specific to the 405GP weird icache design).
>
>I'll do more experiments later today.

I found at least one other problem: The kernel is happily doing
tlbie's on the 405 (which doesn't support them). Among other places,
calls to flush_HPTE are turned into _tlbie which is not redefined
to do a tlbia, causing at least ioremap to break.

I'll push a fix for that today.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3E8F2101.3090103@embeddededge.com>
Date: Sat, 05 Apr 2003 13:31:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: tglx@linutronix.de,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: check MMU state
References: <200304051735.25831.tglx@linutronix.de>	 <1049554177.654.3.camel@zion.wanadoo.fr>	 <200304051815.40797.tglx@linutronix.de> <1049556246.654.7.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Ah well, I was talking about the "common" CPU case (CONFIG_6xx), I don't
> know about 8xx but since the first thing the code  in head_8xx.S does is
> "tlbia", I think you are in a bad situation running that with
> translation enabled and no vectors around to handle the TLB miss...

Well, it's worse then that.....if you have the MMU enabled and require
taking tlb misses, I'm surprised you get to initial_mmu because we already
wrote over the exception vectors.

> For machines without BATs, I tend to think that a bootloader loading
> you with MMU on shall be shot.

We could do like some of the 60x/7xxx processors do.  They boot with
the MMU enabled, using BATs mapped 1:1 to get certain cache attributes in
memory spaces (DINK does this).  If you are using large pages on 8xx mapped 1:1
for the same cache attributes, it's OK.  If _any_ powerpc boots with the MMU
enabled and not 1:1 mapping (on memory of interest), you are hosed.

> .... What I'd suggest is that you hack a piggy
> back loader in the zImage wrapper that shuts MMU off before entering the
> kernel.

Yep, and it should be done right away before any of the decompress is
done so the cache management works correctly.

> .... If you _have_ to run vmlinux as is,

You can't on 8xx and most embedded systems.  You need some kind of piggyback
loader to create the environment variables so Linux will boot properly.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

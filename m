From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 21:40:15 -0700
To: Troy Benjegerdes <hozer@hozed.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030305044015.GB5355@rover.farnsworth.org>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com> <20030305010318.6A4D3C6E0C@atlas.denx.de> <20030305022134.GR24171@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030305022134.GR24171@kalmia.hozed.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 02:21:35AM +0000, Troy Benjegerdes wrote:
> If you can find a SMP system that uses XIP, then let's change it.
>
> We should only be writing to kernel text on an SMP system that has
> firmware that requires you to jump into the wrapper on both cpus.

I believe it happens on all ppc SMP systems.  It certainly happens
on powermacs which don't use the wrapper for cpu != 0.

> Dale, instead of changing head.s, can you use your own relocate.s for
> your wrapper? Don't you have to mess around with holding the 2nd cpu in
> the wrapper?

Sure, we could add an ifdef to have the wrapper start the kernel at 0xc like
prep/head.S does.  I'd rather use common code where possible though.

-Dale

P.S.  Note that I'm not proposing any additional writes to low memory.
I'm only proposing that we change the nop at 0x0 to "b .+0xc" .

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

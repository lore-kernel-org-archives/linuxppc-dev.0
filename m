Subject: Re: Caching in the MPC107, linux 2.6
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040315203849.GA13167@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
	 <20040313170708.GA20738@smtp.west.cox.net> <1079380996.1677.2.camel@newt>
	 <20040315203849.GA13167@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1079390532.1677.12.camel@newt>
Mime-Version: 1.0
Date: Mon, 15 Mar 2004 22:42:13 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-03-15 at 20:38, Tom Rini wrote:

> Actually, I was thinking that having an extra nop there on the !SMP &&
> !(745x && MPC107) case wouldn't hurt much / at all, and having this
> feature bit be done unconditionally.  But in cpu_setup_6xx.S we would
> compare the host bridge vendor / device ID to that of an mpc107.  Or am
> I not thinking right, and doing that comparison at that time would be a
> bad idea?  If so, I can live with it being an unconditional option, iff
> it's only required when MPC10X_STORE_GATHERING is enabled.

The only problem I see is that in cpu_setup_6xx.S we can't yet do the
config cycles to tell that it is an MPC107. Luckily, all MPC10x boards
that I know of require an explicit platform selection option.

I made my patch depend on CONFIG_MPC10X_BRIDGE, instead of
CONFIG_MPC10X_STORE_GATHERING, because I'm in the middle of porting
other MPC107 drivers from kernel 2.4 to 2.6.

An extra nop won't hurt, but there is a performance cost to
_PAGE_COHERENT which we should avoid unless necessary.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

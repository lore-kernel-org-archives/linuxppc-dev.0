Subject: Re: how to setup PLL1 on 750FX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0306261631001.9491-100000@stoa.dhs.org>
References: <Pine.LNX.4.44.0306261631001.9491-100000@stoa.dhs.org>
Content-Type: text/plain
Message-Id: <1056713849.32123.38.camel@gaston>
Mime-Version: 1.0
Date: 27 Jun 2003 13:37:30 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I don't understand how it is that my machine didn't lockup when PLL1 was
> in the off state.

Well... I may have a bug making my low-speed-during-idle code not work
... Or maybe the PLL1 beeing off means the CPU will just continue
locking on PLL0...

> Anyway, I decided to set PLL1 in identify_cpu in misc.S.  Actually, I put
> the code to detect the 750fx and set PLL1 in a seperate method.  Here's
> what I have:

That looks fine overall but I didn't look at the assembly in details yet,
I'll try to take some time to review your code in more detail & eventually
commit to the linuxppc trees.

Another place where you want the real PVR is the CPU save/restore state
code in cpu_setup_6xx.S. That code is used for example to save the CPU
state before sleep and restore it on wakeup.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 15 Jun 2004 09:12:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040615161258.GA14528@smtp.west.cox.net>
References: <20040605074341.GA15279@suse.de> <20040608112556.GA21447@suse.de> <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040614211931.GA21113@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 14, 2004 at 11:19:31PM +0200, Olaf Hering wrote:

>  On Mon, Jun 14, Tom Rini wrote:
>
> > ... except that we can have 'dssall' even when CONFIG_ALTIVEC=n, so we
> > need it really on CONFIG_6xx.
>
> switch_mm() has it in CONFIG_ALTIVEC, so checking for CONFIG_ALTIVEC=y
> looks correct to me.

arch/ppc/kernel/l2cr.S unconditionally has 'dssall', and this file is
compiled on all CONFIG_6xx builds.

> > But more importantly, why did you break the check to stop people with
> > broken binutils from trying to compile the kernel, and not fix the rest
> > of the breakage ?
>
> What exactly is broken in the old binutils?

They do not understand 'dssall' (and a few other) instructions.  So in
2.4 we didn't call them directly, but had something along the lines of:
#ifndef DSSALL
#define DSSALL 0x........
#endif

Using dssall was just a choice of convenience.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

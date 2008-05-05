Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 9046BDDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 21:55:44 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 5 May 2008 13:55:37 +0200
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Message-ID: <20080505115537.GA16128@iram.es>
References: <1209770875.26383.14.camel@pasglop>
	<20080502.163855.96423898.davem@davemloft.net>
	<1209801017.26383.21.camel@pasglop>
	<20080503.005510.88048425.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080503.005510.88048425.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 03, 2008 at 12:55:10AM -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sat, 03 May 2008 17:50:17 +1000
> 
> > Best would be if we could get those runtime bits linked in the module
> > itself, but I don't know enough about our toolchain to know if that's
> > easy (I suppose everything is always possible :-)
> 
> The only downside is that you'd have N copies of these
> routines, one for every module that emmited the libcalls.

It's probably not as bad as it seems: 

1) it will be smaller than having the saved/restore inlined in every 
function prologue and epilogue

2) as soon as you have ten functions or so that call them, it might
even be smaller than the size of all the trampolines. Unless I'm
mistaken, you would need at least two trampolines for every entry
point that you use in the save/restore routines, which have an entry
point at every instruction boundary or so. That's about 32 bytes
(8 instructions) per set of save/restore functions IIRC.

The ultimate solution might be lo link all these routines at a fixed
large absolute address (between -32M and -1UL) so that you can
call them with a bla instruction. But this requires memory layout
changes which would be quite painful.

	Regards,
	Gabriel

Date: Sun, 16 Jan 2000 09:46:58 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000116164658.ZM13760@saguaro.lan>
In-Reply-To: Sean Chitwood <darkmane@w-link.net>
        "Help w/ gdb" (Jan 15, 11:12pm)
References: <Pine.LNX.4.10.10001152247220.28099-100000@darkmane.w-link.net>
To: darkmane@w-link.net,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help w/ gdb
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 15, 11:12pm, Sean Chitwood wrote:

> I periodically ask this question here because I have never found a
> more appropriate audience or satisfactory answer.
> 
> I am attempting to help w/ the mozilla project, but I am having
> little success due to the following problem.  When I attempt to
> debug an assert/crash as I bring up the stack trace I notice that
> some of the frames point only to the ending curly brace of a
> function (Not always the one it says is being debugged).  I cannot
> examine variables, or learn anything else productive about the
> situation.  I realize I am not familiar w/ gdb, I am primarily
> familiar w/ windows GUI based debuggers, so I figure I am missing a
> configuration setting, but for the life of me I can't figure out
> what it is.  I do know that I am keeping the source and binary files
> synced, so that shouldn't be it.  It seems to load the symbols
> correctly (no complaining about missing symbols), butother than that
> I seem to be clueless.

I think this is a bug in either the linker or in gdb itself.  (If it's
the bug I'm thinking of, the bug is actually in the linker, but is
more easily worked around in gdb.) Get the gdb sources and take a look
at config/powerpc/tm-linux.h.  Now search for the line

#define SOFUN_ADDRESS_MAYBE_MISSING

Is it there?  (I'm guessing not.) Try adding the above line to
tm-linux.h and then rebuild gdb.

Let me know if it fixes your problem.

Thanks,

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <3F5E27D2.3090808@acm.org>
References: <3F4FB0F3.9090906@acm.org> <20030829131824.B18608@home.com>
	 <3F574958.4090402@acm.org> <3F58AA89.80803@acm.org>
	 <3F5E27D2.3090808@acm.org>
Message-Id: <1063136371.642.44.camel@gaston>
Mime-Version: 1.0
Date: Tue, 09 Sep 2003 21:39:31 +0200
Subject: Re: Change to allow signal handlers to set SE and BE bits.
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-09-09 at 21:19, Corey Minyard wrote:
> Paul came up with a much better method for this.  I have added a syscall
> that does a "debug" return from the signal handler.  It's much cleaner.
>
> I ahve a patch for this, and I've done a number of things besides just
> this.  I seemed bad to me to add yet another kludge to the beginning of
> DoSyscall for handling yet another signal return value.  So I turned all
> the signal return syscalls into normal syscalls.  This should speed up
> normal syscall handling by removing four instructions from the syscall
> entry.  Is this ok?

The problem with changing the signal return is that you break at least
gdb, and maybe more (g++ stack unwinding ?)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

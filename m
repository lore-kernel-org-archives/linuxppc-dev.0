Message-ID: <3F5E4749.6080105@acm.org>
Date: Tue, 09 Sep 2003 16:34:01 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org> <20030829131824.B18608@home.com>	 <3F574958.4090402@acm.org> <3F58AA89.80803@acm.org>	 <3F5E27D2.3090808@acm.org> <1063136371.642.44.camel@gaston>
In-Reply-To: <1063136371.642.44.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What if you went back to using the original syscall numbers?  Those seem
to have code in gdb to support them.

-Corey

Benjamin Herrenschmidt wrote:

>On Tue, 2003-09-09 at 21:19, Corey Minyard wrote:
>
>
>>Paul came up with a much better method for this.  I have added a syscall
>>that does a "debug" return from the signal handler.  It's much cleaner.
>>
>>I ahve a patch for this, and I've done a number of things besides just
>>this.  I seemed bad to me to add yet another kludge to the beginning of
>>DoSyscall for handling yet another signal return value.  So I turned all
>>the signal return syscalls into normal syscalls.  This should speed up
>>normal syscall handling by removing four instructions from the syscall
>>entry.  Is this ok?
>>
>>
>
>The problem with changing the signal return is that you break at least
>gdb, and maybe more (g++ stack unwinding ?)
>
>Ben.
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

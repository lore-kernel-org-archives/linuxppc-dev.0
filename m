Message-ID: <3C0D5D03.1060303@embeddededge.com>
Date: Tue, 04 Dec 2001 18:32:19 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: kentborg@borg.org
Cc: linuxppc-embedded@lists.linuxppc.org,
	rudolf.ladyzhenskii@act-aus.net, paq@wavemark.com
Subject: Re: Abatron for Userland Debugging?
References: <20011204224832.4724.qmail@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kentborg@borg.org wrote:


> -kb, the Kent who is thinking the Abatron will be useful in watching
> ptrace and gdbserver chat with one another.

You have to be a little bit careful with this.

First, there is a configuration option to add BDI context switch.  This
switches the user page tables for teh BDI so you can at least look into
the process space for the current thread.  This is useful for things like
system call tracing to see what the application actually did.  This is a
configuration option because it adds a couple of instruction to the
context switch path.

Second, when debugging ptrace or gdb activity with the Abatron, you have
to be careful on some processors.  For example, on 4xx processors the
BDI2000 uses the same processor debug registers as gdb or ptrace would,
so you end up fighting over the debug register contents and no one knows
what it going on.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

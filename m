Date: Fri, 19 Apr 2002 08:00:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Neil Horman <nhorman@lvl7.com>
Cc: "Kim, Kwansuk" <kskim@neowave.co.kr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: The maximum size of stack in linuxppc kernel
Message-ID: <20020419150026.GA31656@opus.bloom.county>
References: <OMENKEONFDLIGLHPFALBMELMCIAA.kskim@neowave.co.kr> <3CC00515.4429E463@lvl7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CC00515.4429E463@lvl7.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 19, 2002 at 07:52:53AM -0400, Neil Horman wrote:

> Hello-
>     The exact size of the stack is based on the size of the task_union structure
> in sched.h.  Because of the way a union works in C the task_struct defined in
> the union is aligned toward the low address end of the structure, which is
> overall 8K in length, to satisfy the stack variable space requirements.  The
> remainder of that space is used as kernel stack on behalf of whichever process
> causes a trap into the kernel.  I think in the event of an interrupt, the kernel
> stack used is whichever one the current variable points to.  So to summarize,
> the total allocated kernel stack size for any given process is 8K minus the size
> of the task structure defined in sched.h

And, if you're finding your self in need of growing the stack, you need
to stop and think about what you're doing since this is almost always
the wrong approach.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

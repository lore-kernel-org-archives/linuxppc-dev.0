Subject: Re: SMP kernels on single processor machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Lee Braiden <lee_b@member.fsf.org>
In-Reply-To: <XFMail.20040521123444.pochini@shiny.it>
References: <XFMail.20040521123444.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1085137865.6133.2.camel@gaston>
Mime-Version: 1.0
Date: Fri, 21 May 2004 21:11:06 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-05-21 at 20:34, Giuliano Pochini wrote:

>
> 2.6.6 has the CONFIG_PREEMPT option so I thought it was stable.
> Isn't it ?  What are the known problem ?  Is only preempt+smp
> known to have problems ?

Well, there are 3 different things.

One is stability. I don't know of any ppc-specific problem with preempt,
though I do have reports of people experiencing problems (mostly various
kinds of segfaults) when it's enabled. I'm not sure what is to blame at
this point, possibly one of the filesystems.

Another is overhead. Preempt definitely adds overhead to the kernel. The
spinlocks, on an UP kernel, are mostly NOPs, while with preempt, they are
actually implemented (among others). Overall, preempt adds overhead to the
kernel.

Finally, the supposed benefit. Mostly a myth imho.

For those who didn't get it (yes, that happens), the kernel, even without
preempt, will preempt user processes :) Linux has always been a preemptible
operating system. CONFIG_PREEMPT only concerns the ability for the kernel
to preempt itself when a process triggers a potentially long operations
within the kernel.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

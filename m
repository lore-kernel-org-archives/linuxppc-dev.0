Date: Fri, 5 Apr 2002 10:28:54 -0700
From: Matt Porter <mporter@mvista.com>
To: Greg Griffes <ggg@ieee.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 7400 mmu_init problem
Message-ID: <20020405102854.A15453@home.com>
References: <00e101c1dc8e$f4f8d720$6401a8c0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00e101c1dc8e$f4f8d720$6401a8c0@attbi.com>; from ggg@ieee.org on Fri, Apr 05, 2002 at 05:45:08AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 05, 2002 at 05:45:08AM -0500, Greg Griffes wrote:
>
> Hello,
>
> I am trying to port linuxppc_2_4_devel to a custom 750 design.
> Using the GNU binutils and gcc-core-2.95.3 tools.

7400 (subject line) or 750? :)  It doesn't matter though.

> After ppc_md.progress reports "MMU: exit" in mm/init.c::mmu_init()
> the kernel goes into panic() and dies there.
>
> I have been using a lousy, unreliable JTAG debugger. Today, I have a
> BDI2000 and will be learning how to use it and GDB :-))

Even with a bad debugger you should be able to dump log_buf to
see the oops message.

> Has anyone experienced this in the past?

If I had a nickel for every time...

> Does anyone have a rough idea of the cause of the problem?
> My guess is that it could be many possible problems, but, it has to
> be something that I did wrong in <my>_setup.c I haven't changed
> much in the kernel itself.

We can only guess since we don't know your hardware and can't see
your board specific code.  However, you made it out of MMU_init
and most likely got to start_kernel:setup_arch.  I can only guess
that you access an unmapped area in your <board>_setup_arch.

> The low level IO is mapped at 0xEC00_0000; could that be a problem?

What low level IO?  Are you attempting to map and use it early on?
We need more details to help further.

> The kernel is configured very slim, could I be excluding necessary
> functionality?

Not really.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

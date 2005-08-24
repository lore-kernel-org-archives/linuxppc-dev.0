Return-Path: <hollis@penguinppc.org>
In-Reply-To: <a22149f6d9cc6f65ae2f8f339d982dd2@us.ibm.com>
References: <a22149f6d9cc6f65ae2f8f339d982dd2@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0dac9cb23e9a6db6a80d8d15c4fc5e99@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Wed, 24 Aug 2005 08:52:36 -0500
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: PPC64-dev List <linuxppc64-dev@ozlabs.org>,
	Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: GDB backtrace and signal trampolines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 11, 2005, at 10:54 AM, Hollis Blanchard wrote:

> GDB 6.3 contains this code in ppc-linux-tdep.c:
>
> static const struct frame_unwind *
> ppc_linux_sigtramp_sniffer (struct frame_info *next_frame)
> {
>   struct gdbarch_tdep *tdep = gdbarch_tdep (get_frame_arch 
> (next_frame));
>
>   if (frame_pc_unwind (next_frame)
>       > frame_unwind_register_unsigned (next_frame, SP_REGNUM))
>     /* Assume anything that is vaguely on the stack is a signal
>        trampoline.  */
>     return &ppc_linux_sigtramp_unwind;
>   else
>     return NULL;
> }
>
> Essentially it says that any time the program counter is above the 
> stack pointer, we must be in a signal trampoline, and so GDB proceeds 
> to grope about for a struct rt_sigframe on the stack.
>
> This is not a good assumption. I'm using a GDB stub to debug Xen, and 
> as it so happens, the Xen stack is below the Xen text. That means that 
> the above test always triggers, but of course there is no rt_sigframe 
> on the stack, and my backtrace runs away.

FYI: I looked at a GDB snapshot (gdb-6.3.50.20050818) and the problem 
had been resolved.

-Hollis

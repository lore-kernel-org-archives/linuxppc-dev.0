Message-ID: <39C7A4F3.133DF04D@mvista.com>
Date: Tue, 19 Sep 2000 10:40:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb/Sandpoint -- patch & help needed
References: <alexsh@hectic.net> <7803.969334757@msa.cmst.csiro.au> <20000919193930.C1406@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:

> Hi, Murray!
>
> On Tue, Sep 19, 2000 at 02:39:17PM +1100, you wrote the following:
>
> > >... However, with this patch the kernel
> > >hangs right after saying "Now booting the kernel". I don't even see
> > >how these changes could affect the boot process so early.
> >
> > Aha! I was caught by this. When you enable CONFIG_KGDB, a breakpoint is
> > executed in setup_arch() which is just about the first thing the kernel
> > does.
>
> Right, but before calling setup_arch, it prints the linux kernel
> banner! Here's the code:
>
>         printk(linux_banner);
>         setup_arch(&command_line, &memory_start, &memory_end);
>
> And I don't see the banner. Did you see it when you encountered this?

printk's are logged to a buffer until the kernel has initialized the console
and then dumps it all out.  At this point, the console isn't initialized.  The
initialization is done with the call to console_init() (in
init/main.c:start_kernel) which eventually calls register_console() which will
dump out the logged msgs.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Tue, 19 Sep 2000 19:39:30 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb/Sandpoint -- patch & help needed
Message-ID: <20000919193930.C1406@hectic.net>
References: <alexsh@hectic.net> <7803.969334757@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7803.969334757@msa.cmst.csiro.au>; from Murray.Jensen@cmst.csiro.au on Tue, Sep 19, 2000 at 02:39:17PM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Murray!

On Tue, Sep 19, 2000 at 02:39:17PM +1100, you wrote the following:

> >... However, with this patch the kernel
> >hangs right after saying "Now booting the kernel". I don't even see
> >how these changes could affect the boot process so early.
>
> Aha! I was caught by this. When you enable CONFIG_KGDB, a breakpoint is
> executed in setup_arch() which is just about the first thing the kernel
> does.

Right, but before calling setup_arch, it prints the linux kernel
banner! Here's the code:

        printk(linux_banner);
	setup_arch(&command_line, &memory_start, &memory_end);

And I don't see the banner. Did you see it when you encountered this?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

NTL have a new network routing protocol as invented for amusing
small children. Its called 'now you see it now you dont' with much
of the US vanishing at cardiff for 10 seconds every minute or so.
	-- Alan Cox on a diary update

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 23 May 2002 12:09:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Nate Pletcher <pletch@po.cwru.edu>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: using cpm interrupts on 8xx
Message-ID: <20020523190926.GJ6269@opus.bloom.county>
References: <20020522162110.447DF1196F@denx.denx.de> <1022180488.1225.63.camel@soundgarden>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1022180488.1225.63.camel@soundgarden>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 23, 2002 at 03:01:26PM -0400, Nate Pletcher wrote:

> Ok, I tried using cpm_install_handler in my loadable module by including
> arch/ppc/8xx_io/commproc.h and it compiles cleanly, but when I try to
> insert the module I get:
>
> # insmod fpga.o
> fpga.o: unresolved symbol cpm_install_handler
>
> I looked through the Linux 2.2.14 source we are using and the function
> is there but it isn't exported in arch/ppc/kernel/ppc_ksyms.c.  I added
> a line to export the symbol but still got the same error.  Any ideas?

It's a 'feature':
$ mv .config /tmp/
$ make distclean
$ mv /tmp/.config .
$ make oldconfig
$ make zImage modules
And try again.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Tue, 12 Aug 2003 08:25:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Build issues with 2.6.0-test3
Message-ID: <20030812152503.GK807@ip68-0-152-218.tc.ph.cox.net>
References: <3F33BC10.8060407@imc-berlin.de> <3F33EADE.4010908@embeddededge.com> <3F38DEC4.8050708@imc-berlin.de> <1060696614.31273.419.camel@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060696614.31273.419.camel@hermes>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 12, 2003 at 07:56:55AM -0600, Gary Thomas wrote:

> * How best to handle optional support?  One of the patches fixes
>   a problem of a missing system call (sys_pciconfig_iobase).  In
>   this case, the platform I was building for has no PCI, so it's
>   not configured in.  The way I fixed it was to conditionalize
>   the syscall table.  An alternate way would be to have a module
>   which is compiled if CONFIG_PCI is *not* set (or alternately
>   have arch/ppc/kernel/pci.c always be compiled and export the
>   appropriate functions that just return -ENOSYS).  Comments?

'cond_syscall' is _supposed_ to work here.  But in this one case, it
does not.  I've tried tracking this down a little bit, and the 'weak'
asm bits make it as far as the pci.s file, but not the pci.o.  And to
make it all the more odd, if I threw the cond_syscall into a file in
kernel/ (just to try it out), it works.

> * I have a number of boards/platforms that I support that have
>   not been moved into 2.6.  Can I just send patches for those
>   as well?

In the same manner you did for 2.4, yes (logical patches, and preferably
against linux-2.5 (linux-2.6 now?) tree.  If something is missing there
(it shouldn't be, but it could be :)) that is in linuxppc-2.5, either
move it over in another changeset, or bug myself / paul / ben.

> * Has anyone succeeded in building & running 2.6 (or late 2.5)
>   on any embedded boards (8xx/8260/405)?

No / Yes / Yes.

BTW:
> Index: arch/ppc/8260_io/uart.c
> ===================================================================
> RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/8260_io/uart.c,v
> retrieving revision 1.1
> diff -u -5 -p -r1.1 uart.c
> --- arch/ppc/8260_io/uart.c	12 Aug 2003 12:18:15 -0000	1.1
> +++ arch/ppc/8260_io/uart.c	12 Aug 2003 13:30:40 -0000
> @@ -2389,11 +2389,11 @@ void kgdb_map_scc(void)
>  	up->smc_mrblr = RX_BUF_SIZE;		/* receive buffer length */
>  	up->smc_maxidl = RX_BUF_SIZE;
>  }
>  #endif
>
> -static kdev_t serial_console_device(struct console *c)
> +static struct tty_driver *serial_console_device(struct console *c, int *index)
>  {
>  	*index = c->index;
>  	return serial_driver;
>  }

After looking at the similar code in drivers/serial, I don't think this
is sufficient.  But I didn't dig too far into seee what c->data was
there.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

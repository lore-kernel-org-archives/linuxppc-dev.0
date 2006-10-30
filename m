Return-Path: <dbolcsfoldi@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id EFCCA67CA1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 06:45:49 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so1183024nzd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 11:45:48 -0800 (PST)
Message-ID: <609d5c8e0610301145y30d058afs467d27d344149936@mail.gmail.com>
Date: Mon, 30 Oct 2006 11:45:45 -0800
From: "David Bolcsfoldi" <dbolcsfoldi@gmail.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
In-Reply-To: <877iylreca.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	<87lknadbbl.fsf@sleipner.barco.com>
	<877iylreca.fsf@sleipner.barco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/27/06, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
>
> Peter> I'll test and take a closer look at your patch when I have
> Peter> access to hw again on Monday.
>
> Sorry, it got a bit later than promised, but I've now had a closer
> look at your patch ..
>
> --- uartlite/arch/ppc/boot/simple/misc.c        2006-10-15 14:09:47.000000000 -0700
> +++ uartlite-mod/arch/ppc/boot/simple/misc.c    2006-10-15 13:58:51.000000000 -0700
> @@ -48,7 +48,8 @@
>  #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
>         || defined(CONFIG_VGA_CONSOLE) \
>         || defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -       || defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
> +       || defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +       || defined(CONFIG_SERIAL_UARTLITE_CONSOLE)) \
>         && !defined(CONFIG_GEMINI)
>  #define INTERACTIVE_CONSOLE    1
>  #endif
>
> The Xilinx boards use misc-embedded.c not misc.c - Why is this needed?
>

You are right, it's not.

> +unsigned long serial_init(int chan, void *ignored)
> +{
> +       switch (chan)  {
> +       #ifdef XPAR_XUL_UART_0_BASEADDR
> +               case 0:
> +                       return XPAR_XUL_UART_0_BASEADDR;
> +       #endif
> +       #ifdef XPAR_XUL_UART_1_BASEADDR
> +               case 1:
> +                       return XPAR_XUL_UART_1_BASEADDR;
> +       #endif
> +       #ifdef XPAR_XUL_UART_2_BASEADDR
> +               case 2:
> +                       return XPAR_XUL_UART_2_BASEADDR;
> +       #endif
> +       #ifdef XPAR_XUL_UART_3_BASEADDR
> +               case 3:
> +                       return XPAR_XUL_UART_3_BASEADDR;
> +       #endif
>
> This doesn't help much as you don't use the com_port argument in the
> other functions.
>

True, it's utterly useless. I was planning on having an array with
base addresses which would be used to support the com_port argument.
But it didn't make it in this patch although I have version that does
this now.

> Where did you get the XPAR_XUL_UART_ defines from? Our xparameters.h
> seem to contain XPAR_UARTLITE_ defines instead.
>

I think that name is picked up from the name of the device in your
design, the defines get names XPAR_NNN_ and mine are called XUL_UART.

> @@ -131,12 +115,16 @@
>         struct uart_port *port = (struct uart_port *)dev_id;
>         int busy;
>
> +       spin_lock(&port->lock); /* Lock the port in case of printk */
> +
>
> In an interrupt handler? Why? The console_write does a spin_lock_irqsave.
>

Sorry, my mistake. It's not needed.

>  static int __init ulite_console_setup(struct console *co, char *options)
>  {
> +       int i, ret;
>         struct uart_port *port;
> -
> +       struct platform_device *pdev;
> +
>         if (co->index < 0 || co->index >= ULITE_NR_UARTS)
>                 return -EINVAL;
>
>         port = &ports[co->index];
>
>         /* not initialized yet? */
> -       if (!port->membase)
> -               return -ENODEV;
> +       if (!port->membase) {
> +               /* We might be early console */
>
> Is this really necessary? The platform probe get's called quite early, E.G.:
>
> Breakpoint 2, ulite_probe (pdev=0xc01c84d0) at drivers/serial/uartlite.c:392
> 392     {
> (gdb) print __log_buf
> $1 = "<5>Linux version 2.6.19-rc3 (peko@sleipner) (gcc version 3.4.5) #19 Fri Oct 27 16:39:00 CEST 2006\n<6>Barco ThinLite (V2P) <peter.korsgaard@barco.com>\n<7>Entering add_active_range(0, 0, 15360) 0 entrie"...
>
> You can always use the ppc_md.progress() stuff for really early
> debugging if needed. I would prefer to keep this workaround out of
> uartlite.c if it isn't needed.
>

I am pretty certain probe won't get called until ppc_sys_init has been
called which is fairly far into the booting process and even if it did
the platform_bus hasn't been initialized before the ppc_sys_init is
called, at least not with any of the devices exported by
ppc_sys_devices.

Thanks for the review!
David


> --
> Bye, Peter Korsgaard
>

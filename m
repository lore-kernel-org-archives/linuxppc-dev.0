Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E21E567D03
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 16:37:21 +1000 (EST)
Message-ID: <4542CE8A.9030904@dlasys.net>
Date: Fri, 27 Oct 2006 23:29:14 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	<87lknadbbl.fsf@sleipner.barco.com>
	<877iylreca.fsf@sleipner.barco.com>
In-Reply-To: <877iylreca.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Peter Korsgaard wrote:
>
>  static int __init ulite_console_setup(struct console *co, char *options)
>  {
> +	int i, ret;
>  	struct uart_port *port;
> -
> +	struct platform_device *pdev;
> +	
>  	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
>  		return -EINVAL;
>
>  	port = &ports[co->index];
>
>  	/* not initialized yet? */
> -	if (!port->membase)
> -		return -ENODEV;
> +	if (!port->membase) {
> +		/* We might be early console */
>
> Is this really necessary? The platform probe get's called quite early, E.G.:
>
> Breakpoint 2, ulite_probe (pdev=0xc01c84d0) at drivers/serial/uartlite.c:392
    There is a substantial time/code difference between the time  
ulite_console_setup() is called and the time the platform device is 
initiallized.
    If you are actually doing board bringup, you want output as soon as 
you can get it and you do not want to have to stuff calls to 
ppc_md.progress() to do so.

    Regardless, I think this is an issue of style and personal preference.
   
> 392     {
> (gdb) print __log_buf 
> $1 = "<5>Linux version 2.6.19-rc3 (peko@sleipner) (gcc version 3.4.5) #19 Fri Oct 27 16:39:00 CEST 2006\n<6>Barco ThinLite (V2P) <peter.korsgaard@barco.com>\n<7>Entering add_active_range(0, 0, 15360) 0 entrie"...
>
> You can always use the ppc_md.progress() stuff for really early
> debugging if needed. I would prefer to keep this workaround out of
> uartlite.c if it isn't needed.
>
>   
   
    
   I will absolutely agree that trying to resolve the the 
dissimilarities between the console_setup() call and the platform device 
init  is ugly.
    But I would have changed the platform device init code to use 
the uart_port structure in the platform device data as all the other 
drivers that have early console support do.

    At some point I suspect a cleaner more structured approach to 
modularizing the relationship between  early serial code and serial 
drivers will force this issue one way or another.

    But for now, if you are not going to bother making console_settup() 
work you might as well not put the rest of the early serial code in at all.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

Date: Tue, 10 Jun 2003 17:27:43 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030610152743.GW9379@pengutronix.de>
References: <20030610141047.GU9379@pengutronix.de> <20030610143911.C3835C5FD7@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20030610143911.C3835C5FD7@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 10, 2003 at 04:39:06PM +0200, Wolfgang Denk wrote:
> Do user space program like init really don;t run,  or  is  there  any
> chance that you just might see no output?

I'm not sure...

> * Check your adaptions of the kernel source and your kernel  configu-
>   ration is you really have a working serial console port.

I suppose yes - printk() works just fine and I see the complete kernel
output on the serial line.

> * If booting over NFS realy works, you can try to start a (statically
>   linked small test program) that does something else but a printf to
>   the console. For example, open  a  file  in  /tmp  for  output  and
>   frpintf to that file.

Tried - does not work. Even when I end the init program with return 0; I
would expect the kernel panic which does not come. the fprintf() should
also trigger sys_write() being called which does not happen. This all
lets me assume that the code of the init process is not really run.

The strange thing is that there is also no error message. I would
normally expect that when some mapping is broken the kernel would just
blow up with all kinds of uggly noise. When I output which task is
currently being scheduled init runs more or less all the time, only
interrupted by the kernel daemons. I see no idle task.

> You wrote "opening the console works" - set a breakpoint, and  verify
> that your console driver is really initialized and used.

Well, as I can use printk() from kernel space, shouldn't the driver
work? But nevertheless, I've hooked a printk() into
drivers/char/serial.c:rs_open() and I get the output.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

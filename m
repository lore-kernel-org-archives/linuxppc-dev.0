Message-ID: <3901D09B.4B25722F@pop.agri.ch>
Date: Sat, 22 Apr 2000 18:17:37 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>
CC: Bernhard Reiter <bernhard@intevation.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
References: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE>
Content-Type: multipart/mixed;
 boundary="------------05198446686FF5B1FDD4ABC4"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------05198446686FF5B1FDD4ABC4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Bernhard Reiter wrote:
>
> There is a difference in modem device behaviour
> between 2.2.15pre3(coming with LinuxPPC2000) and 2.2.15pre19(after
> Paul M's stable tree, build myself using his .config).
>
Depends on how you got the 2.2.15p19, I had some difficulties due to the
fact that I was too fast. Paul did a backport of ppp-2.4.x to 2.2.x and
I rsynced it with the auvz --delete option; In the wrong moment!!!. But
it wasn't meant for 2.2.x.

So only a clean download helped me. (not all the stuff, only with the -u
disabled (update == looks for date))

Now I can report a clean, more or less, well ppp operation.


> wvdail cannot open /dev/ttyS0 twice with 2.2.51pre19.
> After I ctrl-ced wvdial to interrupt the network connection
> I get an I/O error when I try to open it again.

Do you have the module option in char/devices/serial on? (dumb serial device)
If so, it can tend to a machine check, when you load a module. The patch
below will/could help you maybe. I never got as far to include it into
the kernel stuff....(Paul/Ben?)

>
> Running wvdialconf it started scanning ttyS1 and
> then jumped into the system monitor:

Don't know about a lombard, but a wallstreet has 4 tty's 0,1,2,3
(serial/printer =0, IRDA =1, modem =2; which is not present in my case;
third = 3, the third is unused, I think the lombard has only one SCC so
you can change the SERIAL_DEV_OFFSET to 2 iso 4.
>
> vector:200 at pc=d0849344 msr=1030, sp=c7bf3ce0 [c7bf3ce0]
> current=c7bf2000, pid 745 comm=insmod
>
> Maybe that is an irport error and unrelated to the first problem.
> I have not enquired further, though.

So as for trial and error I'd suggest to disable some serial modules.


> Regards,
>         Bernhard
> ps: Please carbon copy relevant replies to me.

CC? or reply?

Regards,

these are my to RP. (chf exchange.....)

Andreas
--------------05198446686FF5B1FDD4ABC4
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="522A6368";
 name="cb-serial.patch"
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="cb-serial.patch"
Content-Transfer-Encoding: 7bit

--- linux-pmac-stable/drivers/char/serial.c	Tue Feb  8 00:46:49 2000
+++ linux/drivers/char/serial.c	Mon Feb 14 18:35:47 2000
@@ -150,6 +150,12 @@
 #include <asm/bitops.h>
 #include <asm/serial.h>

+#ifdef CONFIG_MAC_SERIAL
+#define SERIAL_DEV_OFFSET	4
+#else
+#define SERIAL_DEV_OFFSET	0
+#endif
+
 #ifdef SERIAL_INLINE
 #define _INLINE_ inline
 #endif
@@ -3126,7 +3132,7 @@
 	serial_driver.driver_name = "serial";
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
-	serial_driver.minor_start = 64;
+	serial_driver.minor_start = 64 + SERIAL_DEV_OFFSET;
 	serial_driver.num = NR_PORTS;
 	serial_driver.type = TTY_DRIVER_TYPE_SERIAL;
 	serial_driver.subtype = SERIAL_TYPE_NORMAL;
@@ -3190,11 +3196,14 @@
 		state->icount.frame = state->icount.parity = 0;
 		state->icount.overrun = state->icount.brk = 0;
 		state->irq = irq_cannonicalize(state->irq);
+#ifndef CONFIG_PMAC	/* XXX */
 		if (check_region(state->port,8))
 			continue;
 		if (state->flags & ASYNC_BOOT_AUTOCONF)
 			autoconfig(state);
+#endif
 	}
+#ifndef CONFIG_PMAC	/* XXX */
 	/*
 	 * Detect the IRQ only once every port is initialised,
 	 * because some 16450 do not reset to 0 the MCR register.
@@ -3212,6 +3221,7 @@
 		       state->port, state->irq,
 		       uart_config[state->type].name);
 	}
+#endif
 	return 0;
 }

@@ -3264,22 +3274,22 @@
 		state->irq = detect_uart_irq(state);

 	printk(KERN_INFO "tty%02d at 0x%04x (irq = %d) is a %s\n",
-	       state->line, state->port, state->irq,
+	       state->line + SERIAL_DEV_OFFSET, state->port, state->irq,
 	       uart_config[state->type].name);
-	return state->line;
+	return state->line + SERIAL_DEV_OFFSET;
 }

 void unregister_serial(int line)
 {
 	unsigned long flags;
-	struct serial_state *state = &rs_table[line];
+	struct serial_state *state = &rs_table[line + SERIAL_DEV_OFFSET];

 	save_flags(flags);
 	cli();
 	if (state->info && state->info->tty)
 		tty_hangup(state->info->tty);
 	state->type = PORT_UNKNOWN;
-	printk(KERN_INFO "tty%02d unloaded\n", state->line);
+	printk(KERN_INFO "tty%02d unloaded\n", state->line + SERIAL_DEV_OFFSET);
 	restore_flags(flags);
 }


--------------05198446686FF5B1FDD4ABC4--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

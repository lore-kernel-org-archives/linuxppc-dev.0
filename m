To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: insmod trouble 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 May 2004 11:05:11 +0200."
             <200405251105.11689.Schramel.Linux@go.bartec.de>
Date: Tue, 25 May 2004 11:55:49 +0200
Message-Id: <20040525095554.A5EC4C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200405251105.11689.Schramel.Linux@go.bartec.de> you wrote:
>
> My MPC8270 system works with 2.4.26 (toolchain ELDK), for development i use NFS (opt/eldk/ppc_82xx as rootfs). Now i write  a device driver and have some trouble.
> I ve searched the whole list, but i didn't found some helpfully comments.
>
> --------------------------------------------------
> bash-2.05b# insmod demodriver.o
> demodriver.o: unresolved symbol module_unregister_chrdev
> demodriver.o: unresolved symbol register_chrdev
> demodriver.o: unresolved symbol led_init
> demodriver.o: unresolved symbol printf
> demodriver.o: unresolved symbol printk
> ------------------------------------------------
>
> What is the reason for this messages ??

The reason is bugs in your driver code.

module_unregister_chrdev - there is no such function in the Linux kernel.
	Do you mean unregister_chrdev() or devfs_unregister_chrdev()?

led_init - there is no such exported kernel  symbol.  Which  function
        are you trying to call? Is this something in your own driver?

printk - there is no such function in the Linux kernel. Did you  mean
        printk() instead?

register_chrdev, printk - I can only speculate.  These  are  exported
        kernel  symbols.  probably you compile the driver with bad or
        incomplete compiler options?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Horses just naturally have mohawk haircuts.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

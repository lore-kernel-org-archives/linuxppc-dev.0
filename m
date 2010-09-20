Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BDC6B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Sep 2010 17:18:54 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8K7Im3f025211
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 09:18:49 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Initial kernel command string (Was: Generating elf kernel ?)
Date: Mon, 20 Sep 2010 09:21:09 +0200
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<201009171127.51017.dargaud@lpsc.in2p3.fr>
	<4C9338F3.2010104@windriver.com>
In-Reply-To: <4C9338F3.2010104@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009200921.09800.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I think you should modify the bootargs on your dts.
> ------
>         chosen {
>                 bootargs = "console=ttyS0 root=/dev/ram";
>                 linux,stdout-path = "/plb@0/serial@83e00000";
>         } ;

Thanks, that worked great, I now have a fully bootable not only kernel, but 
full OS as well.

> > Also my previous kernel would wait for 2 seconds at the beginning to
> > allow me to change the initial command string via the serial port, but
> > now it just runs right through. How can I enable this option ?
> 
> It's possible on PowerPC kernel :)
> 
> You can take a look at the file, arch/powerpc/boot/main.c.
> ------
> static void prep_cmdline(void *chosen)
> {
>         if (cmdline[0] == '\0')
>                 getprop(chosen, "bootargs", cmdline, COMMAND_LINE_SIZE-1);
> 
>         printf("\n\rLinux/PowerPC load: %s", cmdline);
>         /* If possible, edit the command line */
>         if (console_ops.edit_cmdline)
>                 console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
>         printf("\n\r");
> .......
> 
> 
> So you have to define one function, console_ops.edit_cmdline -->
> serial_edit_cmdline. Or you can try bind this to your boot console ops
> directly. Please refer to the file, arch/powerpc/boot/serial.c.

So I forced
 		console_ops.edit_cmdline = serial_edit_cmdline;
in serial.c, bu that didn't do the trick...
-- 
Guillaume Dargaud
http://www.gdargaud.net/

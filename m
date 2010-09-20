Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 40B84B70D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Sep 2010 18:09:29 +1000 (EST)
Message-ID: <4C971712.2020901@windriver.com>
Date: Mon, 20 Sep 2010 16:10:58 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Initial kernel command string (Was: Generating elf kernel ?)
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<201009171127.51017.dargaud@lpsc.in2p3.fr>	<4C9338F3.2010104@windriver.com>
	<201009200921.09800.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201009200921.09800.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud wrote:
>> I think you should modify the bootargs on your dts.
>> ------
>>         chosen {
>>                 bootargs = "console=ttyS0 root=/dev/ram";
>>                 linux,stdout-path = "/plb@0/serial@83e00000";
>>         } ;
> 
> Thanks, that worked great, I now have a fully bootable not only kernel, but 
> full OS as well.

Sounds good :)

> 
>>> Also my previous kernel would wait for 2 seconds at the beginning to
>>> allow me to change the initial command string via the serial port, but
>>> now it just runs right through. How can I enable this option ?
>> It's possible on PowerPC kernel :)
>>
>> You can take a look at the file, arch/powerpc/boot/main.c.
>> ------
>> static void prep_cmdline(void *chosen)
>> {
>>         if (cmdline[0] == '\0')
>>                 getprop(chosen, "bootargs", cmdline, COMMAND_LINE_SIZE-1);
>>
>>         printf("\n\rLinux/PowerPC load: %s", cmdline);
>>         /* If possible, edit the command line */
>>         if (console_ops.edit_cmdline)
>>                 console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
>>         printf("\n\r");
>> .......
>>
>>
>> So you have to define one function, console_ops.edit_cmdline -->
>> serial_edit_cmdline. Or you can try bind this to your boot console ops
>> directly. Please refer to the file, arch/powerpc/boot/serial.c.
> 
> So I forced
>  		console_ops.edit_cmdline = serial_edit_cmdline;
> in serial.c, bu that didn't do the trick...

Where are/how do your way implement? Can you paste your code sections here?

If I remember ML405 properly the serial port should be compliant to ns16550. So
I think the sub-functions, putc()/getc()/tstc(), should be from the file,
arch/powerpc/boot/ns16550.c. If so it's fine.

Maybe you can add some extra printf() into the function, serial_edit_cmdline, to
track this in detail.

Cheers
Tiejun

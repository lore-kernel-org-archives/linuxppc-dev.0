Return-Path: <ksraghavan@yahoo.com>
Received: from web51001.mail.yahoo.com (web51001.mail.yahoo.com
	[206.190.38.132]) by ozlabs.org (Postfix) with SMTP id 9B74467A7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 06:15:25 +1100 (EST)
Message-ID: <20050128184558.8006.qmail@web51001.mail.yahoo.com>
Date: Fri, 28 Jan 2005 10:45:58 -0800 (PST)
From: Srinivasa Kanduru <ksraghavan@yahoo.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050128030429.70F0267ABB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Linuxppc-embedded Digest, Vol 5, Issue 52
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,

I wouldn't suspect the serial driver because it printed 3 characters correctly.
It might be better to look at where the kernel is being loaded. I guess somehow
the image is getting corrupted. Maybe you could move it farther away.

Regards,
Srini.

> ATTACHMENT part 3.2 message/rfc822 
> From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
> To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
> 	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
> Date: Thu, 27 Jan 2005 21:07:26 -0500
> Subject: console_init() question 
> 
> > Hi,
> > 
> I am struggling with bringing up the MPC 880 board on Linux 2.6-10.rc3 ...
> I could see that only 3 characters (see below) from the linux_banner are
> printed
> in __init start_kernel() (init/main.c) upon booting.
> Then a lot of garbage is outputted and eventually kernel hangs ...
> ...
> after gunzip
> done.
> Now booting the kernel
> LinÿÿÿÿÿÿÿÿÀÿÿÿÿÿÿÿÿÀ8ÀÿÿÿÿÿÿÿÿÀXÀÿÿÿÿÿÿÿÿÀxÀÿÿÿÿÿÿÿÿÀ~ÀÿÿÿÿÿÿÿÿÀ¸ÀÿÿÿÿÿÿÿÿÀ
> ØÀÿÿ
> <more garbage>
> <hangs> ... 
> ...
> 
> Very laborious debugging (without BDM and soft reset button - but with great
> help) shows that the hang is caused by the console
> serial driver at about (or just soon after) 
> 
>     console_drivers = console;
> 
>  statement in
> 
>  register_console(struct console * console)
> 
> function (in kernel/printk.c ) 
>  
> I can not find (so far ) any specific error in values supplied vi bd_info
> from the ("custom" modified pSOS bootloader) causing above problem.
> >  
> The debug output showing my serial settings was saved into log buffer and
> read at "bootloader time" after 
> "software stimulated" "soft reboot" - it is listed here.
> Could someone kindly spare 5 min examining supplied debug output  from  both
> cpm_uart_set_termios()
> > (in drivers/serial/cpm_uart/cpm_uart_core.c)  and cpm_setbrg() (in
> > arch/ppc/8xx_io/commproc.c) and tell
> me what is wrong there   ?
> > The output is supplied at the end of my e-mail after the listings of
> > functions (with my print statements)
> > 
> > Thanks,
> > Alex
> > 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250

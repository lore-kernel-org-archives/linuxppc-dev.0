To: "hu" <hl76@263.net>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Oops:kernel access of bad areasig:11 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Jul 2004 13:33:47 +0800."
             <20040714053136.86F102F86F@smtp.263.net>
Date: Wed, 14 Jul 2004 21:41:28 +0200
Message-Id: <20040714194134.1409CC109F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20040714053136.86F102F86F@smtp.263.net> you wrote:
>
> 1)environment
> Linux kernel 2.4.4-rthal5
> ppcboot 1.1.5
> MPC823 board

Ummm... this is all a bit out of date...

> 2)I'm running a device driver which read data from touchpanel which use SIU_IRQ2, but I often get message like that:
> Oops: kernel access of bad area, sig: 11
...
> Call backtrace:
>   C000C468 C002B440 C0004DA8

OK - and will you please bother to decode these addresses for us?  We
don't have access to your System.map file ...

> 3) I look through past document in linux-embedded, and I check /arch/ppc/kernel/m8xx_setup.c, it exists:
> fp = binfo->bi_intfreq * 1000000 / 16;
> and /arch/ppc/8xx_io/commproc.c, it exits:
> #define BRG_INT_CLK	(((bd_t *)__res)->bi_intfreq * 1000000 )

OK.  Or:
	brg = (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);

What exactly is your problem with that? Looks  OK  to  me.  Different
purposes, different context, different solutions.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
For every complex problem, there is a solution that is simple,  neat,
and wrong.                                           -- H. L. Mencken

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: bart@ardistech.com
Cc: govindan@india.tejasnetworks.com, svacca@valcom.com,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	govindan@tejasnetworks.com
Subject: Re: Execute Reset via CheckStop approach 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Aug 2002 15:23:40 +0200."
             <3D66375C.2046CFA9@ardistech.com>
Date: Fri, 23 Aug 2002 15:36:48 +0200
Message-Id: <20020823133653.7604B11822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <3D66375C.2046CFA9@ardistech.com> you wrote:
>
> I cleared CFG_DER in ppcboot to clear the CHSTP bit. After that I needed to
> map in the br0 range and to make the asm's volatile and set the input/output

Why do you think you have to do this? This is _NOT_ necessary.

> parameters of the asm to get the HRESET_N pulse. So this is the version
> which works (on a MPC823e) in the context of the Linux kernel:
>
>         /* Get base address mapped by BR0/OR0 and map it in */
>         val = ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xFFFF8000;
> 	val = (int) ioremap( retval, 0x4000 );

This code is wrong. You clobber the value of "val" here.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Defaults are wonderful, just like fire.
                  - Larry Wall in <1996Mar6.004121.27890@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

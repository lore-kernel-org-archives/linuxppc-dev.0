To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [QuestionIP_CONFIG : incomplete network configration info... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Mar 2001 10:42:00 +0900."
             <H00002af04ab19e3@MHS>
Date: Mon, 12 Mar 2001 09:26:31 +0100
Message-Id: <20010312082636.63B2B281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <H00002af04ab19e3@MHS> kingseft@samsung.co.kr wrote:
>
>  Hi all developers.

I don't think _all_ developers are interested in this.

Please send PPCBoot related messages to the PPCBoot mailing list instead.

>  IP_CONFIG: Incomplete network configuration info
>  dev_cluse: bug eth0 still running....

That means you are passing incomplete network  configuration  to  the
kernel.

> #define CONFIG_BOOTCOMMAND							\
> "bootp ;" 									\
> "setenv bootargs console=tty0 console=ttyS0 " 					\
> "root=/dev/nfs nfsroot=$(serverip):$(rootpath) " 				\
> "ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):eth0:off ;" 	\
> "bootm"

When the kernel starts, it prints a  line  with  the  boot  arguments
which  were  passed  to  it.  There  must be some parameters missing;
probably the "rootpath" environment variable is not set.

>  I think CONFIG_BOOTCOMMAND is imcomplte.

No, it it OK. But your BOOTP server configuration in probably incomplete.

>  Could someone describe how to use this BOOTCOMMAND for booting with ramdisk
>  any comments will help me.. thanks.

Now when you want to boot with a ramdisk, you definitely DO NOT  want
to  pass  "root=/dev/nfs  nfsroot=$(serverip):$(rootpath)" as part of
the boot arguments!

Try "root=/dev/ram" instead!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quote from the Boss... "I didn't say it was your fault.  I said I was
going to blame it on you."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Access u-boot environment variables from Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 13 Jul 2003 17:38:55 +0200."
             <75DF04AC5ED4D511A9810090273CB4163F5DDD@rokonet-e.rokonet.co.il>
Date: Mon, 14 Jul 2003 00:04:35 +0200
Message-Id: <20030713220440.AA7A0C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163F5DDD@rokonet-e.rokonet.co.il> you wrote:
>
> I have configure the config.mk.TQM860L_FEC file with: HAVE_FLASH_ENV = yes.

I thinkthis file is referring to a _very_ old version  of  the  Linux
kernel.  You'd  better use the Linux kernel and the SELF package that
comes included with the ELDK, or use the top of our CVS tree.

> modprobe: modprobe: Can't locate module char-major-60
> /dev/flasha: No such device
>
> I can see all /dev/flasha and others.
>
> The kernel is the default TQM860L_FEC  from the ELDK (not from SELF, but
> should be the same).

Grrrgh...

Your description gives no indication of what you're trying to do, and
what you're doing. Please note, that you have  two  options  for  the
flash  driver:  the  old,  non-standard  character  device  interface
[/dev/flash*] (which is there just for  backward  compatibility  with
some  existing projects, and because it supports a mmap() interface),
or   you   can   use   the   standard   MTD   interface   [/dev/mtd*,
/dev/mtdblock*].

>From your description I think you want to use the MTD interface.

The  MTD  interface  is  also  what  is  being   used   the   default
configurations of our current kernel trees.

If I guess right, you want to access /dev/mtd*, not /dev/flash*


Also, judging from the subject of your posting, you  should  probably
read the "tools/env/README" file in the U-Boot source tree.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A wise person makes his  own  decisions,  a  weak  one  obeys  public
opinion.                                           -- Chinese proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: hjzgq@sohu.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Change FEC and SCC1 sequence,But SCC1 not work? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 14:22:18 +0800."
             <116411.1086934938680.JavaMail.postfix@mx27.mail.sohu.com>
Date: Fri, 11 Jun 2004 18:02:29 +0200
Message-Id: <20040611160234.6A75BC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <116411.1086934938680.JavaMail.postfix@mx27.mail.sohu.com> you wrote:
>
>        My bootargs is "setenv bootargs root=/dev/ram ip=10.32.5.17:10.32.5.15::255.255.0.0:bug
> :::off"
>        Today,I found fec device down when linux kernel running ,but I can see "eth1(fec ethernet)"  status with "ifconfig" command,I checked linux kernel and found fec device down when kernel running.
>
>        After debugging,I found linux kernel close the device when  running "ip_auto_config()" function  in "net/ipv4/ipconfig.c",then, I deleted "ic_open_devs()" funtions, AND EVERYING
> WORKS WELL!

But you are removing perfectly valid code. Don't do this!!

Just read the  documentation  (especially  Documentation/nfsroot.txt)
and pass the CORRECT boot arguments, which in case or several network
interfaces  MUST  specify  which  interface  to  configure, i. e. the
minimum information is then

	... ip=10.32.5.17:10.32.5.15::255.255.0.0:bug:eth0:off

[Note that your "ip=" string has one colon too many, too.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Software suppliers are trying to make their  software  packages  more
``user-friendly''.  .  .  .  Their best approach, so far, has been to
take all the old brochures, and stamp the words, ``user-friendly'' on
the cover.                                               - Bill Gates

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

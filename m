Message-Id: <200101060910.f069AqI01072@denx.local.net>
To: Micael balow <micaelbalow@yahoo.com.cn>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot Questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 06 Jan 2001 10:20:01 +0800."
             <20010106022001.34890.qmail@web11704.mail.yahoo.com>
Date: Sat, 06 Jan 2001 10:10:52 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Micael,

in message <20010106022001.34890.qmail@web11704.mail.yahoo.com> you wrote:
>
>       I'd like to ask you the following questions.

Why? You've asked the very same questions 4 days ago on  the  PPCBoot
mailing list, and I replied to you and the list.

> version to complie a kernel. When I used Redhat 6.0
> and 6.1 Linux to make ppcboot.0.4.4-pre1,I got the
> following error mesages:
>
> >      Makefile:24:***unterminated call to >function
> 'shell' : missing '('. stop.

The Makefile in that old version of PPCBoot used  a  shell  construct
which  was  only  available in bash version 2.x, while RH 6.0 and 6.1
use an older version of bash. The Makefile has been fixed since,  and
works in RH-6.0 and 6.1, too.

>      But when I use Redhat 6.2 Linux to make
> ppcboot.0.4.4-pre1,the message is something like the
> following:
>
> >Make[1]:Entering directory '/ppcboot/ppc'
> >Make[1]:'.depend' is up to date.
>             ...
> >Make[1]:Entering directory '/ppcboot/tools'
> >Make[1]:***No rule to make target 'crc32.c'needed >by
> '.depend'. stop.
> >Make[1]:Leaving directory '/ppcboot/tools'

It seems you are missing the symbolic link "crc32.c" in  the  "tools"
directory, which points to the C source fine in the "ppc" directory:

	-> ls -l tools/crc32.c
	lrwxrwxrwx    1 wd       users          14 Nov 16 09:58 tools/crc32.c -> ../ppc/crc32.c

>      I do not  know the reason that I got so much
> error messages.Did I use the wrong Linux version? Did
> I use the wrong Bash version? How can I make changes
> to let it run well.

Well, yes, PPCBoot 0.4.x is AWFULLY old; you'd be better off  with  a
more current version.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Machines take me by surprise with great frequency.      - Alan Turing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

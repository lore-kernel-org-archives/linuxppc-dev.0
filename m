To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: not enough memory for SELF!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Mar 2002 12:56:24 +0100."
             <3C95D5E8.1C6989DD@imc-berlin.de>
Date: Mon, 18 Mar 2002 13:54:13 +0100
Message-Id: <20020318125418.7C3E1109F1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C95D5E8.1C6989DD@imc-berlin.de> you wrote:
>
> I started playing around with Wolfgang's SELF and busybox.
>
> For now I have only 8MB RAM.

Add more :-)

> When I try to telnet into my board I get
>
> / # Out of Memory: Killed process 13 (sh).
> Out of Memory: Killed process 1 (init).
> The system is going down NOW !!
>
> I am using Linux-2.4.4-2002-02-14 from ftp.denx.de with TQM860L_config.
>
> What can I do?

There are several options:

* Add more RAM (which is obviously the  simplest  solution  from  the
  perspective of a software developer)

* Reduce the size of the ramdisk - it defualts to  4  MB,  but  AFAIR
  only about 2.5 MB are used

* Don't use a ramdisk at all, but instead put  your  root  filesystem
  into a cramfs or JFFS2 filesystem

* Optimize the kernel  configuration  by  throwing  out  drivers  and
  filesystems  you  don't  need; the default configurations is _very_
  generic (with NFS, ext2, cramfs, JFFS, JFFS2, msdos filesystems).

Hope it helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If this is a service economy, why is the service so bad?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <02ff01c1af48$dbb40a00$0900a8c0@Domain.invalid>
From: "murali nagarajan" <muralin@gdatech.com>
To: <linuxppc-dev@lists.linuxppc.org>
References: <028801c1aea2$610d96a0$0900a8c0@Domain.invalid><Pine.LNX.3.96.1020205163126.16943I-100000@gatwood.net> <15456.32984.74998.373361@igor.jsc.nasa.gov>
Subject: Re: Problem with ping/telnet
Date: Wed, 6 Feb 2002 11:59:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have received many responses and here I am responding with what I have
tried so far and some more info to solve this issue.

Consolidated answeres to many questions raised in the responses:
- The File system has the glibc resolver libraries, all of those mentioned
in the "man pages of nsswitch.conf". All those /lib/libnss_files and the
symbolic links are verified correctly.
- The nsswitch.conf has entries for all important service switches including
protocols and services.
- For the name resolution in the "hosts" entry of nsswitch.conf, "files" is
given the precedence. The settings in the /etc/hosts are ok.
- PLEASE note that the NFS file system in use has been successfully used
with an evaluation board where I could run all network related programs
incl. ping & telnet. I have made no changes to the file system.

****One significant difference between the eval. board and the curent one is
that I DO NOT run /sbin/init when the kernel boots and therby preventing the
boot scripts execution. I run the /bin/sh directly. (Inittab was set to 3
and then 1 without any differnce)

Another observation:
--------------------
I have run set of boot scripts from the bash, but it looks like either they
are insufficient or not done correctly. This is because when I try to
perform a insmod of a very simple skeleton driver, I get "unresolved
symbols - even for printk". But I do have a ksyms file under /proc. Probably
the acess to these files is somehow not taking place. (The kernel has
loadable Module support enabled!)

My questions:
- Is there any simple script file that I can run when I do not boot the
system via /sbin/init.
- What are all the necessary steps that needs to be performed if we have to
replace the /sbin/init boot process.
- PING not being able to read /etc/processes and TELNET not being able to
read the /etc/services and INSMOD failing due to unresolved symbols :
Anything in common?

Thanks to all who have responded.

With best regards,
Murali

----- Original Message -----
From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
To: "David A. Gatwood" <dgatwood@gatwood.net>
Cc: "murali nagarajan" <muralin@gdatech.com>;
<linuxppc-dev@lists.linuxppc.org>
Sent: Tuesday, February 05, 2002 5:03 PM
Subject: Re: Problem with ping/telnet


> David A. Gatwood writes:
>  >
>  > On Tue, 5 Feb 2002, murali nagarajan wrote:
>  >
>  > > With your info, I am able to do a telnet from my board to the host,
only if
>  > > I specify the port number. What surprises me is that the presence of
both
>  > > /etc/services (entry to telnet is available with a port number) and
the
>  > > /etc/protocols files. For some reason, may be the boot process is
unable to
>  > > read these information.  But when I want to do a telnet to my board
from my
>  > > host iMAc, I am unable to do. I get an error message "connection
refused".
>  >
>  > This sounds vaguely familiar like I've run into it before, but I can't
>  > remember where.
>  >
>  > The boot process doesn't read /etc/services.  That's read on-the-fly by
>  > the telnet program itself with calls to either getservbyname or
>  > getservent, which are standard C library calls, and should always work
if
>  > the service is listed and the files (and directory) are readable by the
>  > user that telnet is being run as.
>
> It sounds like you might be missing some of the glibc resolver
> libraries that allow programs to access the various databases (i.e.,
> things like /etc/services and /etc/protocols.)  In particular, I think
> you might be missing the /lib/libnss_files.so.  There is a discussion
> of this somewhere in the glibc info pages as I recall.  Also, your
> /etc/nsswitch.conf file is important for determining which source of
> information takes precedence (for instance, in the case of name
> resolution, do you use /ect/hosts first or a domain name server
> first).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hung inside execve 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Dec 2002 12:10:15 PST."
             <B0CD235912AED411B69800D0B7C9F60F1DF8A7@mail>
Date: Mon, 09 Dec 2002 21:55:37 +0100
Message-Id: <20021209205542.59FB4C63F0@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Francis,

in message <B0CD235912AED411B69800D0B7C9F60F1DF8A7@mail> you wrote:
>
> Thanks a lot for your reply and hints. I finally got the OK to purchase a
> BDI2000. While I am waiting for its arrival, I want to spend more time
> looking into my problem of hanging right after the line "execve /bin/sh". My
> question is: Is it normal to get the return value 0xfffffffe from the
> functions "execve /sbin/init", "execve /etc/init", and 'execve /bin/init",
> while the line "execve /bin/sh" returns zero? I am using the

Check your root filesystem.

Which of the files "/bin/sh", "/sbin/init", "/etc/init" and "/bin/init"
do exist, and which don't?

> mini-2048kB-ramdiskimage.gz downloaded from DENX.

In this filesystem only "/bin/sh" exists, while the ohers don't. This
explains the exit codes.

> Should I spend the time in studying how to build my own ramdisk? Thanks.

I have put a set of more complete ramdisk images (based on  the  SELF
RPM  from our ELDK 2.0 distribution) for download from or FTP server;
see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/

But there is nothing wrong with the mini-2048kB-ramdiskimage.gz  file
- it still works fine here.

I think you should try to boot the system with root  filesystem  over
NFS  instead - it is much easier to debug (use a network sniffer like
ethereal to check the traffic on the wire).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Business is like a wheelbarrow. Nothing ever happens until you  start
pushing.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: zjzhou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to change /proc to the writable directory 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Nov 2003 12:30:43 +0800."
             <000001c3b568$639e70a0$b702a8c0@newrock2>
Date: Fri, 28 Nov 2003 09:12:50 +0100
Message-Id: <20031128081255.B9AADC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000001c3b568$639e70a0$b702a8c0@newrock2> you wrote:
>
> when I boot kernel and mount file system( cramfs and JFFS), for default, the dir /proc is not writable that located in cramfs. Now, I want to change it to be writable. which places/functions should I modify?

/proc it it's own pseudo-filesystem. You don;t include this  in  your
filesystem image, but rather mount it.

> In cramfs I have these dirs:
> /bin
> /root
> /boot
> /sbin
> /usr
> /mnt
> /dev/ --> /mnt/rwfs/dev
> /proc --> /mnt/rwfs/proc

Make /proc a plain directroy,  and  as  part  of  your  init  scripts
execute something like "/bin/mount -t proc proc /proc"


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

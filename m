To: "Kamalesh B" <kamal@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Feb 2003 11:01:51 +0530."
             <3E5EF447.3B9088D7@tataelxsi.co.in>
Date: Fri, 28 Feb 2003 22:29:15 +0100
Message-Id: <20030228212920.BE988C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E5EF447.3B9088D7@tataelxsi.co.in> you wrote:
>
> Command line argument for linux given is
> root=/dev/nfs    nfsaddrs=<targetip>:<serverip>
>
> My query is
> 1. How to boot linux-2.4.1 using root file system rather than using
> network file system?

You always use a "root filesystem". With your  option,  you  mount  a
filesystem exported by your NFS server as root filesystem.

I guess you want to mount a ramdisk as rootfilesystem. To do so, make
sure your "bootargs" variable contains the string "root=/dev/ram"

> 2. How to make ramdisk(root fs) part of linux kernel? DO i need to
> change some makefiles or config options?

Why would you want to make it part  of  the  kernel?  This  makes  no
sense.  If  you  mean how to combine the ramdisk image and the kernel
image into one image file,  then  please  see  the  multi-file  image
format of the "mkimage" tol that comes with PPCBoot.

> 3. How to remove dependency of nfs to boot-up LINUX i.e, OS image should
> boot in standalone setup?

Just do not use "root=/dev/nfs" in your "bootargs" settings.


Maybe you can get some more detailed help from reading the docs, like
http://www.denx.de/re/DPLG.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Without freedom of choice there is no creativity.
	-- Kirk, "The return of the Archons", stardate 3157.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

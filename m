Message-Id: <200005290756.JAA27458@denx.local.net>
To: "SangTae Ha" <stha@postech.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do you have your minimum ramdisk image which can provide basic network services ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 May 2000 16:27:37 +0900."
             <020e01bfc93f$5dc075c0$db52df8d@helsinki>
Date: Mon, 29 May 2000 09:56:13 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <020e01bfc93f$5dc075c0$db52df8d@helsinki> you wrote:
>
> I want to make my ramdisk image which can provide basic network services such as "ping","traceroute","telnet" and "ftp". I want to reduce my file size within (1or2)M bytes. I already downloaded full image file at ftp://ftp.ppc.kernel.org/pub/linuxppc/em
> bedded/mbxroot.full.tgz

This is most probably not the best approach.

You should not start with a  full  installation  of  everything,  but
instead  start  with an empty system and design what you need to have
it it.

/bin/ping, /usr/sbin/traceroute,  /usr/bin/ftp,  and  /usr/bin/telnet
together  need  (compressed)  well below 100 kB, so if you don't need
glibc2 for any reasons you can easily fit  this  within  your  limits
(hell, in 1 MB you can have a compressed image with a full web server
including >560 kB of web pages *plus* the Linux kernel).

> This file is so big including all of things. I am currently pruning various directories and files in it. I hope that it doesn't take too much time.
> I have two choices.
> 1) compile the LRP(Linux Router Project) package and make it into root file system image
> 2) reducing file size from full image file and make final small size image

What's wrong with using one of the existing  embedded  releases,  and
building  your system from buttom up? Both the Montavista HHL release
or our CD-ROM should get you started easily (see
http://www.denx.de/solutions-en.html for a start).

> How do you think about above solutions?

I think you are on a wrong track.

> I just want to use TCP/IP networking facilities. I will really be happy if you already got that image..

What is the purpose of your embedded system?

What do you want to have FTP for, when you don't have  any  files  to
send,  or  any commands to process files you "get"? It's difficult to
make recommendations (especially for embedded systems) when you  hold
back essential information...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <C51ED84B6F47D211917A0000F8BCBD117EB4A5@zcard00g.ca.nortel.com>
From: "Michael Ward" <Michael.Ward.mkward@nt.com>
To: Jose Ferreira de Rezende <rezende@gta.ufrj.br>, list@rzuni1.fh-bingen.de
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: RE: kernel 2.1.129 in a 43P
Date: Fri, 11 Dec 1998 12:01:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jose,

 I had trouble with shutdown's on my 43P's and I knew it was related to
networking
but couldn't pinpoint it until I looked in the shutdown scripts to trace
what happened after the last visible message "Unmounting remote
filesystems".

Someone suggested that I comment out some lines in /etc/rc.d/init.d/network
so I did and it now shuts all the way down (even though the network is not
shut
down using ifdown). This doesn't seem to bother it at all as I have full
network capability
and is better for the fs than having to cycle/remove power when only halfway
down. The lines are :

# for i in $interface; do
# 	./ifdown $i boot
# done

It seems to hang when trying "ifdown ifcfg-eth0 boot" and originally it
seemed like the ifcfg-eth0 file
was not in my directory (/etc/sysconfig/network-scripts) but it is now.
Maybe someone will help chase
this down sometime, as I'm not exactly sure what is wrong but I remember the
network hanging while trying
to install the 2.0.3x kernel using the old FD_SETUP, FD_BOOT method.

I have also noticed a lot of TX errors on all my PReP machines (3 43P-100
and 1 PowerStack).
At first I double checked to make sure I was reading the right fields. I am
not having any real
network problems as I routinely telnet, FTP, and use remote X fairly well. I
have noticed that when
FTPing large files, the network usage on my shared hub goes through the roof
(>75%)[good] but the
collisions due as well [bad]. I'm not sure how I'm getting data through at
all if they are all being jammed
by the hub causing runt packets. Also, the collision counter below shows
zero, which is suspect for a shared
network.

ifconfig output
--------------------
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Bcast:127.255.255.255  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:64 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:6624 dropped:64 overruns:0 carrier:0 coll:0

eth0      Link encap:Ethernet  HWaddr 08:00:5A:FC:10:74  
          inet addr:47.27.16.8  Bcast:47.27.31.255  Mask:255.255.240.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:66098 errors:1 dropped:0 overruns:0 frame:2
          TX packets:0 errors:146595633 dropped:116495 overruns:3822
carrier:0 coll:0
          Interrupt:15 Base address:0x200

I would like to run some netperf tests between the boxes, but I am having
trouble compiling on my
43P (7248-100) with 2.1.119. I saw that Cort suggested using the older
source kernel headers (2.1.24) which I have
in my system under /usr/src/linux-2.1.24 when I installed it. Since then I
have tried a few other kernels (2.1.117,
2.1.126) for other purposes. Does anyone know how I can get the programs to
use the right kernel headers ?
Do I have to manually place them in /usr/include, or do I have to explicity
change the program source or makefile
to include the header files directly (-I/usr/src/linux-2.1.24/include or
</usr/src/linux-2.1.24/include/socket.h>)? 

I also downloaded the newest firmware (v1.11) and SMS (v1.09 I think) from
IBM and it allowed the machine
to power all the way down (including shutting off the breaker), although I
think it now always
cycles the power even when I only do a halt (shutdown -h now). But this is
better than just sitting there
with the power on. Try
http://www.ibm.rs6000.com/support/micro/download.html. (7248-1xx). Microcode
above v1.09 supports async console during initialization, which can be handy
to some.

BTW, I don't have any X server working on my 43P and I read that there was a
problem when the code
went from 2.0.xxx to 2.1.xxx that someone would have to spend some time on.
I didn't think it was possible to try and compile the XF86 stuff from Intel
arch and x86 assembler, although
I have seen lots of people trying without much success. Gabriel also replied
to this thread that
it needed some work and he had the docs but not the time, so that tells me
it needs some more expertise
than I have. I read that S3 wants direct access to device memory that newer
kernels don't allow. I' not fussy
about getting the X server to run locally as I remote X anyway. I will wait
until there is a working
version of S3 (for PReP) or maybe try the fbcon stuff if I get some time
(not likely).

Regards,
Mike

> -----Original Message-----
> From:	Jose Ferreira de Rezende [SMTP:rezende@gta.ufrj.br]
> Sent:	December 3, 1998 11:03 AM
> To:	list@rzuni1.fh-bingen.de
> Cc:	linuxppc-user@lists.linuxppc.org
> Subject:	Re: kernel 2.1.129 in a 43P
> 
> 
> >> list@rzuni1.fh-bingen.de writes:
> 
>  > On Tue, 1 Dec 1998, Jose Ferreira de Rezende wrote:
> 
>  >>  Hi,
>  >> 
>  >> I've got a 43P Machine and I'm using a 2.1.129 kernel. When I try to
>  >> compile everything that deals with the network I get the following
>  >> messages: /usr/include/linux/in.h:110: parse error before
>  >> `sa_family_t' /usr/include/linux/in.h:110: warning: no semicolon at
>  >> end of struct or union /usr/include/linux/in.h:117: parse error
>  >> before `}'
>  >> 
>  >> Is this kernel bugged? Which kernel must I use? 2.1.130?
>  >> 
>  >> Thanks, Jose
>  >> 
>  >> 
> 
>  > Hello Jose...
> 
>  > there seems to be a bug in 2.1.xxx for the networking... my 43p
>  > machine hangs if I do a normal shutdown... I don't know why... and
>  > older 2.0.xx kernels didn't work on my machine (networking
>  > problem)...
> 
>  > Is X working on your 43p???
> 
> In fact, I found where was the problem. In the include socket.h from the
> kernel there is a test like that:
> 
> #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
>                                                   ^^^^^^^^^^^^^^^
> This avoids that some includes be done. I commented out this line and
> everything compiles. There is the same line in the asm/posix_types.h.
> 
> I'm having problems as well with the shutdown. I couldn't figure out
> where is the problem. How are you shutting down your machine??
> 
> For the X, I've got the XF86_S3 server from ftp://vcorr1.iram.es/pub/XF*
> but it doesn't work with my S3 card, the display goes black after
> launching. However the X server works fine, that's I can launch X
> applications to other displays.
> 
	[snip] 

> Keep in touch, Jose
> 
> 
> 
> [[ This message was sent via the linuxppc-user mailing list. Replies are
> ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your
> ]]
> [[ reply is of general interest. To unsubscribe from linuxppc-user, send
> ]]
> [[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org
> ]]

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

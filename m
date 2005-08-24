Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 6727D67FB3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 17:30:54 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Aug 2005 10:58:14 +0800."
	<1124852294.11078.8.camel@banana>
Date: Wed, 24 Aug 2005 09:30:35 +0200
Sender: wd@denx.de
Message-Id: <20050824073035.EADF0353D32@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: An old problem ...about linux mount rootfs with nfs 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1124852294.11078.8.camel@banana> you wrote:
> 
>     I used u-boot-1.1.3 and 2.4.25 linux on my custom MPC852T board, I
> can't mount /opt/eldk/ppc_8xx as rootfs.

You pass incomplete config options to the kernel.

> Hit any key to stop autoboot:  0
> => setenv hostname banana
> => setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath) ip=
> $(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off
> => printenv
> bootcmd=bootm 40040000 40100000
> bootdelay=3
> baudrate=115200
> loads_echo=1
> ethprime=SCC ETHERNET
> ipaddr=10.0.14.110
> serverip=10.0.14.26
> netmask=255.255.0.0
> preboot=echo;
> netdev=eth0
^^^^^^^^^^^^^
> nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
> ramargs=setenv bootargs root=/dev/ram rw
> addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):
> $(netmask):$(hostname):$(netdev):off panic=1
                         ^^^^^^^^^

Here you have all the necessary prparations.

> bootargs=root=/dev/nfs rw nfsroot=10.0.14.26:/opt/eldk/ppc_8xx
> ip=10.0.14.110:10.0.14.26::255.255.0.0:banana::off
                                               ^^

But here you are missing to pass the information which ethernet interface to use.

> Kernel command line: root=/dev/nfs rw
> nfsroot=10.0.14.26:/opt/eldk/ppc_8xx
> ip=10.0.14.110:10.0.14.26::255.255.0.0:banana::off
-----------------------------------------------^^^

No interface selected.

> eth0: CPM ENET Version 0.2 on SCC4, 00:01:02:b4:36:56
> eth1: FEC ENET Version 0.3, FEC irq 9, MII irq 12, addr
> 00:01:02:b4:36:57

But there are two intefaces. Which one should the kernel use?

Just fix your bootargs.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You humans have that emotional need  to  express  gratitude.  "You're
welcome," I believe, is the correct response.
	-- Spock, "Bread and Circuses", stardate 4041.2

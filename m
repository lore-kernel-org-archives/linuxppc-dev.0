To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 08 Jan 2003 12:12:12 PST."
             <885489B3B89FB6449F93E525DF78777F064533@srvnt506.ALLOPTIC.COM>
Date: Thu, 09 Jan 2003 01:09:09 +0100
Message-Id: <20030109000914.86A54C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <885489B3B89FB6449F93E525DF78777F064533@srvnt506.ALLOPTIC.COM> you wrote:
>
> So, after changed the kernel address to 0xc0000000 the kernel did
> bootup with the following dump:
...
eth0: CPM ENET Version 0.2 on SCC1, 00:00:00:00:00:00
eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:00:00:80:00:00

Ummm... does not look like valid MAC addresses to me.

> Looking up port of RPC 100003/2 on 192.168.0.59
> RPC: sendmsg returned error 101
> portmap: RPC call returned error 101

errno=101 -- Network is unreachable

> Looks like my IP has some problem.  I will like to use the BDI with the ddd

It's more that your MAC address is bogus.

> on my linux server.  When i start the ddd with the following command as
> suggested
> by the appnote
> ddd -debugger gdb -gdb vmlinux

Which appnote? Doesn't it mention that you  need  to  run  a  PowerPC
version of GDB, either natively or a cross-GDB?

> (gdb)target remote bdi:2001
> Remote packet too long:
> c00021a00040b..............
>
> It seems there is a problem between the BDI and the DDD on my linux PC.  I
> am running
> redHat 8.0, GNU DDD 3.3.1 (i686-pc-linux-gnu)

The problem is that "gdb" will start the native GDB, which  does  not
work on PowerPC systems. You have to specify the name of your PowerPC
Cross-GDB.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You don't have to stay up nights to succeed; you have to  stay  awake
days.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eth1 FEC on RPX-CLLF info 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Nov 2001 12:07:02 EST."
             <3BFA8DB6.1050405@oerlikon.ca>
Date: Tue, 20 Nov 2001 20:03:54 +0100
Message-Id: <20011120190359.27783F9B9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sebastien,

in message <3BFA8DB6.1050405@oerlikon.ca> you wrote:
>
> Hello Wolfgang,

I'm not exactly sure whom you're addressing:  the  email  addess  was
Dan's  but  the  name  is mine, and it seems you are referring to the
kernel version on our FTP server, so I jump in ...

> I'm trying to activate the FEC on my RPX-CLLF board. Everything seems ok
> when I do a ifconfig -a, but the FEC eth1 interface seems dead. I wonder
> if the base address of the FEC is really 0xe00?

What do you think  it  means?  Here,  it's  the  offset  of  the  FEC
parameter RAM in the IMMR memory map. And yes, 0xE00 is correct.

> Here is the boot screen dump. The eth1 FEC MAC address is correctly read.
> ...
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:2c:93
> eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:10:ec:80:2c:93

Looks good to me...

> eth1      Link encap:Ethernet  HWaddr 00:10:EC:80:2C:93
>           inet addr:148.33.216.245  Bcast:148.33.255.255  Mask:255.255.255.0

Are you sure about those settings? To me  it  seems  Bcast  and  Mask
don't match...

> Would you have any idea of the problem?

What happens when you enable the MDIO option?

> By the way, in the file fec.c from kernel 2.4.4 (2001-07-23), it is
> mentionned that the FEC PHY for the RPX-CLLF board is a QS6612. I have
> an RPX-CLLF board, and it uses an LXT971.

Did you enable the LXT971 code, then? Sorry, I don't  have  any  CLLF
boards here, so I cannot test this myself.

Just tested it (again) on a TQM860L-P.50; works fine for me.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Above all else -- sky.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

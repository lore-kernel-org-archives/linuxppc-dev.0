To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TFTP not able to find file??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Feb 2003 13:56:05 PST."
             <995FF289C9D69747A09E42992644595405B23642@penguin.adic.com>
Date: Sun, 02 Feb 2003 23:58:07 +0100
Message-Id: <20030202225812.2BBB7C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B23642@penguin.adic.com> you wrote:
>
> - I used DHCP because as I fuddled around with u-boot, it didn't see
>   possible to separate tftp from bootp. In other words, even if I set

Oops? What's wrong with just using U-Boot's "tftp" command?

>   ip addr(s) and stuff through the u-boot setenv command, the values
>   would be automatically overidden when I run the bootp command. The

Right. When you use DHCP or BOOTP you ask for  network  configuration
from the server, so this is what you get.

>   BOOTP command seems to be the only way to kick off tftp, so I really

Wrong. You can start in  manually  (using  the  "tftp"  /  "tftpboot"
command,  or  automagically as part of the "rarpboot", "bootp" and/or
"dhcp" commands.

>   wasn't able to find a way to make use of statically set network
>   Config info.

Did you read the PPCBoot guid at our web page? It explains this stuff
pretty well.

> - vmlinux.PPCBOOT is the product of my 'make uImage' build in my kernel
>   source tree.
>
> Any ideas on why this isn't working??
...
>                         filename                "/tftpboot/vmlinux.PPCBoot";
...
> => bootp
> ENET Speed is 100 Mbps - HALF duplex connection
> BOOTP broadcast 1
> DHCP client bound to address 172.16.77.152
> ARP broadcast 1
> TFTP from server 172.16.77.151; our IP address is 172.16.77.152
> Filename '/tftpboot/vmlinux.PPCBoot'.
> Load address: 0x100000
> Loading: *
> TFTP error: 'File not found' (1)

Your TFTP server might do a "chroot" into the /tftpboot directory, so
the file "/tftpboot/vmlinux.PPCBoot" cannot be found there.

Fix yout TFTP server configuration.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No problem is insoluble.
	-- Dr. Janet Wallace, "The Deadly Years", stardate 3479.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <39C26A51.CA521100@mvista.com>
Date: Fri, 15 Sep 2000 11:28:33 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: rshaw@graftononline.net
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
References: <001401c01eb2$48a92330$0100a8c0@nonewr2gx24hxi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rshaw@graftononline.net wrote:
>
> I'm trying to get a CLLF 860T to load a kernel normally.  I'm using Embedded
> PowerPC Cross Development Kit Rev. 1.0 Hard Hat Linux.

you might want to upgrade to 1.2. it is on our ftp site.  It is not
nescessary, but it is always good to use the latest stable stuff.

> While loading the kernel via tftp I found that in order for the boot process
> to work I have to use both the 10 Mbps and 100 Mbps ports.

the EP boot loader uses the 10Mbps port for tftp loading.  You don't use
the 10/100 for tftp.

>If I do not do
> this it times out at "Sending BOOTP requests". I have had to execute the
> following script before loading via tftp during which time the 10 Mbps port
> is being used.

you only need to use the 10Mbps port, you don't need the 100Mbps port
connected  to the network.

>
> #!/bin/bash
> arp -s 192.168.0.3 00:10:ec:00:00:00

that ethernet address is wrong.  This may be causing some of your
problems.  Contact Embedded Planet support for help to reprogram the
correct enet address for your board


> OK, This gets us to a Linux shell prompt even though I had to execute the
> script files using both the 10 Mbps and 100 Mbps ports, which I shouldn't
> have to do. I'm hoping someone might be able to help me with why I need to
> use both ports and execute these arp commands.  Is something wrong with my
> DHCP configuration?

look into changing the enet address to the right one.   the
configuration looks fine.  I hope the w2k host is not really running
win2k.  If it is, all bets are off.


> Here is the /etc/hosts file contents
>
> 127.0.0.1 localhost.localdomain localhost
> 192.168.0.1 win2000 w2k
> 192.168.0.2     RANDYLINUX rlx
> 192.168.0.3     CLLFBOARD cllf
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

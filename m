To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ifconfig: SCC1 enet0 not showing up 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 18 Dec 2002 09:56:52 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC05F4E@SNCMAIL>
Date: Wed, 18 Dec 2002 17:43:12 +0100
Message-Id: <20021218164317.D3F5BC6289@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC05F4E@SNCMAIL> you wrote:
>
> My Ethernet is not showing up ... I have compiled in enet support ... fixed
> my port pins ... but when I do ifconfig I see only:

Probably you did not configure the network interface at all?

> At start my enet scc is configured properly ... I am pretty sure because I
> see:
> ## Transferring control to Linux (at address 00000000) ...
> Linux version 2.4.20-pre8 ...
> Kernel command line: root=/dev/ram rw
> ip=192.168.104.101:192.168.103.151:192.168.104.1:255.255.255.0:BigMoney::off

>From  this  command  line  I  suspect  that  you  intend  to  use  IP
autoconfiguration, but then...

...
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

...then you don't enable IP autoconfiguration in the kernel,  so  you
will have to manually configure the interface.


I guess you want to define CONFIG_IP_PNP ...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why is an average signature file longer than an average Perl script??

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

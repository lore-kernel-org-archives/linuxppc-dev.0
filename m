Message-ID: <000f01c41782$ab3b6400$150a0a0a@netoriented.com>
Reply-To: "Tang Nguyen" <tang@netoriented.com>
From: "Tang Nguyen" <tang@netoriented.com>
To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com>, <wd@denx.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <05866645C8E0B842836A1E91B2AD6B7F01465781@CUR1006V.br002.siemens.net.br>
Subject: Re: eth0 configuration 
Date: Wed, 31 Mar 2004 16:45:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I think because in the kernel, you have configured IP:kernel level auto
configuration.  So, when the kernel boots up, it required correct IP address
and netmask to configure the eth0 interface.

If you turn off IP:kernel level auto configuration in Kernel Configure then
I think your old boot args should work.  But you need to configure IP
address for eth0 by command: ifconfig eth0 xxx.


-tang

----- Original Message -----
From: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com>
To: <wd@denx.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, March 31, 2004 11:07 AM
Subject: RE: eth0 configuration



Hi, thanks for the tip.
Using parameters: "root=/dev/ram0 rw ip=:::::eth0:", it works.
Could you explain me what it happens to start ip auto configuration when
this boot args is used?

Otavio I. Sugeno

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: quarta-feira, 31 de março de 2004 16:01
To: OTAVIO ISAMU SUGENO
Cc: LinuxPPC
Subject: Re: eth0 configuration

In message
<05866645C8E0B842836A1E91B2AD6B7F01465777@CUR1006V.br002.siemens.net.br> you
wrote:
>
> I am sure that interrupts are correctly because it is working with HHL_20.

With exactly the same boot arguments?

> If it does not disturb you so much, I attached the complete boot log and
> config file to analysis.
...
> PPCBoot 1.0.5 (Mar 28 2002 - 14:25:53)
>
> CPU:   XPC860xxZPnnD4 at 49.200 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
...
> Loading PPCBOOT File.
> RARP broadcast 1
> TFTP from server 129.214.68.21; our IP address is 129.214.68.10
> Filename 'ppcboot.bin'.

I have no idea why you load  a  binary  image  of  PPCBoot  when  you
already have PPCBoot running, but I hope you know hwat you are doing.

...
> Linux version 2.4.24-pre2 (root@cur1307x) (gcc version 3.2.2 20030217
(Yellow Dog Linux 3.0 3.2.2-2a_1)) #51 Seg Mar 29 16:43:07 BRT 2004
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram0 rw
...

Try passing: "root=/dev/ram0 rw ip=:::::eth0:"

Or even "root=/dev/ram0 rw ip=:::::eth0:rarp"

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If that makes any sense to you, you have a big problem."
                                  -- C. Durance, Computer Science 234


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

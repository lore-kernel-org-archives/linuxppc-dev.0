Date: Sat, 30 Jun 2001 12:41:04 -0700
From: Matt Porter <mporter@mvista.com>
To: Ravindranath <krnsoft@yahoo.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: sandPoint 8240 booting: Not reconginzing ethernet card
Message-ID: <20010630124104.A7946@cx258813-a.chnd1.az.home.com>
References: <20010620202250.24435.qmail@web11606.mail.yahoo.com> <20010630223320.2166.qmail@web11602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010630223320.2166.qmail@web11602.mail.yahoo.com>; from krnsoft@yahoo.com on Sat, Jun 30, 2001 at 03:33:20PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jun 30, 2001 at 03:33:20PM -0700, Ravindranath wrote:
>
> Hi,
>
> I am having problems with ppc linux booting on my
> sandpoint 8240..
>
> I have built the kernel with the ethernet driver(3COM
> Fast ethernet)..For this I changed config file and
> turn on the ethernet driver in the config file. The
> target still doesn't boot..
>
> I have attached the boot log. The significant error
> seems to be "No network devices available".

Look before that message.

> Some more questions:
> 1. I have setup the dhcp server my host m/c(redhat6.2)
> with the instructions form Mvista cdk1.2 docs.Also the
> instructions ask for setting fixed ip address for the
> target in /etc/dhcpd.conf file. Since I have set up
> the dhcp server, I am not sure what should be the
> fixed-address in the /etc/dhcpd.conf file.

It's arbitrary.  This is where you get to exercise those creative
juices and assign an IP address and name to the target.

> 2. Also do we need to pass the ip address as part of
> the boot arguments..If so how??

Not if you set up the dhcpd.conf properly.  RTFM the HHL 1.2 docs and/or
"man dhcpd.conf".  There's several excellent examples in the man page
itself.  People are writing the documentation in the hope that you'll
read it so do them a favor.

<snip>

> 3Com Corporation 3c905 100BaseTX [Boomerang] bus 0 dev
> 15
>         BAR 0, I/O, size=0x40, address=0xafe380
>         IRQ 18

Yep, Boomerangs use the 3c59x driver.

<snip>

> 0 3c515 cards found.

Couldn't find a 3c515 since you have 3c59x card.

Configure the '3c590/3c900 series (592/595/597) "Vortex/Boomerang" support'
options and try again.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

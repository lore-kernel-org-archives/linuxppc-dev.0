Message-ID: <3C1A299D.8090402@gatekeeper.informatik.fh-dortmund.de>
Date: Fri, 14 Dec 2001 17:32:29 +0100
From: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre8-ben0: kernel oops using pcmcia services
References: <3C1A21C4.6040607@gatekeeper.informatik.fh-dortmund.de> <20011214162648.16316@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>>I get the below kernel oops after I put my cisco aironet pcmcia card into
>>the external slot on my tibook. Kernel bug or wrong setup ? While loading
>>the airo_cs module per hand I get no oops.
>>
>
> Looks like it tried to ioremap an ISA memory address, bad bad bad...
>
> Either your memory options in config.opts is wrong or that driver
> has a bug.


Hmm.. don't know. Here is my config.opts, maybe you could take a look
on it ?

Thanks
Ralf


[root@tibook /root]# cat /etc/pcmcia/config.opts
#
# Local PCMCIA Configuration File
#
#----------------------------------------------------------------------

# System resources available for PCMCIA devices

include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
include memory 0xc0000-0xfffff
include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff

# High port numbers do not always work...
# include port 0x1000-0x17ff

# Extra port range for IBM Token Ring
include port 0xa00-0xaff

# Resources we should not use, even if they appear to be available

# First built-in serial port
exclude irq 4
# Second built-in serial port
#exclude irq 3
# First built-in parallel port
exclude irq 7

#----------------------------------------------------------------------

# Examples of options for loadable modules

# To fix sluggish network with IBM ethernet adapter...
#module "pcnet_cs" opts "mem_speed=600"

# Options for IBM Token Ring adapters
#module "ibmtr_cs" opts "mmiobase=0xd0000 srambase=0xd4000"

# Options for Raylink/WebGear driver: uncomment only one line...
# Generic ad-hoc network
module "ray_cs" opts "essid=ADHOC_ESSID hop_dwell=128 beacon_period=256 translate=1"
# Infrastructure network for older cards
#module "ray_cs" opts "net_type=1 essid=ESSID1"
# Infrastructure network for WebGear
#module "ray_cs" opts "net_type=1 essid=ESSID1 translate=1 hop_dwell=128 beacon_period=256"

# Options for WaveLAN/IEEE driver (AccessPoint mode)...
#module "wvlan_cs" opts "station_name=MY_PC"
# Options for WaveLAN/IEEE driver (ad-hoc mode)...
#module "wvlan_cs" opts "port_type=3 channel=1 station_name=MY_PC"

# Options for Xircom Netwave driver...
#module "netwave_cs" opts "domain=0x100 scramble_key=0x0"


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

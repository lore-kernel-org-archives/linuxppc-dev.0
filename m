Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id 7B9C5B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Nov 2010 23:05:27 +1100 (EST)
Message-ID: <4CF2434F.6090008@mlbassoc.com>
Date: Sun, 28 Nov 2010 04:55:59 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Peter <sailingsmoky@googlemail.com>
Subject: Re: PHY/FEC Network adapter failed to initialize on MPC52xx Board
References: <4CF10819.4050007@crane-soft.de>
In-Reply-To: <4CF10819.4050007@crane-soft.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/27/2010 06:31 AM, Peter wrote:
> Hi all
>
> I got completely stuck with a network adapter problem on my
> ppc board (MPC52xx style). The ntwork adapter does not seem
> to intialize correctly when booted without 'help from uboot'
>
> The adapter works properly when I first use it with uboot. E.g.
> using tftp to load the kernel or just issuing a dummy sntp
> command. It does not get intialized if I boot linux without
> using any network relevant command in ubboot
>
> The difference manifests on the boot message: (working)
> PHY working
> ...
> mpc52xx MII bus: probed
> TCP cubic registered
> NET: Registered protocol family 17
> IP-Config: Complete:
>       device=eth0, addr=192.168.1.245, mask=255.254.0.0, gw=192.168.1.2,
>       host=192.168.1.245, domain=, nis-domain=(none),
>       bootserver=192.168.1.244, rootserver=192.168.1.244, rootpath=
> Looking up port of RPC 100003/2 on 192.168.1.244
> Looking up port of RPC 100005/1 on 192.168.1.244
> VFS: Mounted root (nfs filesystem) on device 0:11.
> Freeing unused kernel memory: 124k init
> PHY: f0003000:00 - Link is Up - 100/Full
>
> # ping 192.168.1.2  returns proper results.
>
> PHY Not working:
> ...
> mpc52xx MII bus: probed
> TCP cubic registered
> NET: Registered protocol family 17
> IP-Config: Complete:
>       device=eth0, addr=192.168.1.245, mask=255.254.0.0, gw=192.168.1.2,
>       host=192.168.1.245, domain=, nis-domain=(none),
>       bootserver=192.168.1.244, rootserver=192.168.1.244, rootpath=
> VFS: Mounted root (squashfs filesystem) readonly on device 31:3.
> Freeing unused kernel memory: 124k init
>
> # ping 192.168.1.2  hangs
>
>
> The second snipped does not have "Looking up.." messages because it
> boots from flash. Main difference is "PHY: f0003000:00 - Link is Up - 100/Full"
> which does not appear at the failing case.
>
> Linux Version is 2.6.35.7 patched with xenomai 2.5
> U-Boot 2010.06 (Aug 05 2010 - 19:54:45)
>
> Linux configuration see below: ( i left most entries out that are not set)
> I also experimented with different settings but finally only
> CONFIG_FEC_MPC52xx=y  and CONFIG_FEC_MPC52xx_MDIO=y
> seem to be of any relevance. If both are set, the adapter works
> when initialized by uboot.
>
> Any help or tips will be very much appreciated,

There are a couple of possibilities:

* Many PHY devices will have an external RESET or enable pin which is
   driven by GPIO.  The board support package in U-Boot for your board
   would then enable the PHY device as part of network initialization.
   The Linux kernel typically does not fiddle with such things.

* The actual PHY device may need some setup (adjustment of internal
   PHY registers) before it will come on-line, e.g. the device may not
   be strapped to auto-negotiate on the wire to find a link.  U-Boot
   might be turning this on, or even forcing the link up (I've seen
   such devices that needed this level of hand-holding).  Again, the
   Linux network driver typically will not be doing these sort of
   operations.

To figure out what's going on and what else you might need, you should
look at both the U-Boot code for your board and the board documentation
(schematics, etc).  Then you should be able to see what U-Boot does that
the Linux kernel is not.  In the end, you may need to add some code in
your target platform support in Linux to add the additional stuff to make
the PHY work.

> Linux .config
>
> ...
> #
> # Platform support
> #
> # CONFIG_PPC_CHRP is not set
> # CONFIG_MPC5121_ADS is not set
> # CONFIG_MPC5121_GENERIC is not set
> CONFIG_PPC_MPC52xx=y
> CONFIG_PPC_MPC5200_SIMPLE=y
> # CONFIG_PPC_EFIKA is not set
> CONFIG_PPC_LITE5200=y
> # CONFIG_PPC_MEDIA5200 is not set
> CONFIG_PPC_MPC5200_BUGFIX=y
> # CONFIG_PPC_MPC5200_GPIO is not set
> CONFIG_PPC_MPC5200_LPBFIFO=y
>
> CONFIG_PPC_BESTCOMM=y
> CONFIG_PPC_BESTCOMM_FEC=y
> CONFIG_PPC_BESTCOMM_GEN_BD=y
> # CONFIG_SIMPLE_GPIO is not set
> ..
> # Bus options
> #
> CONFIG_ZONE_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_PPC_PCI_CHOICE=y
> ...
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_MTD=y
> CONFIG_MTD_PARTITIONS=y
> CONFIG_MTD_CMDLINE_PARTS=y
>
> #
> # MII PHY device drivers
> #
> CONFIG_LXT_PHY=y                        ## Does not seem to have any influence
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> CONFIG_ETHOC=y                           ## Does not seem to have any influence
> CONFIG_FEC_MPC52xx=y              ## Must be Y in roder to get adapter working with uboot's init
> CONFIG_FEC_MPC52xx_MDIO=y  ## Must be Y in roder to get adapter working with uboot's init
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

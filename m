Date: Thu, 10 May 2001 03:45:38 -0700
From: Matt Porter <mporter@mvista.com>
To: machael thailer <dony.he@huawei.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Message-ID: <20010510034537.A7488@cx258813-a.chnd1.az.home.com>
References: <001d01c0d5c8$27ae8c60$8021690a@huawei.com> <3AF6F323.7944F695@mvista.com> <000901c0d8fe$78abed40$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000901c0d8fe$78abed40$8021690a@huawei.com>; from dony.he@huawei.com on Thu, May 10, 2001 at 11:08:21AM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 10, 2001 at 11:08:21AM +0800, machael thailer wrote:
>
> > machael thailer wrote:
> > > ..... But I met
> > > some urgent problems ...
> > >     I modified the bootloader codes according to arch/ppc/mbxboot/head.S
> >
> > For starters, you shouldn't be using this "boot loader" for a 750.....
> > How did you configure a kernel to get there in the first place?
> > A 750 should be a CHRP (or PReP, if you have to.....), which will
> > direct you to a working "chrpboot" boot loader.
>
> If I use  "chrpboot " bootloader, I have to provide many functions in my
> boot codes according to CHRP specifications:
>
> 1  "prom"(promptr) functions which can provide with "/chosen" ,"claim" and
> "getprop" services etc in arch/ppc/chrpboot/start.c and in
> arch/ppc/kernel/prom.c .
> 2  device-trees for my custom board.
>
> Are these functions all necessary for booting the linux kernel?

You're doing this all wrong.  There have been a bunch of good examples
of ports to non-CHRP/PReP/Pmac 6xx/7xx/74xx hardware in the linuxppc_2_5
tree for a while now.  Most of them have just been moved into the
new linuxppc_2_4_devel tree.  See the K2, MVME5100, MCPN765, PCore,
PrPMC750, F1, etc. ports for details on how to quickly and easily do
a port to a custom board.

> And do I have to  modify arch/ppc/mm/init.c=>MMU_init() and
> arch/ppc/kernel/setup.c=>identify_machines() to suit my cases?
> I notice that in identify_machines(), there are many types initializations
> functions such as pmac_init(),prep_init(),chrp_init(),apus_init(),
> oak_init(),m8xx_init(),m8260_init(). Do I have to provide my own ***_init()
> functions?

Yes.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 12 Feb 2003 23:37:34 -0700
From: Matt Porter <porter@cox.net>
To: "William A. Gatliff" <bgat@billgatliff.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI: Cannot allocate resource region {012}
Message-ID: <20030212233734.A32277@home.com>
References: <20030212222135.A7769@saturn.billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030212222135.A7769@saturn.billgatliff.com>; from bgat@billgatliff.com on Wed, Feb 12, 2003 at 10:21:35PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 12, 2003 at 10:21:35PM -0600, William A. Gatliff wrote:
>
> Guys:
>
>
> I'm porting 2.4.20 to a custom MPC8245 system, based loosely on code
> from MV's 2.4.19, in particular the mpc10x.c.
>
> When my kernel boots, I see these:
>
> PCI: Cannot allocate resource region 0 of device 00:02.0
> PCI: Cannot allocate resource region 1 of device 00:02.0
> PCI: Cannot allocate resource region 2 of device 00:02.0
> ...
> PCI: Cannot allocate resource region 0 of device 00:1f.0
> PCI: Cannot allocate resource region 1 of device 00:1f.0
> PCI: Cannot allocate resource region 2 of device 00:1f.0

Bill,

Take a look at sandpoint_pci.c:sandpoint_exclude_device()
for an example of using the ppc_md.exclude_device.  Have it
avoid bus 0 devfn 0 so it ignores your host bridge (doesn't
hit its IDSEL on the bus scan).  That should cure your
system.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

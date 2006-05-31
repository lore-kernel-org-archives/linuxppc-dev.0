Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AE1CB67B3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 10:58:14 +1000 (EST)
Date: Wed, 31 May 2006 04:58:04 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: fs_enet segfaults when adding network interface to bridge
Message-ID: <20060531045804.3948d738@localhost.localdomain>
In-Reply-To: <C7B65358-8BEF-42E7-A11C-3FBC501BB324@freescale.com>
References: <200605301351.11967.laurent.pinchart@tbox.biz>
	<20060530172700.198bba36@vitb.ru.mvista.com>
	<200605301539.55319.laurent.pinchart@tbox.biz>
	<C7B65358-8BEF-42E7-A11C-3FBC501BB324@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 30 May 2006 16:54:42 -0500
Andy Fleming <afleming@freescale.com> wrote:

> 
> On May 30, 2006, at 08:39, Laurent Pinchart wrote:
> 
> >>> Hi everybody,
> >>>
> >>> I ran into a segfault in the fs_enet driver when adding the
> >>> network interface to an ethernet bridge. This only happens when
> >>> the interface is
> >>> down.
> >>>
> >>> ----- Kernel version -----
> >>> Linux tbox-cp11 2.6.17-rc3-g7f02f290-dirty #549 Tue May 30  
> >>> 13:25:37 CEST
> >>> 2006 ppc unknown
> >>> (from main linux-2.6 git repository)
> >>> ----- End of kernel version -----
> >>>
> >>> ----- Oops report -----
> >>> Oops: kernel access of bad area, sig: 11 [#1]
> >>> NIP: C0109884 LR: C010D420 CTR: 00000000
> >>> REGS: c027d7f0 TRAP: 0300   Tainted: P       (2.6.17-rc3- 
> >>> g7f02f290-dirty)
> >>> MSR: 00009032 <EE,ME,IR,DR>  CR: 24000222  XER: 00000000
> >>> DAR: 00000140, DSISR: 20000000
> >>> TASK = c0851090[42] 'brctl' THREAD: c027c000
> >>> GPR00: C010D414 C027D8A0 C0851090 00000000 C027D8D0 FFFFFFFF  
> >>> F00000A0
> >>> EFFFFFFF GPR08: C026E380 C0210000 00000000 C0230000 C0210000  
> >>> 1001D150
> >>> 00FFE000 00000001 GPR16: FFFFFFFF 00000000 007FFF00 7FDD0AC0  
> >>> 00000000
> >>> 10072C94 7FDD0AD8 10072CA4 GPR24: 00000000 10000A48 00000000  
> >>> C027D8D0
> >>> C027D8D0 C08A1A60 C027DC50 C08A1800 NIP [C0109884]
> >>> phy_ethtool_gset+0x0/0x48
> >>> LR [C010D420] fs_get_settings+0x34/0x48
> >>> Call Trace:
> >>> [C027D8A0] [C010D414] fs_get_settings+0x28/0x48 (unreliable)
> >>> [C027D8C0] [C013DDC0] dev_ethtool+0x9bc/0x13c8
> >>> [C027DC40] [C018CBC0] port_cost+0x58/0x108
> >>> [C027DCB0] [C018D3E8] br_add_if+0x174/0x2f4
> >>> [C027DCE0] [C018D9AC] add_del_if+0x94/0x98
> >>> [C027DD00] [C018DD68] br_dev_ioctl+0x70/0xae4
> >>> [C027DE00] [C013B42C] dev_ifsioc+0x17c/0x404
> >>> [C027DE20] [C013BA4C] dev_ioctl+0x398/0x4e8
> >>> [C027DEB0] [C012EEFC] sock_ioctl+0x154/0x220
> >>> [C027DEE0] [C0067164] do_ioctl+0x88/0x9c
> >>> [C027DEF0] [C0067230] vfs_ioctl+0xb8/0x3f0
> >>> [C027DF10] [C00675A8] sys_ioctl+0x40/0x74
> >>> [C027DF40] [C00040E0] ret_from_syscall+0x0/0x38
> >>> Instruction dump:
> >>> 7c0803a6 4e800020 2f800000 409eff78 4bffffb8 8804000e 2b800001  
> >>> 40bdff70
> >>> 3860ffea 4bffffd4 61200040 4bffff84 <81230140> 91240004 80030144  
> >>> 90040008
> >>> ----- End of oops report -----
> >>>
> >>> ----- Source lines -----
> >>> [C0109884] phy_ethtool_gset+0x0/0x48 (drivers/net/phy/phy.c:290)
> >>> [C010D414] fs_get_settings+0x28/0x48
> >>> (drivers/net/fs_enet/fs_enet-main.c:885) [C013DDC0]
> >>> dev_ethtool+0x9bc/0x13c8 (net/core/ethtool.c:122)
> >>> [C018CBC0] port_cost+0x58/0x108 (net/bridge/br_if.c:54)
> >>> ----- End of source lines -----
> >>>
> >>> phy_ethtool_gset segfaults when trying to access phydev->supported
> >>> because phydev is NULL.
> >>>
> >>> As I'm not familiar with the fs_enet driver, I'm looking for
> >>> advices regarding what to fix and how to fix it.
> >>
> >> IIRC, fs_enet got bound to phydev only being ->up. So in down  
> >> state, phydev
> >> may be either null, or last assigned (need to have a look into  
> >> source to
> >> tell for certain). So what is the proper behavior from your point  
> >> of view?
> >
> > I have no idea :-) What I know is that the driver should not  
> > segfault when
> > asked to report the port speed. Either we should return an error
> > or have the
> > phy device bound to fs_enet at all time. It might also be a bridge  
> > issue,
> > maybe the bridge code should turn the interface up before reading  
> > its speed.
> > How do other ethernet drivers proceed ?
> 
> 
> Well, gianfar only invokes phy_ethtool_gset() after checking to see  
> that phydev is not NULL.  fs_enet should do this as well.  It may be  
> preferable to move that check into phy_ethtool_gset().  Certainly a  
> workable solution, though I'm inclined to feel that the PHY layer  
> should be able to assume that a given PHY exists.  The sort of  
> problem also exists if you try to use ethtool to find the ring sizes  
> before the device has been opened.
> 
> Anyway, the easy fix is for fs_enet to check for NULL before calling  
> phy_ethtool_gset().
> 
Andy,

Thanks for pointing it out, I was just going to seek into gianfar
behavior. 

That issue seems not the only problem - there are plenty of cases I
saw, where if initially PHY got failed to be bound, fs_enet seems to
be really unhappy with phydev == NULL and direct dereferences of the
latter. 

I'll try to address that stuff as time permits...

-Vitaly

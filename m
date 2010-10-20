Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 6D029B70E1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 20:19:18 +1100 (EST)
Received: by eya25 with SMTP id 25so557218eya.15
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 02:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
	<4CBC080A.7030005@windriver.com>
	<20101018114214.2e72a616@udp111988uds.am.freescale.net>
	<4CBCFC5D.3010403@windriver.com>
	<AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
Date: Wed, 20 Oct 2010 02:19:15 -0700
Message-ID: <AANLkTimW1_Hc3kQ2Wbn6zDMUSJvRCxn0XdGw4wB-mm0D@mail.gmail.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
From: Shawn Jin <shawnxjin@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The problem for me is that the PHY failed to be probed. The related
> error messages are shown below. I even tried the patch Tiejun pointed
> out. But that doesn't help. The phy ID read from the bus was all Fs.
>
> FEC MII Bus: probed
> mdio_bus fa200e00: error probing PHY at address 0

I think I figured out the probing failure. My board uses PortD bit8 as
an input pin from phy's MDC. I didn't set up this pin assignment.

When probing the PHY the fs_enet_fec_mii_read() is called to get phy
id. The correct phy id was returned. However when I tried to set up
the ip address using the command "ifconfig eth0 192.168.0.4". The same
function was called again. But this time the fecp->fec_r_cntrl
mysteriously became 0 so the kernel reported bug for that.

# ifconfig eth0 192.168.0.4
------------[ cut here ]------------
kernel BUG at drivers/net/fs_enet/mii-fec.c:58!
Oops: Exception in kernel mode, sig: 5 [#1]
MyMPC870
NIP: c012b79c LR: c012963c CTR: c012b77c
REGS: c7457c60 TRAP: 0700   Not tainted  (2.6.33.5)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24020042  XER: 20000000
TASK = c7840000[236] 'ifconfig' THREAD: c7456000
GPR00: 00000001 c7457d10 c7840000 c7845400 00000000 00000001 ffffffff 00000000
GPR08: c77c44fc c906ce00 c784806c 00000b9f 84020042 100b986c 10096042 1009604f
GPR16: 1009603b 10096030 10096001 100b188e c7457e18 ffff8914 c742430c c740b000
GPR24: c7424300 c78443c0 00000001 00000000 c7845428 c7845400 c7845600 c7845600
NIP [c012b79c] fs_enet_fec_mii_read+0x20/0x90
LR [c012963c] mdiobus_read+0x50/0x74
Call Trace:
[c7457d10] [c0115744] driver_bound+0x60/0xa0 (unreliable)
[c7457d30] [c0129094] genphy_config_init+0x24/0xd4
[c7457d40] [c0128920] phy_init_hw+0x4c/0x78
[c7457d50] [c0128a40] phy_connect_direct+0x24/0x88
[c7457d70] [c0133e50] of_phy_connect+0x48/0x6c
[c7457d90] [c012ae10] fs_enet_open+0xf0/0x2cc
[c7457db0] [c0148a54] dev_open+0x100/0x138
[c7457dd0] [c0146ca0] dev_change_flags+0x80/0x1a8
[c7457df0] [c018e104] devinet_ioctl+0x630/0x750
[c7457e60] [c018eb5c] inet_ioctl+0xcc/0xf8
[c7457e70] [c01370d8] sock_ioctl+0x60/0x28c
[c7457e90] [c007dbcc] vfs_ioctl+0x38/0x9c
[c7457ea0] [c007ddf0] do_vfs_ioctl+0x84/0x708
[c7457f10] [c007e4b4] sys_ioctl+0x40/0x74
[c7457f40] [c000de60] ret_from_syscall+0x0/0x38
Instruction dump:
80010014 7c0803a6 38210010 4e800020 81230018 81290000 7c0004ac 80090144
0c000000 4c00012c 68000004 5400f7fe <0f000000> 5484b810 64846002 54a5925a
---[ end trace 41bf95259a68372e ]---
Trace/breakpoint trap

I cannot find where the fec_r_cntrl would be reset to 0 after
fs_enet_mdio_probe() sets it to FEC_RCNTRL_MII_MODE. Odd?

Thanks,
-Shawn.

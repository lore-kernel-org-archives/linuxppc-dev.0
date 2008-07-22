Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807221554j451019a0sa711541e97fbf0aa@mail.gmail.com>
Date: Tue, 22 Jul 2008 18:54:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: netif_schedule and mpc5200_fec
In-Reply-To: <20080722.154201.234654750.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910807221247r38509c76uf625195b712a1145@mail.gmail.com>
	<9e4733910807221403g512f6e37s6722c7950f881224@mail.gmail.com>
	<20080722.154201.234654750.davem@davemloft.net>
Cc: davem@redhat.com, Linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/22/08, David Miller <davem@davemloft.net> wrote:
> From: "Jon Smirl" <jonsmirl@gmail.com>
>  Date: Tue, 22 Jul 2008 17:03:32 -0400
>
>
> > On 7/22/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > > I just updated to linus/master and mpc5200_fec won't boot.
>  >
>  > It does boot, but this badness looks like it is coming from this
>  > patch. I don't know enough about networking to debug it.
>
>
> I just applied the following patch from Anton Vorontsov which
>  will fix this.

I applied this piece and still have the same error.

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index b487d6f..4e4f683 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -197,9 +197,6 @@ static void mpc52xx_fec_adjust_link(struct net_device *dev)
                if (priv->link == PHY_DOWN) {
                        new_state = 1;
                        priv->link = phydev->link;
-//                     netif_tx_schedule_all(dev);
-//                     netif_carrier_on(dev);
-//                     netif_start_queue(dev);
                }

        } else if (priv->link) {
@@ -207,8 +204,6 @@ static void mpc52xx_fec_adjust_link(struct net_device *dev)
                priv->link = PHY_DOWN;
                priv->speed = 0;
                priv->duplex = -1;
-//             netif_stop_queue(dev);
-//             netif_carrier_off(dev);
        }

        if (new_state && netif_msg_link(priv))
jonsmirl@terra:~/fs$


net eth0: attached phy 0 to driver Generic PHY
Sending DHCP requests .<0>------------[ cut here ]------------
Badness at c01da570 [verbose debug info unavailable]
NIP: c01da570 LR: c015b31c CTR: c015b234
REGS: c382de70 TRAP: 0700   Not tainted  (2.6.26-efika)
MSR: 00029032 <EE,ME,IR,DR>  CR: 22000082  XER: 00000000
TASK = c3815000[4] 'events/0' THREAD: c382c000
GPR00: 00000001 c382df20 c3815000 c031e468 c38f25a0 00000000 00000000 00000000
GPR08: c382dfb4 c0330000 00000000 c031e468 2f762097 ffffffff 03ffe000 ffffffff
GPR16: 00000001 00000000 007ffc00 00000000 00000000 03ff8838 00000000 00000004
GPR24: 00000000 00000000 c032b46c c0330000 c38a2e00 00000001 c38f2780 c38f2400
NIP [c01da570] __netif_schedule+0x3c/0xac
LR [c015b31c] mpc52xx_fec_adjust_link+0xe8/0x194
Call Trace:
[c382df20] [c002eeb0] queue_work+0x58/0x6c (unreliable)
[c382df40] [c015b31c] mpc52xx_fec_adjust_link+0xe8/0x194
[c382df60] [c0158cd0] phy_state_machine+0xec/0x4e0
[c382df80] [c002eb0c] run_workqueue+0xb4/0x148
[c382dfa0] [c002f070] worker_thread+0x9c/0xb8
[c382dfd0] [c0032954] kthread+0x4c/0x88
[c382dff0] [c000f538] kernel_thread+0x44/0x60
Instruction dump:
7c6b1b78 3929e468 7f834800 39200002 90010024 38030024 bfa10014 40be0030
3d20c033 80099988 7c000034 5400d97e <0f000000> 2f800000 41be0054 38000001
PHY: f0003000:00 - Link is Up - 100/Full
., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.11
IP-Config: Complete:
     device=eth0, addr=192.168.1.11, mask=255.255.255.0, gw=192.168.1.1,
     host=Phytec, domain=, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.4, rootpath=


-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <madskateman@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL4W03QYmzF0Zg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 07:21:14 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id c2so15633456qtn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 12:21:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <346361be-ce30-6a13-c154-5192d2668723@xenosoft.de>
 <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
From: mad skateman <madskateman@gmail.com>
Date: Mon, 15 Jan 2018 21:21:11 +0100
Message-ID: <CAHkrCmH469HxmRSH1nUpd4VwgCC0BTZk_+_VB_q5-g-x36ixew@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I have been testing with the rc8 kernel as Christian sugested.

At this moment still the same issues..

Here some of my finding...

A dump of dmesg regarding the FSL_DPAA:

[    4.597949] libphy: Fixed MDIO Bus: probed
[    4.599095] libphy: Freescale PowerQUICC MII Bus: probed
[    4.609108] libphy: Freescale PowerQUICC MII Bus: probed
[    4.609995] libphy: Freescale PowerQUICC MII Bus: probed
[    4.610689] libphy: Freescale PowerQUICC MII Bus: probed
[    4.611623] libphy: Freescale PowerQUICC MII Bus: probed
[    4.612470] libphy: Freescale XGMAC MDIO Bus: probed
[    4.617710] fsl_dpaa_mac ffe4e6000.ethernet: FMan dTSEC version: 0x08240=
101
[    4.618335] fsl_dpaa_mac ffe4e6000.ethernet: FMan MAC address:
00:04:9f:01:02:03
[    4.618653] fsl_dpaa_mac ffe4e8000.ethernet: FMan dTSEC version: 0x08240=
101
[    4.619042] fsl_dpaa_mac ffe4e8000.ethernet: FMan MAC address:
00:04:9f:01:02:04
[    4.619294] fsl_dpaa_mac ffe4e0000.ethernet:
of_get_mac_address(/soc@ffe000000/fman@400000/ethernet@e0000) failed
[    4.619505] fsl_dpaa_mac: probe of ffe4e0000.ethernet failed with error =
-22
[    4.619673] fsl_dpaa_mac ffe4e2000.ethernet:
of_get_mac_address(/soc@ffe000000/fman@400000/ethernet@e2000) failed
[    4.619878] fsl_dpaa_mac: probe of ffe4e2000.ethernet failed with error =
-22
[    4.620048] fsl_dpaa_mac ffe4e4000.ethernet:
of_get_mac_address(/soc@ffe000000/fman@400000/ethernet@e4000) failed
[    4.620258] fsl_dpaa_mac: probe of ffe4e4000.ethernet failed with error =
-22
[    4.625078] fsl_dpaa_mac ffe4f0000.ethernet:
of_get_mac_address(/soc@ffe000000/fman@400000/ethernet@f0000) failed
[    4.630001] fsl_dpaa_mac: probe of ffe4f0000.ethernet failed with error =
-22
[    4.637015] fsl_dpaa_mac ffe4e6000.ethernet eth0: Probed interface eth0
[    4.643933] fsl_dpaa_mac ffe4e8000.ethernet eth1: Probed interface eth1

This all seems correct! The probed mac`s are the one`s as put in Uboot:
Ethaddr and Eth1addr

The Eth0 and Eth1 are also probed.

When eth0 is brought up... it is unable to get an ip adress from the
dhcp server.

eth0      Link encap:Ethernet  HWaddr 00:04:9f:01:02:03
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:510 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:102556 (102.5 KB)
          Memory:fe4e6000-fe4e6fff

When using mii-tool for a double check:

mii-tool -l eth0
eth0: negotiated 1000baseT-FD flow-control, link ok

and when using ethtool

ethtool eth0
Settings for eth0:
	Supported ports: [ MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: Yes
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	Advertised pause frame use: Symmetric Receive-only
	Advertised auto-negotiation: Yes
	Link partner advertised link modes:  10baseT/Half 10baseT/Full
	                                     100baseT/Half 100baseT/Full
	                                     1000baseT/Half 1000baseT/Full
	Link partner advertised pause frame use: Symmetric Receive-only
	Link partner advertised auto-negotiation: Yes
	Speed: 1000Mb/s
	Duplex: Full
	Port: MII
	PHYAD: 3
	Transceiver: external
	Auto-negotiation: on
	Current message level: 0x00000037 (55)
			       drv probe link ifdown ifup
	Link detected: yes

RX packets always stay 0 ?

Will continiue to get more info...







On 1/15/18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> Sorry, I have forgotten the download link. Please test it with the DPAA
> Ethernet.
>> Hi All,
>>
>> I compiled the RC8 of kernel 4.15 with Joakim's patch for the AmigaOne
>> X5000 today. Many thanks to Joakim for the mdio patch.
>>
>> Download: http://www.xenosoft.de/uImage-4.15-rc8_with_mdio_patch.tar.gz
>>
>> Please test it on your X5000.
>>
>> Thanks,
>> Christian
>>
>>
>> On 15 January 2018 at 5:59PM, Joakim Tjernlund wrote:
>>>>
>>>> Hi,
>>>>
>>>> Please use text logs instead of pictures next time, it's easier to
>>>> read.
>>>> The errors you see are related to missing MAC addresses for the unused
>>>> interfaces, you can ignore these are they are not relevant for the
>>>> issue
>>>> you encounter. Normally the unused interfaces should have status
>>>> disabled
>>>> in the device tree but there is not a big deal if they fail like that.
>>>> As I've advised Jamie on the other thread, please try to connect the
>>>> device
>>>> back 2 back to a known good machine and determine what is broken -
>>>> Rx/Tx?
>>>> Is there another software version that does work on these machines?
>>> Hi, just saw this and thought of a small patch I just wrote for mdio
>>> bus, o idea
>>> if it is relevant but here goes:
>>>
>>> =C2=A0From fe0b98d54a79779482700676331b4d10a0f3cada Mon Sep 17 00:00:00=
 2001
>>> From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
>>> Date: Sun, 14 Jan 2018 21:27:20 +0100
>>> Subject: [PATCH] of_mdiobus_register: Continue after error
>>>
>>> of_mdiobus_register unregister itself if one phy fails to register
>>> which is bad for system having all its PHYs on the same MDIO bus.
>>> Just log the error and continue with the remaining PHYs instead.
>>>
>>> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
>>> ---
>>> =C2=A0 drivers/of/of_mdio.c | 6 ++++--
>>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>>> index 98258583abb0..76ff28a41dad 100644
>>> --- a/drivers/of/of_mdio.c
>>> +++ b/drivers/of/of_mdio.c
>>> @@ -229,7 +229,8 @@ int of_mdiobus_register(struct mii_bus *mdio,
>>> struct device_node *np)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rc =3D of_mdiobus_register_device(mdio, child, addr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o unregister;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
warn(FW_WARN
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "%pOF: Failed to register MDIO device.\n", child);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!scanphys)
>>> @@ -253,7 +254,8 @@ int of_mdiobus_register(struct mii_bus *mdio,
>>> struct device_node *np)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (of_mdiobus_child_is_phy(child)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D of_mdiobus_register_phy(mdio, chil=
d, addr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unregister;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn(FW_WARN
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%pOF=
: Failed to register MDIO PHY.\n", child);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>
>
>

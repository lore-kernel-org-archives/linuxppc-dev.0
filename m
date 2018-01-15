Return-Path: <madskateman@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL64z0qJ8zF0Xw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 08:32:18 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id l29so8933799qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 13:32:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <346361be-ce30-6a13-c154-5192d2668723@xenosoft.de>
 <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
From: mad skateman <madskateman@gmail.com>
Date: Mon, 15 Jan 2018 22:32:14 +0100
Message-ID: <CAHkrCmFwMRh7+9ijRhgpqm_dQmE7uH8pv8ZQvLY1rxk1hjhfzw@mail.gmail.com>
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

Some extra info:

When Ubuntu boots, Eth0 (192.168.22.44) is not brought up automaticly..

When i bring up eth0 by hand, its still not active..

root@X5000LNX:/home/skateman# ifconfig eth0 up
root@X5000LNX:/home/skateman# ping 192.168.22.44
connect: Network is unreachable

When i use mii-tool too Kick the tranceiver... it comes alive.. i can
ping the eth0 itself

root@X5000LNX:/home/skateman# mii-tool -R eth0
resetting the transceiver...
root@X5000LNX:/home/skateman# ping 192.168.22.44
PING 192.168.22.44 (192.168.22.44) 56(84) bytes of data.
64 bytes from 192.168.22.44: icmp_seq=3D1 ttl=3D64 time=3D0.045 ms
64 bytes from 192.168.22.44: icmp_seq=3D2 ttl=3D64 time=3D0.046 ms
64 bytes from 192.168.22.44: icmp_seq=3D3 ttl=3D64 time=3D0.047 ms
64 bytes from 192.168.22.44: icmp_seq=3D4 ttl=3D64 time=3D0.048 ms

eth0      Link encap:Ethernet  HWaddr 00:04:9f:01:02:03
          inet addr:192.168.22.44  Bcast:192.168.22.255  Mask:255.255.255.0
          inet6 addr: fe80::c84b:9f6b:f2f6:8933/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:7600 (7.6 KB)
          Memory:fe4e6000-fe4e6fff

Not realy sure why the Tranceiver is not brought up directly when linux sta=
rts..



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

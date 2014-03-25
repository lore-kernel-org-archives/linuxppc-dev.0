Return-Path: <zyjzyj2000@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A6CB140092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 16:08:54 +1100 (EST)
Received: by mail-yk0-f175.google.com with SMTP id 131so17442218ykp.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 22:08:49 -0700 (PDT)
Message-ID: <53310F4E.4080104@gmail.com>
Date: Tue, 25 Mar 2014 13:08:30 +0800
From: zhuyj <zyjzyj2000@gmail.com>
MIME-Version: 1.0
To: sandeep.kumar@freescale.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Tao, Yue" <Yue.Tao@windriver.com>,
 "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
 guang.yang@windriver.com, zhuyj <zyjzyj2000@gmail.com>, joe@perches.com,
 festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
 richardcochran@gmail.com, clarocq@gmail.com, yongjun_wei@trendmicro.com.cn
Subject: on kernel 2.6.34.15, vlan and raw packets can not be received with
 gfar-enet nic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Sandeep Gopalpet

I am a developer. Now I confronted an interesting phenomena. When I used 
linux kernel 2.6.34.15 on freescale-p2020, I can not receive raw and 
vlan packets on gfar-enet nic. But with e1000e nic, we can make vlan and 
raw packets work well. I looked into the source code and find that maybe 
it is related with hardware insert and remove vlan head. But I have no 
the specifications of gfar-enet nic. Would you like to give some 
document or some guides?

Thanks a lot.
Zhu Yanjun

The steps are as below.

1. I boot two freescale-p2020 boards with linux kernel 2.6.34.15, then I 
connected 2 gfar-enet nic cards with a direct network line;

2. On board 1, I checked the driver of eth0

ethtool -i eth0

driver: gfar-enet
version: 1.3
firmware-version: N/A
bus-info: N/A

On board 2, I checked the driver of eth1

ethtool -i eth1

driver: gfar-enet
version: 1.3
firmware-version: N/A
bus-info: N/A

3. Then I configure the ip address on the above 2 nic cards.

On board 1,

ifconfig eth0 192.168.1.13/24 up

On board 2,

ifconfig eth1 192.168.1.196/24 up

4. We can access the other board on one board.
For example, on board 1, we can ping board 2.

root@p2020rdb:/root> ping 192.168.1.196
PING 192.168.1.196 (192.168.1.196) 56(84) bytes of data.
64 bytes from 192.168.1.196: icmp_req=1 ttl=64 time=2.92 ms
64 bytes from 192.168.1.196: icmp_req=2 ttl=64 time=0.096 ms

5. We configure vlan on these 2 boards.
On board 1,

modprobe 8021q
vconfig add eth0 4091
ifconfig eth0.4091 10.1.1.13/24 up

On board 2,

modprobe 8021q
vconfig add eth1 4091
ifconfig eth1.4091 10.1.1.196/24 up

6. We can access the other board on one board through vlan.
For example, on board 1, we can ping board 2 through vlan nic.

root@p2020rdb:/root> ping 10.1.1.196
PING 10.1.1.196 (10.1.1.196) 56(84) bytes of data.
64 bytes from 10.1.1.196: icmp_req=1 ttl=64 time=2.92 ms
64 bytes from 10.1.1.196: icmp_req=2 ttl=64 time=0.096 ms

But we can not access the other board on one board through raw nic.
For example, on board, we can not ping board 2.

root@p2020rdb:/root> ping 192.168.1.196
 From 192.168.1.196 icmp_seq=1 Destination Host Unreachable
 From 192.168.1.196 icmp_seq=2 Destination Host Unreachable
 From 192.168.1.196 icmp_seq=3 Destination Host Unreachable

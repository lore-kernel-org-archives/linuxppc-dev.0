Return-Path: <edumazet@google.com>
Received: from mail-it0-x231.google.com (mail-it0-x231.google.com
 [IPv6:2607:f8b0:4001:c0b::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHZcP733rzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 17:46:13 +1100 (AEDT)
Received: by mail-it0-x231.google.com with SMTP id c7so73109027itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 22:46:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4206026c-f659-d690-b6b2-31d1cedf55cb@linux.vnet.ibm.com>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
 <1485981445.4850.8.camel@kernel.crashing.org>
 <87y3xpb5li.fsf@concordia.ellerman.id.au>
 <CANn89iKVtGt=mL32BVryzSCHcuNR93jO+GzR+pgr-1NHast26g@mail.gmail.com>
 <4206026c-f659-d690-b6b2-31d1cedf55cb@linux.vnet.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Feb 2017 22:46:10 -0800
Message-ID: <CANn89iJKKc80MO2Ysz_c-_-XerUUk01Fe5Pn59r7zRTUMtpZfA@mail.gmail.com>
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
To: panxinhui <xinhui@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Dumazet <eric.dumazet@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Kevin Hao <haokexin@gmail.com>, Torsten Duwe <duwe@suse.de>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 6, 2017 at 10:21 PM, panxinhui <xinhui@linux.vnet.ibm.com> wrote:

> hi all
>         I do some netperf tests and get some benchmark results.
> I also attach my test script and netperf-result(Excel)
>
> There are two machine. one runs netserver and the other runs netperf
> benchmark. 1000Mbps network is connected with them.
>
> #ip link infomation
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
> UNKNOWN mode DEFAULT group default qlen 1000
>      link/ether ba:68:9c:14:32:02 brd ff:ff:ff:ff:ff:ff
>
> According to the results, there is not much performance gap with each other.
> And as we are only testing the throughput, the pvqspinlock shows the
> overhead of its pv stuff. but qspinlock shows a little improvement than
> spinlock. My simple summary in this testcase is
> qspinlock > spinlock > pvqspinlock.
>
> when run 200 concurrent netperf, I paste the total throughput here.
>
>         concurrent runners| total throughput | variance
> -------------------------------------------
> spinlock        | 199 | 66882.8 | 89.93
> -------------------------------------------
> qspinlock       | 199 | 66350.4 | 72.0239
> -------------------------------------------
> pvqspinlock     | 199 | 64740.5 | 85.7837
>
> You could see more data in nerperf.xlsx
>
> thanks
> xinhui


Hi xinhui

1Gbit NIC is too slow for this use case. I would try a 10Gbit NIC at least...

Alternatively, you could use loopback interface.  (netperf -H 127.0.0.1)

tc qd add dev lo root pfifo limit 10000

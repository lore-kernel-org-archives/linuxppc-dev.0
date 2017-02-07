Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHbQH2fkgzDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 18:22:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v177If6I027203
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 02:22:29 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28eupseg1t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 02:22:29 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 00:22:28 -0700
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
To: Eric Dumazet <edumazet@google.com>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
 <1485981445.4850.8.camel@kernel.crashing.org>
 <87y3xpb5li.fsf@concordia.ellerman.id.au>
 <CANn89iKVtGt=mL32BVryzSCHcuNR93jO+GzR+pgr-1NHast26g@mail.gmail.com>
 <4206026c-f659-d690-b6b2-31d1cedf55cb@linux.vnet.ibm.com>
 <CANn89iJKKc80MO2Ysz_c-_-XerUUk01Fe5Pn59r7zRTUMtpZfA@mail.gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Kevin Hao <haokexin@gmail.com>, Torsten Duwe <duwe@suse.de>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
From: panxinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 7 Feb 2017 15:22:18 +0800
MIME-Version: 1.0
In-Reply-To: <CANn89iJKKc80MO2Ysz_c-_-XerUUk01Fe5Pn59r7zRTUMtpZfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bdba3d9b-bdb8-e95a-99d5-285bca3c17cb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2017/2/7 下午2:46, Eric Dumazet 写道:
> On Mon, Feb 6, 2017 at 10:21 PM, panxinhui <xinhui@linux.vnet.ibm.com> wrote:
>
>> hi all
>>         I do some netperf tests and get some benchmark results.
>> I also attach my test script and netperf-result(Excel)
>>
>> There are two machine. one runs netserver and the other runs netperf
>> benchmark. 1000Mbps network is connected with them.
>>
>> #ip link infomation
>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
>> UNKNOWN mode DEFAULT group default qlen 1000
>>      link/ether ba:68:9c:14:32:02 brd ff:ff:ff:ff:ff:ff
>>
>> According to the results, there is not much performance gap with each other.
>> And as we are only testing the throughput, the pvqspinlock shows the
>> overhead of its pv stuff. but qspinlock shows a little improvement than
>> spinlock. My simple summary in this testcase is
>> qspinlock > spinlock > pvqspinlock.
>>
>> when run 200 concurrent netperf, I paste the total throughput here.
>>
>>         concurrent runners| total throughput | variance
>> -------------------------------------------
>> spinlock        | 199 | 66882.8 | 89.93
>> -------------------------------------------
>> qspinlock       | 199 | 66350.4 | 72.0239
>> -------------------------------------------
>> pvqspinlock     | 199 | 64740.5 | 85.7837
>>
>> You could see more data in nerperf.xlsx
>>
>> thanks
>> xinhui
>
>
> Hi xinhui
>
> 1Gbit NIC is too slow for this use case. I would try a 10Gbit NIC at least...
>
> Alternatively, you could use loopback interface.  (netperf -H 127.0.0.1)
>
> tc qd add dev lo root pfifo limit 10000
>

great, thanks
xinhui

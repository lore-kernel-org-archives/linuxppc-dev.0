Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGyDJ2B0tzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 22:27:12 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id d193so14344968pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:27:12 -0700 (PDT)
Date: Tue, 25 Jul 2017 22:26:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <linux-arm-kernel@lists.infradead.org>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, <linuxarm@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Don Zickus
 <dzickus@redhat.com>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n  - any one
 else seeing this?
Message-ID: <20170725222654.5a968588@roar.ozlabs.ibm.com>
In-Reply-To: <20170725193039.00007c80@huawei.com>
References: <20170725193039.00007c80@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Jul 2017 19:32:10 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Hi All,
> 
> We observed a regression on our d05 boards (but curiously not
> the fairly similar but single socket / smaller core count
> d03), initially seen with linux-next prior to the merge window
> and still present in v4.13-rc2.
> 
> The symptom is:
> 
> [ 1982.959365] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1982.965021] 	2-...: (10 GPs behind) idle=1d4/0/0 softirq=306/306 fqs=0 
> [ 1982.971624] 	3-...: (2 GPs behind) idle=700/0/0 softirq=307/307 fqs=0 
> [ 1982.978139] 	4-...: (20 GPs behind) idle=9f4/0/0 softirq=651/652 fqs=0 
> [ 1982.984740] 	5-...: (18 GPs behind) idle=a78/0/0 softirq=369/371 fqs=0 
> [ 1982.991342] 	6-...: (26 GPs behind) idle=e5c/0/0 softirq=217/219 fqs=0 
> [ 1982.997944] 	7-...: (1438 GPs behind) idle=eb4/0/0 softirq=260/260 fqs=0 
> [ 1983.004719] 	8-...: (18 GPs behind) idle=830/0/0 softirq=1609/1609 fqs=0 
> [ 1983.011494] 	9-...: (18 GPs behind) idle=e9c/0/0 softirq=242/242 fqs=0 
> [ 1983.018095] 	10-...: (1434 GPs behind) idle=ca0/0/0 softirq=210/212 fqs=0 
> [ 1983.024957] 	11-...: (1106 GPs behind) idle=ee0/0/0 softirq=188/191 fqs=0 
> [ 1983.031819] 	12-...: (1636 GPs behind) idle=c58/0/0 softirq=215/216 fqs=0 
> [ 1983.038680] 	13-...: (1114 GPs behind) idle=c20/0/0 softirq=170/170 fqs=0 
> [ 1983.045542] 	14-...: (1106 GPs behind) idle=d90/0/0 softirq=176/178 fqs=0 
> [ 1983.052403] 	15-...: (1858 GPs behind) idle=900/0/0 softirq=184/185 fqs=0 
> [ 1983.059266] 	16-...: (1621 GPs behind) idle=f04/0/0 softirq=204/206 fqs=0 
> [ 1983.066127] 	17-...: (1433 GPs behind) idle=d30/0/0 softirq=202/202 fqs=0 
> [ 1983.072988] 	18-...: (18 GPs behind) idle=2d4/0/0 softirq=218/220 fqs=0 
> [ 1983.079676] 	19-...: (19 GPs behind) idle=bbc/0/0 softirq=178/180 fqs=0 
> [ 1983.086364] 	20-...: (0 ticks this GP) idle=ee0/0/0 softirq=231/231 fqs=0 
> [ 1983.093226] 	21-...: (4 GPs behind) idle=140/0/0 softirq=208/208 fqs=0 
> [ 1983.099827] 	22-...: (5 GPs behind) idle=100/0/0 softirq=186/188 fqs=0 
> [ 1983.106428] 	23-...: (1635 GPs behind) idle=fd4/0/0 softirq=1220/1221 fqs=0 
> [ 1983.113463] 	24-...: (1112 GPs behind) idle=ca8/0/0 softirq=231/233 fqs=0 
> [ 1983.120325] 	25-...: (1637 GPs behind) idle=9c4/0/0 softirq=164/166 fqs=0 
> [ 1983.127187] 	27-...: (0 ticks this GP) idle=b08/0/0 softirq=182/182 fqs=0 
> [ 1983.134048] 	28-...: (1110 GPs behind) idle=d28/0/0 softirq=179/181 fqs=0 
> [ 1983.140909] 	29-...: (8 GPs behind) idle=1dc/0/0 softirq=196/198 fqs=0 
> [ 1983.147511] 	31-...: (1434 GPs behind) idle=74c/0/0 softirq=160/161 fqs=0 
> [ 1983.154373] 	32-...: (1432 GPs behind) idle=7d4/0/0 softirq=164/164 fqs=0 
> [ 1983.161234] 	33-...: (1632 GPs behind) idle=4dc/0/0 softirq=130/132 fqs=0 
> [ 1983.168096] 	34-...: (57 GPs behind) idle=3b0/0/0 softirq=411/411 fqs=0 
> [ 1983.174784] 	35-...: (1599 GPs behind) idle=8a0/0/0 softirq=177/179 fqs=0 
> [ 1983.181646] 	36-...: (1603 GPs behind) idle=520/0/0 softirq=132/134 fqs=0 
> [ 1983.188507] 	37-...: (8 GPs behind) idle=02c/0/0 softirq=176/178 fqs=0 
> [ 1983.195108] 	38-...: (1442 GPs behind) idle=d8c/0/0 softirq=3189/3190 fqs=0 
> [ 1983.202144] 	39-...: (1431 GPs behind) idle=444/0/0 softirq=117/117 fqs=0 
> [ 1983.209005] 	40-...: (4 GPs behind) idle=688/0/0 softirq=134/136 fqs=0 
> [ 1983.215606] 	41-...: (1599 GPs behind) idle=554/0/0 softirq=2707/2711 fqs=0 
> [ 1983.222642] 	42-...: (1430 GPs behind) idle=15c/0/0 softirq=110/111 fqs=0 
> [ 1983.229503] 	43-...: (4 GPs behind) idle=054/0/0 softirq=101/103 fqs=0 
> [ 1983.236104] 	46-...: (1117 GPs behind) idle=558/0/0 softirq=251/253 fqs=0 
> [ 1983.242966] 	47-...: (1118 GPs behind) idle=5f0/0/0 softirq=110/112 fqs=0 
> [ 1983.249827] 	48-...: (1621 GPs behind) idle=ef4/0/0 softirq=241/242 fqs=0 
> [ 1983.256689] 	49-...: (1648 GPs behind) idle=92c/0/0 softirq=207/208 fqs=0 
> [ 1983.263550] 	52-...: (1439 GPs behind) idle=e40/0/0 softirq=261/263 fqs=0 
> [ 1983.270412] 	54-...: (1434 GPs behind) idle=650/0/0 softirq=258/260 fqs=0 
> [ 1983.277273] 	55-...: (1646 GPs behind) idle=5e0/0/0 softirq=178/178 fqs=0 
> [ 1983.284135] 	56-...: (1646 GPs behind) idle=800/0/0 softirq=249/249 fqs=0 
> [ 1983.290996] 	57-...: (1599 GPs behind) idle=c48/0/0 softirq=222/224 fqs=0 
> [ 1983.297858] 	58-...: (1648 GPs behind) idle=3e8/0/0 softirq=235/235 fqs=0 
> [ 1983.304719] 	59-...: (1434 GPs behind) idle=720/0/0 softirq=201/203 fqs=0 
> [ 1983.311581] 	60-...: (1647 GPs behind) idle=c80/0/0 softirq=250/250 fqs=0 
> [ 1983.318443] 	61-...: (1598 GPs behind) idle=b18/0/0 softirq=208/208 fqs=0 
> [ 1983.325304] 	62-...: (1112 GPs behind) idle=0a4/0/0 softirq=620/620 fqs=0 
> [ 1983.332166] 	63-...: (1109 GPs behind) idle=4b0/0/0 softirq=187/188 fqs=0 
> [ 1983.339026] 	(detected by 44, t=5335 jiffies, g=1566, c=1565, q=220)
> [ 1983.345371] Task dump for CPU 2:
> [ 1983.348587] swapper/2       R  running task        0     0      1 0x00000000
> [ 1983.355626] Call trace:
> [ 1983.358072] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1983.363199] [<7fffffffffffffff>] 0x7fffffffffffffff
> [ 1983.368062] Task dump for CPU 3:
> [ 1983.371278] swapper/3       R  running task        0     0      1 0x00000000
> [ 1983.378315] Call trace:
> [ 1983.380750] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1983.385881] [<ffff000008ea9000>] page_wait_table+0x1280/0x1800
> [ 1983.391699] Task dump for CPU 4:
> [ 1983.394915] swapper/4       R  running task        0     0      1 0x00000000
> [ 1983.401951] Call trace:
> [ 1983.404386] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1983.409510] [<7fffffffffffffff>] 0x7fffffffffffffff
> [ 1983.414374] Task dump for CPU 5:
> [ 1983.417590] swapper/5       R  running task        0     0      1 0x00000000
> [ 1983.424626] Call trace:
> [ 1983.427060] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1983.432185] [<7fffffffffffffff>] 0x7fffffffffffffff
> [ 1983.437049] Task dump for CPU 6:
> [ 1983.440265] swapper/6       R  running task        0     0      1 0x00000000
> 
> <snip>  Mixture of the two forms above for all the cpus
> 
> [ 1984.568746] Call trace:
> [ 1984.571180] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1984.576305] [<ffff000008ea9000>] page_wait_table+0x1280/0x1800
> [ 1984.582124] Task dump for CPU 62:
> [ 1984.585426] swapper/62      R  running task        0     0      1 0x00000000
> [ 1984.592461] Call trace:
> [ 1984.594895] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1984.600020] [<ffff000008ea9000>] page_wait_table+0x1280/0x1800
> [ 1984.605839] Task dump for CPU 63:
> [ 1984.609141] swapper/63      R  running task        0     0      1 0x00000000
> [ 1984.616176] Call trace:
> [ 1984.618611] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1984.623735] [<7fffffffffffffff>] 0x7fffffffffffffff
> [ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> [ 1984.638153] rcu_preempt     S    0     9      2 0x00000000
> [ 1984.643626] Call trace:
> [ 1984.646059] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1984.651189] [<ffff000008962274>] __schedule+0x19c/0x5d8
> [ 1984.656400] [<ffff0000089626e8>] schedule+0x38/0xa0
> [ 1984.661266] [<ffff000008965844>] schedule_timeout+0x124/0x218
> [ 1984.667002] [<ffff000008121424>] rcu_gp_kthread+0x4fc/0x748
> [ 1984.672564] [<ffff0000080df0b4>] kthread+0xfc/0x128
> [ 1984.677429] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
> 
> 
> Reducing the RCU CPU stall timeout makes it happen more often,
> but we are seeing even with the default value of 24 seconds.
> 
> Tends to occur after a period or relatively low usage, but has
> also been seen mid way through performance tests.
> 
> This was not seen with v4.12 so a bisection run later lead to
> commit 05a4a9527 (kernel/watchdog: split up config options).
> 
> Which was odd until we discovered that a side effect of this patch
> was to change whether the softlockup detector was enabled or not in
> the arm64 defconfig.
> 
> On 4.13-rc2 enabling the softlockup detector indeed stopped us
> seeing the rcu issue. Disabling the equivalent on 4.12 made the
> issue occur there as well.
> 
> Clearly the softlockup detector results in a thread on every cpu,
> which might be related but beyond that we are still looking into
> the issue.
> 
> So the obvious question is whether anyone else is seeing this as
> it might help us to focus in on where to look!

Huh. Something similar has been seen very intermittently on powerpc
as well. We couldn't reproduce it reliably to bisect it already, so
this is a good help.

http://marc.info/?l=linuxppc-embedded&m=149872815523646&w=2

It looks like the watchdog patch has a similar effect on powerpc in
that it stops enabling the softlockup detector by default. Haven't
confirmed, but it looks like the same thing.

A bug in RCU stall detection?

> 
> In the meantime we'll carry on digging.
> 
> Thanks,
> 
> Jonathan
> 
> p.s. As a more general question, do we want to have the
> soft lockup detector enabledon arm64 by default?

I've cc'ed Don. My patch should not have changed defconfigs, I
should have been more careful with that.

Thanks,
Nick

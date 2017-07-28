Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJq1K3BVGzDrRl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 23:09:09 +1000 (AEST)
Date: Fri, 28 Jul 2017 14:08:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, <abdhalee@linux.vnet.ibm.com>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170728140325.00003b64@huawei.com>
In-Reply-To: <20170728084411.00001ddb@huawei.com>
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 28 Jul 2017 08:44:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Jul 2017 09:52:45 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Thu, Jul 27, 2017 at 05:39:23PM +0100, Jonathan Cameron wrote:  
> > > On Thu, 27 Jul 2017 14:49:03 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >     
> > > > On Thu, 27 Jul 2017 05:49:13 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >     
> > > > > On Thu, Jul 27, 2017 at 02:34:00PM +1000, Nicholas Piggin wrote:      
> > > > > > On Wed, 26 Jul 2017 18:42:14 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >         
> > > > > > > On Wed, Jul 26, 2017 at 04:22:00PM -0700, David Miller wrote:        
> > > > > >         
> > > > > > > > Indeed, that really wouldn't explain how we end up with a RCU stall
> > > > > > > > dump listing almost all of the cpus as having missed a grace period.          
> > > > > > > 
> > > > > > > I have seen stranger things, but admittedly not often.        
> > > > > > 
> > > > > > So the backtraces show the RCU gp thread in schedule_timeout.
> > > > > > 
> > > > > > Are you sure that it's timeout has expired and it's not being scheduled,
> > > > > > or could it be a bad (large) timeout (looks unlikely) or that it's being
> > > > > > scheduled but not correctly noting gps on other CPUs?
> > > > > > 
> > > > > > It's not in R state, so if it's not being scheduled at all, then it's
> > > > > > because the timer has not fired:        
> > > > > 
> > > > > Good point, Nick!
> > > > > 
> > > > > Jonathan, could you please reproduce collecting timer event tracing?      
> > > > I'm a little new to tracing (only started playing with it last week)
> > > > so fingers crossed I've set it up right.  No splats yet.  Was getting
> > > > splats on reading out the trace when running with the RCU stall timer
> > > > set to 4 so have increased that back to the default and am rerunning.
> > > > 
> > > > This may take a while.  Correct me if I've gotten this wrong to save time
> > > > 
> > > > echo "timer:*" > /sys/kernel/debug/tracing/set_event
> > > > 
> > > > when it dumps, just send you the relevant part of what is in
> > > > /sys/kernel/debug/tracing/trace?    
> > > 
> > > Interestingly the only thing that can make trip for me with tracing on
> > > is peaking in the tracing buffers.  Not sure this is a valid case or
> > > not.
> > > 
> > > Anyhow all timer activity seems to stop around the area of interest.
> > > 

In the interests of tidier traces with less other stuff in them I disable
usb and the sas driver (which were responsible for most of the hrtimer events).
Problem just became a whole lot easier to trigger.  Happening ever few minutes
if I do pretty much anything on the machine at all.

Running with CONFIG_RCU_CPU_STALL_TIMEOUT=8 (left over from trying
to get it to trigger more often before disabling usb and sas).

No sign of the massive gap. I'm thinking that was related to the
trace buffer readout.

More long logs I'm afraid:

[  775.760469] random: crng init done
[  835.595087] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  835.600740] 	2-...: (11 GPs behind) idle=d60/0/0 softirq=368/369 fqs=0 last_accelerate: fae9/0968, nonlazy_posted: 0, L.
[  835.611595] 	3-...: (14 GPs behind) idle=0b0/0/0 softirq=238/238 fqs=0 last_accelerate: f91c/096c, nonlazy_posted: 0, L.
[  835.622450] 	4-...: (17 GPs behind) idle=464/0/0 softirq=230/234 fqs=0 last_accelerate: 01f5/096c, nonlazy_posted: 0, L.
[  835.633305] 	5-...: (17 GPs behind) idle=f4c/0/0 softirq=210/212 fqs=0 last_accelerate: 01f3/0970, nonlazy_posted: 0, L.
[  835.644159] 	6-...: (128 GPs behind) idle=e7c/0/0 softirq=218/219 fqs=0 last_accelerate: 587f/0974, nonlazy_posted: 0, L.
[  835.655099] 	7-...: (128 GPs behind) idle=e40/0/0 softirq=214/217 fqs=0 last_accelerate: 587f/0974, nonlazy_posted: 0, L.
[  835.666040] 	8-...: (109 GPs behind) idle=e20/0/0 softirq=212/212 fqs=0 last_accelerate: 587f/0978, nonlazy_posted: 0, L.
[  835.676981] 	9-...: (128 GPs behind) idle=d70/0/0 softirq=195/196 fqs=0 last_accelerate: 587f/097c, nonlazy_posted: 0, L.
[  835.687921] 	10-...: (130 GPs behind) idle=b98/0/0 softirq=429/431 fqs=0 last_accelerate: 587f/097c, nonlazy_posted: 0, L.
[  835.698949] 	11-...: (128 GPs behind) idle=d10/0/0 softirq=190/190 fqs=0 last_accelerate: 587f/0980, nonlazy_posted: 0, L.
[  835.709976] 	12-...: (108 GPs behind) idle=d60/0/0 softirq=201/202 fqs=0 last_accelerate: 587f/0984, nonlazy_posted: 0, L.
[  835.721003] 	13-...: (103 GPs behind) idle=5b4/0/0 softirq=200/200 fqs=0 last_accelerate: 587f/0984, nonlazy_posted: 0, L.
[  835.732031] 	14-...: (128 GPs behind) idle=b44/0/0 softirq=185/185 fqs=0 last_accelerate: 587f/0988, nonlazy_posted: 0, L.
[  835.743058] 	15-...: (128 GPs behind) idle=c1c/0/0 softirq=196/197 fqs=0 last_accelerate: 587f/098c, nonlazy_posted: 0, L.
[  835.754086] 	16-...: (29 GPs behind) idle=37c/0/0 softirq=205/205 fqs=0 last_accelerate: dff1/098c, nonlazy_posted: 0, L.
[  835.765026] 	17-...: (8 GPs behind) idle=b08/0/0 softirq=201/203 fqs=0 last_accelerate: fabc/0990, nonlazy_posted: 0, L.
[  835.775880] 	19-...: (0 ticks this GP) idle=994/0/0 softirq=175/175 fqs=0 last_accelerate: 0194/0994, nonlazy_posted: 0, L.
[  835.786994] 	20-...: (59 GPs behind) idle=984/0/0 softirq=185/185 fqs=0 last_accelerate: e5dc/0994, nonlazy_posted: 0, L.
[  835.797935] 	21-...: (6 GPs behind) idle=8e4/0/0 softirq=176/178 fqs=0 last_accelerate: fd08/0998, nonlazy_posted: 0, L.
[  835.808789] 	23-...: (112 GPs behind) idle=7e0/0/0 softirq=166/168 fqs=0 last_accelerate: 587f/099c, nonlazy_posted: 0, L.
[  835.819816] 	24-...: (103 GPs behind) idle=e4c/0/0 softirq=168/168 fqs=0 last_accelerate: 587f/09a0, nonlazy_posted: 0, L.
[  835.830843] 	25-...: (20 GPs behind) idle=930/0/0 softirq=1303/1303 fqs=0 last_accelerate: edf1/09a0, nonlazy_posted: 0, L.
[  835.841958] 	26-...: (4 GPs behind) idle=6d8/0/0 softirq=178/180 fqs=0 last_accelerate: fd08/09a4, nonlazy_posted: 0, L.
[  835.852812] 	27-...: (60 GPs behind) idle=8a8/0/0 softirq=183/183 fqs=0 last_accelerate: e5dc/09a8, nonlazy_posted: 0, L.
[  835.863752] 	28-...: (3 GPs behind) idle=6c4/0/0 softirq=167/168 fqs=0 last_accelerate: fe00/09a8, nonlazy_posted: 0, L.
[  835.874606] 	29-...: (57 GPs behind) idle=588/0/0 softirq=152/153 fqs=0 last_accelerate: e7d4/09ac, nonlazy_posted: 0, L.
[  835.885547] 	30-...: (10 GPs behind) idle=5cc/0/0 softirq=161/163 fqs=0 last_accelerate: f9f8/09b0, nonlazy_posted: 0, L.
[  835.896488] 	31-...: (1 GPs behind) idle=5f8/0/0 softirq=246/248 fqs=0 last_accelerate: fe18/09b0, nonlazy_posted: 0, L.
[  835.907342] 	32-...: (102 GPs behind) idle=998/0/0 softirq=158/159 fqs=0 last_accelerate: 587f/09b4, nonlazy_posted: 0, L.
[  835.918369] 	33-...: (102 GPs behind) idle=7f4/0/0 softirq=141/141 fqs=0 last_accelerate: 587f/09b8, nonlazy_posted: 0, L.
[  835.929397] 	35-...: (146 GPs behind) idle=400/0/0 softirq=142/143 fqs=0 last_accelerate: 587f/09b8, nonlazy_posted: 0, L.
[  835.940425] 	36-...: (39 GPs behind) idle=424/0/0 softirq=115/115 fqs=0 last_accelerate: 01f5/09bc, nonlazy_posted: 0, L.
[  835.951366] 	37-...: (38 GPs behind) idle=400/0/0 softirq=126/128 fqs=0 last_accelerate: fdd4/09c0, nonlazy_posted: 0, L.
[  835.962307] 	38-...: (17 GPs behind) idle=5b4/0/0 softirq=139/142 fqs=0 last_accelerate: d804/09c0, nonlazy_posted: 0, L.
[  835.973247] 	39-...: (17 GPs behind) idle=104/0/0 softirq=110/110 fqs=0 last_accelerate: 01f8/09c4, nonlazy_posted: 0, L.
[  835.984188] 	40-...: (150 GPs behind) idle=098/0/0 softirq=107/110 fqs=0 last_accelerate: 587f/09c8, nonlazy_posted: 0, L.
[  835.995216] 	41-...: (145 GPs behind) idle=038/0/0 softirq=102/103 fqs=0 last_accelerate: 587f/09cc, nonlazy_posted: 0, L.
[  836.006243] 	42-...: (147 GPs behind) idle=fa8/0/0 softirq=94/94 fqs=0 last_accelerate: 587f/09cc, nonlazy_posted: 0, L.
[  836.017097] 	43-...: (145 GPs behind) idle=f68/0/0 softirq=98/98 fqs=0 last_accelerate: 587f/09d0, nonlazy_posted: 0, L.
[  836.027951] 	44-...: (147 GPs behind) idle=f98/0/0 softirq=90/90 fqs=0 last_accelerate: 587f/09d4, nonlazy_posted: 0, L.
[  836.038805] 	45-...: (147 GPs behind) idle=f44/0/0 softirq=76/77 fqs=0 last_accelerate: 587f/09d4, nonlazy_posted: 0, L.
[  836.049658] 	46-...: (147 GPs behind) idle=f3c/0/0 softirq=77/77 fqs=0 last_accelerate: 587f/09d8, nonlazy_posted: 0, L.
[  836.060513] 	47-...: (146 GPs behind) idle=e60/0/0 softirq=77/78 fqs=0 last_accelerate: 587f/09dc, nonlazy_posted: 0, L.
[  836.071367] 	48-...: (49 GPs behind) idle=e10/0/0 softirq=78/80 fqs=0 last_accelerate: ef2c/09dc, nonlazy_posted: 0, L.
[  836.082134] 	49-...: (34 GPs behind) idle=dd4/0/0 softirq=72/72 fqs=0 last_accelerate: d805/09e0, nonlazy_posted: 0, L.
[  836.092902] 	50-...: (147 GPs behind) idle=c20/0/0 softirq=58/60 fqs=0 last_accelerate: 587f/09e4, nonlazy_posted: 0, L.
[  836.103756] 	51-...: (145 GPs behind) idle=bf4/0/0 softirq=63/63 fqs=0 last_accelerate: 587f/09e4, nonlazy_posted: 0, L.
[  836.114610] 	52-...: (47 GPs behind) idle=bf0/0/0 softirq=55/56 fqs=0 last_accelerate: f25c/09e8, nonlazy_posted: 0, L.
[  836.125377] 	53-...: (31 GPs behind) idle=ca8/0/0 softirq=51/53 fqs=0 last_accelerate: 03ea/09ec, nonlazy_posted: 0, L.
[  836.136144] 	54-...: (33 GPs behind) idle=c5c/0/0 softirq=54/54 fqs=0 last_accelerate: aff0/09ec, nonlazy_posted: 0, L.
[  836.146912] 	55-...: (146 GPs behind) idle=ab8/0/0 softirq=58/59 fqs=0 last_accelerate: 587f/09f0, nonlazy_posted: 0, L.
[  836.157766] 	56-...: (43 GPs behind) idle=f2c/0/0 softirq=67/67 fqs=0 last_accelerate: f8dc/09f4, nonlazy_posted: 0, L.
[  836.168533] 	57-...: (42 GPs behind) idle=a74/0/0 softirq=48/49 fqs=0 last_accelerate: 7e00/09f4, nonlazy_posted: 0, L.
[  836.179300] 	58-...: (29 GPs behind) idle=f7c/0/0 softirq=60/62 fqs=0 last_accelerate: 05ea/09f8, nonlazy_posted: 0, L.
[  836.190068] 	59-...: (103 GPs behind) idle=cbc/0/0 softirq=48/49 fqs=0 last_accelerate: 587f/09fc, nonlazy_posted: 0, L.
[  836.200921] 	60-...: (40 GPs behind) idle=97c/0/0 softirq=39/39 fqs=0 last_accelerate: fcdc/09fc, nonlazy_posted: 0, L.
[  836.211688] 	61-...: (20 GPs behind) idle=870/0/0 softirq=27/31 fqs=0 last_accelerate: edf5/0a00, nonlazy_posted: 0, L.
[  836.222456] 	62-...: (17 GPs behind) idle=7a8/0/0 softirq=33/34 fqs=0 last_accelerate: 01f3/0a04, nonlazy_posted: 0, L.
[  836.233223] 	63-...: (147 GPs behind) idle=6fc/0/0 softirq=33/35 fqs=0 last_accelerate: 587f/0a04, nonlazy_posted: 0, L.
[  836.244075] 	(detected by 1, t=2164 jiffies, g=112, c=111, q=2706)
[  836.250246] Task dump for CPU 2:
[  836.253460] swapper/2       R  running task        0     0      1 0x00000000
[  836.260496] Call trace:
[  836.262935] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.268062] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[  836.274836] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[  836.280223] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.285694] Task dump for CPU 3:
[  836.288908] swapper/3       R  running task        0     0      1 0x00000000
[  836.295944] Call trace:
[  836.298378] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.303502] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.308973] Task dump for CPU 4:
[  836.312187] swapper/4       R  running task        0     0      1 0x00000000
[  836.319223] Call trace:
[  836.321657] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.326781] [<          (null)>]           (null)
[  836.331470] Task dump for CPU 5:
[  836.334685] swapper/5       R  running task        0     0      1 0x00000000
[  836.341719] Call trace:
[  836.344153] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.349277] [<          (null)>]           (null)
[  836.353967] Task dump for CPU 6:
[  836.357181] swapper/6       R  running task        0     0      1 0x00000000
[  836.364216] Call trace:
[  836.366649] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.371773] [<          (null)>]           (null)
[  836.376463] Task dump for CPU 7:
[  836.379678] swapper/7       R  running task        0     0      1 0x00000000
[  836.386713] Call trace:
[  836.389146] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.394270] [<          (null)>]           (null)
[  836.398959] Task dump for CPU 8:
[  836.402173] swapper/8       R  running task        0     0      1 0x00000000
[  836.409209] Call trace:
[  836.411642] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.416766] [<          (null)>]           (null)
[  836.421455] Task dump for CPU 9:
[  836.424669] swapper/9       R  running task        0     0      1 0x00000000
[  836.431704] Call trace:
[  836.434137] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.439261] [<          (null)>]           (null)
[  836.443951] Task dump for CPU 10:
[  836.447251] swapper/10      R  running task        0     0      1 0x00000000
[  836.454287] Call trace:
[  836.456720] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.461844] [<          (null)>]           (null)
[  836.466533] Task dump for CPU 11:
[  836.469834] swapper/11      R  running task        0     0      1 0x00000000
[  836.476869] Call trace:
[  836.479303] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.484426] [<          (null)>]           (null)
[  836.489116] Task dump for CPU 12:
[  836.492417] swapper/12      R  running task        0     0      1 0x00000000
[  836.499451] Call trace:
[  836.501885] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.507009] [<          (null)>]           (null)
[  836.511698] Task dump for CPU 13:
[  836.514999] swapper/13      R  running task        0     0      1 0x00000000
[  836.522033] Call trace:
[  836.524467] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.529591] [<          (null)>]           (null)
[  836.534280] Task dump for CPU 14:
[  836.537581] swapper/14      R  running task        0     0      1 0x00000000
[  836.544616] Call trace:
[  836.547049] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.552173] [<          (null)>]           (null)
[  836.556863] Task dump for CPU 15:
[  836.560163] swapper/15      R  running task        0     0      1 0x00000000
[  836.567198] Call trace:
[  836.569632] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.574755] [<          (null)>]           (null)
[  836.579445] Task dump for CPU 16:
[  836.582746] swapper/16      R  running task        0     0      1 0x00000000
[  836.589780] Call trace:
[  836.592214] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.597338] [<          (null)>]           (null)
[  836.602027] Task dump for CPU 17:
[  836.605328] swapper/17      R  running task        0     0      1 0x00000000
[  836.612362] Call trace:
[  836.614796] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.619920] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.625391] Task dump for CPU 19:
[  836.628692] swapper/19      R  running task        0     0      1 0x00000000
[  836.635727] Call trace:
[  836.638160] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.643285] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[  836.650059] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[  836.655444] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.660915] Task dump for CPU 20:
[  836.664216] swapper/20      R  running task        0     0      1 0x00000000
[  836.671251] Call trace:
[  836.673684] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.678808] [<          (null)>]           (null)
[  836.683497] Task dump for CPU 21:
[  836.686798] swapper/21      R  running task        0     0      1 0x00000000
[  836.693833] Call trace:
[  836.696266] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.701391] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.706862] Task dump for CPU 23:
[  836.710162] swapper/23      R  running task        0     0      1 0x00000000
[  836.717197] Call trace:
[  836.719631] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.724754] [<          (null)>]           (null)
[  836.729444] Task dump for CPU 24:
[  836.732745] swapper/24      R  running task        0     0      1 0x00000000
[  836.739779] Call trace:
[  836.742213] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.747337] [<          (null)>]           (null)
[  836.752026] Task dump for CPU 25:
[  836.755327] swapper/25      R  running task        0     0      1 0x00000000
[  836.762362] Call trace:
[  836.764795] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.769919] [<          (null)>]           (null)
[  836.774608] Task dump for CPU 26:
[  836.777909] swapper/26      R  running task        0     0      1 0x00000000
[  836.784944] Call trace:
[  836.787377] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.792501] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.797972] Task dump for CPU 27:
[  836.801273] swapper/27      R  running task        0     0      1 0x00000000
[  836.808308] Call trace:
[  836.810741] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.815865] [<          (null)>]           (null)
[  836.820555] Task dump for CPU 28:
[  836.823855] swapper/28      R  running task        0     0      1 0x00000000
[  836.830890] Call trace:
[  836.833323] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.838448] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.843918] Task dump for CPU 29:
[  836.847219] swapper/29      R  running task        0     0      1 0x00000000
[  836.854254] Call trace:
[  836.856687] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.861811] [<          (null)>]           (null)
[  836.866500] Task dump for CPU 30:
[  836.869801] swapper/30      R  running task        0     0      1 0x00000000
[  836.876836] Call trace:
[  836.879269] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.884394] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  836.889865] Task dump for CPU 31:
[  836.893166] swapper/31      R  running task        0     0      1 0x00000000
[  836.900200] Call trace:
[  836.902634] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.907758] [<          (null)>]           (null)
[  836.912447] Task dump for CPU 32:
[  836.915749] swapper/32      R  running task        0     0      1 0x00000000
[  836.922784] Call trace:
[  836.925217] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.930341] [<          (null)>]           (null)
[  836.935031] Task dump for CPU 33:
[  836.938332] swapper/33      R  running task        0     0      1 0x00000000
[  836.945367] Call trace:
[  836.947801] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.952925] [<          (null)>]           (null)
[  836.957614] Task dump for CPU 35:
[  836.960916] swapper/35      R  running task        0     0      1 0x00000000
[  836.967951] Call trace:
[  836.970384] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.975508] [<          (null)>]           (null)
[  836.980198] Task dump for CPU 36:
[  836.983499] swapper/36      R  running task        0     0      1 0x00000000
[  836.990534] Call trace:
[  836.992967] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  836.998091] [<          (null)>]           (null)
[  837.002781] Task dump for CPU 37:
[  837.006082] swapper/37      R  running task        0     0      1 0x00000000
[  837.013117] Call trace:
[  837.015551] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.020675] [<          (null)>]           (null)
[  837.025365] Task dump for CPU 38:
[  837.028666] swapper/38      R  running task        0     0      1 0x00000000
[  837.035701] Call trace:
[  837.038135] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.043259] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  837.048730] Task dump for CPU 39:
[  837.052031] swapper/39      R  running task        0     0      1 0x00000000
[  837.059067] Call trace:
[  837.061500] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.066624] [<          (null)>]           (null)
[  837.071314] Task dump for CPU 40:
[  837.074615] swapper/40      R  running task        0     0      1 0x00000000
[  837.081650] Call trace:
[  837.084083] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.089207] [<          (null)>]           (null)
[  837.093897] Task dump for CPU 41:
[  837.097198] swapper/41      R  running task        0     0      1 0x00000000
[  837.104234] Call trace:
[  837.106667] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.111791] [<          (null)>]           (null)
[  837.116480] Task dump for CPU 42:
[  837.119781] swapper/42      R  running task        0     0      1 0x00000000
[  837.126817] Call trace:
[  837.129250] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.134374] [<          (null)>]           (null)
[  837.139064] Task dump for CPU 43:
[  837.142365] swapper/43      R  running task        0     0      1 0x00000000
[  837.149400] Call trace:
[  837.151833] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.156957] [<          (null)>]           (null)
[  837.161647] Task dump for CPU 44:
[  837.164948] swapper/44      R  running task        0     0      1 0x00000000
[  837.171984] Call trace:
[  837.174417] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.179541] [<          (null)>]           (null)
[  837.184231] Task dump for CPU 45:
[  837.187532] swapper/45      R  running task        0     0      1 0x00000000
[  837.194567] Call trace:
[  837.197000] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.202124] [<          (null)>]           (null)
[  837.206813] Task dump for CPU 46:
[  837.210114] swapper/46      R  running task        0     0      1 0x00000000
[  837.217150] Call trace:
[  837.219583] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.224707] [<          (null)>]           (null)
[  837.229397] Task dump for CPU 47:
[  837.232698] swapper/47      R  running task        0     0      1 0x00000000
[  837.239733] Call trace:
[  837.242166] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.247290] [<          (null)>]           (null)
[  837.251980] Task dump for CPU 48:
[  837.255281] swapper/48      R  running task        0     0      1 0x00000000
[  837.262316] Call trace:
[  837.264749] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.269873] [<          (null)>]           (null)
[  837.274563] Task dump for CPU 49:
[  837.277864] swapper/49      R  running task        0     0      1 0x00000000
[  837.284899] Call trace:
[  837.287333] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.292457] [<          (null)>]           (null)
[  837.297146] Task dump for CPU 50:
[  837.300448] swapper/50      R  running task        0     0      1 0x00000000
[  837.307483] Call trace:
[  837.309916] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.315040] [<          (null)>]           (null)
[  837.319729] Task dump for CPU 51:
[  837.323031] swapper/51      R  running task        0     0      1 0x00000000
[  837.330065] Call trace:
[  837.332499] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.337623] [<          (null)>]           (null)
[  837.342313] Task dump for CPU 52:
[  837.345614] swapper/52      R  running task        0     0      1 0x00000000
[  837.352649] Call trace:
[  837.355083] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.360207] [<          (null)>]           (null)
[  837.364896] Task dump for CPU 53:
[  837.368198] swapper/53      R  running task        0     0      1 0x00000000
[  837.375233] Call trace:
[  837.377666] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.382790] [<          (null)>]           (null)
[  837.387480] Task dump for CPU 54:
[  837.390781] swapper/54      R  running task        0     0      1 0x00000000
[  837.397817] Call trace:
[  837.400250] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.405375] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[  837.412149] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[  837.417534] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  837.423005] Task dump for CPU 55:
[  837.426305] swapper/55      R  running task        0     0      1 0x00000000
[  837.433341] Call trace:
[  837.435774] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.440898] [<          (null)>]           (null)
[  837.445588] Task dump for CPU 56:
[  837.448889] swapper/56      R  running task        0     0      1 0x00000000
[  837.455924] Call trace:
[  837.458358] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.463482] [<          (null)>]           (null)
[  837.468172] Task dump for CPU 57:
[  837.471473] swapper/57      R  running task        0     0      1 0x00000000
[  837.478508] Call trace:
[  837.480942] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.486066] [<ffff000008ff9df0>] __cpu_online_mask+0x0/0x8
[  837.491536] Task dump for CPU 58:
[  837.494837] swapper/58      R  running task        0     0      1 0x00000000
[  837.501873] Call trace:
[  837.504306] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.509430] [<          (null)>]           (null)
[  837.514120] Task dump for CPU 59:
[  837.517421] swapper/59      R  running task        0     0      1 0x00000000
[  837.524456] Call trace:
[  837.526889] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.532013] [<          (null)>]           (null)
[  837.536703] Task dump for CPU 60:
[  837.540004] swapper/60      R  running task        0     0      1 0x00000000
[  837.547039] Call trace:
[  837.549473] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.554597] [<          (null)>]           (null)
[  837.559287] Task dump for CPU 61:
[  837.562588] swapper/61      R  running task        0     0      1 0x00000000
[  837.569623] Call trace:
[  837.572056] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.577180] [<          (null)>]           (null)
[  837.581870] Task dump for CPU 62:
[  837.585171] swapper/62      R  running task        0     0      1 0x00000000
[  837.592206] Call trace:
[  837.594640] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.599764] [<          (null)>]           (null)
[  837.604453] Task dump for CPU 63:
[  837.607754] swapper/63      R  running task        0     0      1 0x00000000
[  837.614790] Call trace:
[  837.617223] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.622347] [<          (null)>]           (null)
[  837.627039] rcu_preempt kthread starved for 2508 jiffies! g112 c111 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[  837.636416] rcu_preempt     S    0     9      2 0x00000000
[  837.641888] Call trace:
[  837.644321] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[  837.649448] [<ffff000008a16724>] __schedule+0x1a4/0x720
[  837.654659] [<ffff000008a16ce0>] schedule+0x40/0xa8
[  837.659524] [<ffff000008a1a2f0>] schedule_timeout+0x178/0x358
[  837.665257] [<ffff00000813e694>] rcu_gp_kthread+0x534/0x7b8
[  837.670817] [<ffff0000080f33d0>] kthread+0x108/0x138
[  837.675767] [<ffff0000080836c0>] ret_from_fork+0x10/0x50


And from 8ish seconds before where I presume the problem would like.
If more is needed then ping me and I'll get them uploaded somewhere.


         <idle>-0     [000] d.h2   825.003085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.h1   825.003085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=823324002340
          <idle>-0     [000] d.h1   825.003086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   825.003087: timer_cancel: timer=ffff8017d3923c08
          <idle>-0     [000] d.s1   825.003087: timer_expire_entry: timer=ffff8017d3923c08 function=delayed_work_timer_fn now=4295098128
          <idle>-0     [000] dns1   825.003089: timer_expire_exit: timer=ffff8017d3923c08
          <idle>-0     [000] dn.2   825.003091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=823328000000 softexpires=823328000000
     kworker/0:0-3     [000] d..1   825.003093: timer_start: timer=ffff8017d3923c08 function=delayed_work_timer_fn expires=4295098378 [timeout=250] cpu=0 idx=98 flags=I
          <idle>-0     [000] d..1   825.003095: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   825.003095: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   825.003096: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824316000000 softexpires=824316000000
          <idle>-0     [000] dn.2   825.234230: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   825.234230: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=823556000000 softexpires=823556000000
          <idle>-0     [001] dn.2   825.234235: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   825.234235: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   825.234235: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=823556000000 softexpires=823556000000
          <idle>-0     [000] d..2   825.234236: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   825.234236: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824316000000 softexpires=824316000000
          <idle>-0     [001] d..1   825.234244: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   825.234244: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   825.234245: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1264347202655 softexpires=1264347202655
          <idle>-0     [000] d.h2   825.995084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [034] d.h2   825.995085: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [034] d.h1   825.995085: hrtimer_expire_entry: hrtimer=ffff8017dba91808 function=tick_sched_timer now=824316002180
          <idle>-0     [000] d.h1   825.995085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=824316002240
          <idle>-0     [000] d.h1   825.995086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [034] d.h1   825.995087: hrtimer_expire_exit: hrtimer=ffff8017dba91808
          <idle>-0     [000] d.s2   825.995087: timer_cancel: timer=ffff8017d3923408
          <idle>-0     [000] d.s1   825.995087: timer_expire_entry: timer=ffff8017d3923408 function=delayed_work_timer_fn now=4295098376
          <idle>-0     [034] d.s2   825.995087: timer_cancel: timer=ffff00000909a9a0
          <idle>-0     [034] d.s1   825.995088: timer_expire_entry: timer=ffff00000909a9a0 function=delayed_work_timer_fn now=4295098376
          <idle>-0     [000] dns1   825.995089: timer_expire_exit: timer=ffff8017d3923408
          <idle>-0     [034] dns1   825.995089: timer_expire_exit: timer=ffff00000909a9a0
          <idle>-0     [000] dn.2   825.995091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824320000000 softexpires=824320000000
          <idle>-0     [034] dn.2   825.995092: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=824320000000 softexpires=824320000000
     kworker/0:0-3     [000] d..1   825.995093: timer_start: timer=ffff8017d3923408 function=delayed_work_timer_fn expires=4295098626 [timeout=250] cpu=0 idx=65 flags=I
          <idle>-0     [000] d..1   825.995096: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   825.995096: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   825.995096: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824348000000 softexpires=824348000000
    kworker/34:2-1587  [034] d..1   825.995097: timer_start: timer=ffff00000909a9a0 function=delayed_work_timer_fn expires=4295098626 [timeout=250] cpu=34 idx=65 flags=I
          <idle>-0     [034] d..1   825.995100: tick_stop: success=1 dependency=NONE
          <idle>-0     [034] d..2   825.995101: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [034] d..2   825.995101: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=825340000000 softexpires=825340000000
          <idle>-0     [000] d.h2   826.027085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.h1   826.027085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=824348002340
          <idle>-0     [000] d.h1   826.027086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   826.027087: timer_cancel: timer=ffff8017d3923c08
          <idle>-0     [000] d.s1   826.027087: timer_expire_entry: timer=ffff8017d3923c08 function=delayed_work_timer_fn now=4295098384
          <idle>-0     [000] dns1   826.027088: timer_expire_exit: timer=ffff8017d3923c08
          <idle>-0     [000] dn.2   826.027091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824352000000 softexpires=824352000000
     kworker/0:0-3     [000] d..1   826.027093: timer_start: timer=ffff8017d3923c08 function=delayed_work_timer_fn expires=4295098634 [timeout=250] cpu=0 idx=66 flags=I
          <idle>-0     [000] d..1   826.027095: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   826.027095: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   826.027096: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825340000000 softexpires=825340000000
          <idle>-0     [000] dn.2   826.185331: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   826.185331: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824508000000 softexpires=824508000000
          <idle>-0     [001] dn.2   826.185336: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   826.185336: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   826.185336: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=824508000000 softexpires=824508000000
          <idle>-0     [000] d..2   826.185337: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   826.185337: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825340000000 softexpires=825340000000
          <idle>-0     [001] d..1   826.185349: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   826.185349: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   826.185350: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1265299202655 softexpires=1265299202655
          <idle>-0     [000] dn.2   826.382948: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   826.382949: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=824704000000 softexpires=824704000000
          <idle>-0     [001] dn.2   826.382954: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   826.382954: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   826.382954: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=824704000000 softexpires=824704000000
          <idle>-0     [000] d..2   826.382955: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   826.382955: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825340000000 softexpires=825340000000
          <idle>-0     [001] d..1   826.382963: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   826.382963: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   826.382964: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1265495202655 softexpires=1265495202655
          <idle>-0     [000] dn.2   826.863667: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   826.863667: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825188000000 softexpires=825188000000
          <idle>-0     [001] dn.2   826.863672: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   826.863672: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   826.863672: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825188000000 softexpires=825188000000
          <idle>-0     [000] d..2   826.863673: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   826.863673: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825340000000 softexpires=825340000000
          <idle>-0     [001] d..1   826.863680: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   826.863681: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   826.863681: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1265979202655 softexpires=1265979202655
8 seconds before the issue is detected is somewhere around here.

	  <idle>-0     [000] d.h2   827.019085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [034] d.h2   827.019085: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [034] d.h1   827.019085: hrtimer_expire_entry: hrtimer=ffff8017dba91808 function=tick_sched_timer now=825340002280
          <idle>-0     [000] d.h1   827.019085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=825340002260
          <idle>-0     [034] d.h1   827.019086: hrtimer_expire_exit: hrtimer=ffff8017dba91808
          <idle>-0     [000] d.h1   827.019087: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [034] d.s2   827.019087: timer_cancel: timer=ffff00000909a9a0
          <idle>-0     [000] d.s2   827.019088: timer_cancel: timer=ffff8017d3923408
          <idle>-0     [034] d.s1   827.019088: timer_expire_entry: timer=ffff00000909a9a0 function=delayed_work_timer_fn now=4295098632
          <idle>-0     [000] d.s1   827.019088: timer_expire_entry: timer=ffff8017d3923408 function=delayed_work_timer_fn now=4295098632
          <idle>-0     [034] dns1   827.019089: timer_expire_exit: timer=ffff00000909a9a0
          <idle>-0     [000] dns1   827.019089: timer_expire_exit: timer=ffff8017d3923408
          <idle>-0     [000] dns2   827.019090: timer_cancel: timer=ffff0000090295a8
          <idle>-0     [000] dns1   827.019090: timer_expire_entry: timer=ffff0000090295a8 function=delayed_work_timer_fn now=4295098632
          <idle>-0     [000] dns1   827.019090: timer_expire_exit: timer=ffff0000090295a8
          <idle>-0     [034] dn.2   827.019092: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=825344000000 softexpires=825344000000
          <idle>-0     [000] dn.2   827.019093: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825344000000 softexpires=825344000000
     kworker/0:0-3     [000] d..1   827.019095: timer_start: timer=ffff8017d3923408 function=delayed_work_timer_fn expires=4295098882 [timeout=250] cpu=0 idx=97 flags=I
    kworker/34:2-1587  [034] d..1   827.019098: timer_start: timer=ffff00000909a9a0 function=delayed_work_timer_fn expires=4295098882 [timeout=250] cpu=34 idx=97 flags=I
          <idle>-0     [034] d..1   827.019101: tick_stop: success=1 dependency=NONE
          <idle>-0     [034] d..2   827.019101: hrtimer_cancel: hrtimer=ffff8017dba91808
     kworker/0:0-3     [000] d..1   827.019102: timer_start: timer=ffff0000090295a8 function=delayed_work_timer_fn expires=4295099000 [timeout=368] cpu=0 idx=81 flags=D|I
          <idle>-0     [034] d..2   827.019102: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [000] d..1   827.019104: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   827.019104: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.019105: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825372000000 softexpires=825372000000
          <idle>-0     [000] d.h2   827.051085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.h1   827.051085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=825372002340
          <idle>-0     [000] d.h1   827.051086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   827.051087: timer_cancel: timer=ffff8017d3923c08
          <idle>-0     [000] d.s1   827.051087: timer_expire_entry: timer=ffff8017d3923c08 function=delayed_work_timer_fn now=4295098640
          <idle>-0     [000] dns1   827.051088: timer_expire_exit: timer=ffff8017d3923c08
          <idle>-0     [000] dn.2   827.051091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825376000000 softexpires=825376000000
     kworker/0:0-3     [000] d..1   827.051093: timer_start: timer=ffff8017d3923c08 function=delayed_work_timer_fn expires=4295098890 [timeout=250] cpu=0 idx=98 flags=I
          <idle>-0     [000] d..1   827.051095: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   827.051095: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.051096: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [000] dn.2   827.153486: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   827.153486: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825476000000 softexpires=825476000000
          <idle>-0     [001] dn.2   827.153491: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   827.153491: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   827.153491: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825476000000 softexpires=825476000000
          <idle>-0     [000] d..2   827.153491: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.153492: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [001] d..1   827.153499: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   827.153500: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.153500: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1266267202655 softexpires=1266267202655
          <idle>-0     [000] dn.2   827.463397: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   827.463398: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825788000000 softexpires=825788000000
          <idle>-0     [001] dn.2   827.463402: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   827.463403: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   827.463403: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825788000000 softexpires=825788000000
          <idle>-0     [000] d..2   827.463403: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.463403: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [001] d..1   827.463411: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   827.463411: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.463412: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=1266579202655 softexpires=1266579202655
          <idle>-0     [000] dn.2   827.563461: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   827.563462: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=825888000000 softexpires=825888000000
          <idle>-0     [001] dn.2   827.563466: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d..1   827.563467: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] dn.2   827.563467: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825888000000 softexpires=825888000000
          <idle>-0     [000] d..2   827.563467: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.563468: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
              sh-1993  [001] ....   827.563474: timer_init: timer=ffff8017db00fb40
              sh-1993  [001] d..1   827.563475: timer_start: timer=ffff8017db00fb40 function=process_timeout expires=4295098770 [timeout=2] cpu=1 idx=0 flags=
          <idle>-0     [001] d..1   827.563477: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   827.563478: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.563478: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825896000000 softexpires=825896000000
          <idle>-0     [001] d.h2   827.575084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   827.575084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825896001620
          <idle>-0     [001] d.h1   827.575086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.s2   827.575087: timer_cancel: timer=ffff8017db00fb40
          <idle>-0     [001] ..s1   827.575087: timer_expire_entry: timer=ffff8017db00fb40 function=process_timeout now=4295098771
          <idle>-0     [001] .ns1   827.575089: timer_expire_exit: timer=ffff8017db00fb40
          <idle>-0     [001] dns2   827.575089: timer_cancel: timer=ffff8017fbe5e558
          <idle>-0     [001] dns1   827.575089: timer_expire_entry: timer=ffff8017fbe5e558 function=delayed_work_timer_fn now=4295098771
          <idle>-0     [001] dns1   827.575091: timer_expire_exit: timer=ffff8017fbe5e558
          <idle>-0     [001] dn.2   827.575094: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825900000000 softexpires=825900000000
              sh-1993  [001] ...1   827.575136: hrtimer_init: hrtimer=ffff8017d4f1e8a0 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
              sh-1993  [001] ...1   827.575137: hrtimer_init: hrtimer=ffff8017d4f1e8e0 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
              sh-1993  [001] ....   827.575145: hrtimer_init: hrtimer=ffff80176f273888 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
          <idle>-0     [018] dn.2   827.575215: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] dn.2   827.575216: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825900000000 softexpires=825900000000
          <idle>-0     [001] d..1   827.575297: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   827.575298: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.575299: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825916000000 softexpires=825916000000
              ps-2012  [018] ....   827.576609: timer_init: timer=ffff801764b98188
              ps-2012  [018] ....   827.576614: timer_init: timer=ffff801764b98608
              ps-2012  [018] ....   827.576633: timer_init: timer=ffff801764b98188
              ps-2012  [018] ....   827.576635: timer_init: timer=ffff801764b98608
              ps-2012  [018] d.h2   827.579085: hrtimer_cancel: hrtimer=ffff8017fbc74808
              ps-2012  [018] d.h1   827.579086: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825900002120
              ps-2012  [018] d.h1   827.579093: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
              ps-2012  [018] d.h2   827.579094: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825904000000 softexpires=825904000000
          <idle>-0     [019] dn.2   827.579107: hrtimer_start: hrtimer=ffff8017fbc8f808 function=tick_sched_timer expires=825904000000 softexpires=825904000000
     rcu_preempt-9     [019] ....   827.579114: timer_init: timer=ffff8017d5fc7da0
     rcu_preempt-9     [019] d..1   827.579115: timer_start: timer=ffff8017d5fc7da0 function=process_timeout expires=4295098773 [timeout=1] cpu=19 idx=0 flags=
          <idle>-0     [019] d..1   827.579119: tick_stop: success=1 dependency=NONE
          <idle>-0     [019] d..2   827.579119: hrtimer_cancel: hrtimer=ffff8017fbc8f808
          <idle>-0     [019] d..2   827.579119: hrtimer_start: hrtimer=ffff8017fbc8f808 function=tick_sched_timer expires=840668000000 softexpires=840668000000
          <idle>-0     [018] d..1   827.580189: tick_stop: success=1 dependency=NONE
          <idle>-0     [018] d..2   827.580190: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   827.580191: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825916000000 softexpires=825916000000
          <idle>-0     [018] d.h2   827.595084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.595084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.595085: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825916001860
          <idle>-0     [001] d.h1   827.595085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825916001960
          <idle>-0     [001] d.h1   827.595086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.595087: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   827.595089: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825932000000 softexpires=825932000000
          <idle>-0     [001] d..2   827.595090: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825932000000 softexpires=825932000000
          <idle>-0     [018] d.h2   827.611084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.611084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.611084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825932001300
          <idle>-0     [001] d.h1   827.611084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825932001520
          <idle>-0     [018] d.h1   827.611085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.611085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.611088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825948000000 softexpires=825948000000
          <idle>-0     [018] d..2   827.611090: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825948000000 softexpires=825948000000
          <idle>-0     [018] d.h2   827.627084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.627084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.627084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825948001320
          <idle>-0     [001] d.h1   827.627084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825948001560
          <idle>-0     [001] d.h1   827.627085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.627086: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   827.627087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825964000000 softexpires=825964000000
          <idle>-0     [001] d..2   827.627088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825964000000 softexpires=825964000000
          <idle>-0     [018] d.h2   827.643084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.643084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.643084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825964001260
          <idle>-0     [001] d.h1   827.643084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825964001440
          <idle>-0     [018] d.h1   827.643085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.643085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.643087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825980000000 softexpires=825980000000
          <idle>-0     [018] d..2   827.643088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825980000000 softexpires=825980000000
          <idle>-0     [018] d.h2   827.659084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.659084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.659084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825980001300
          <idle>-0     [001] d.h1   827.659084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825980001540
          <idle>-0     [018] d.h1   827.659085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.659085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.659086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=825996000000 softexpires=825996000000
          <idle>-0     [001] d..2   827.659088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=825996000000 softexpires=825996000000
          <idle>-0     [018] d.h2   827.675084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.675084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.675084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=825996001320
          <idle>-0     [001] d.h1   827.675084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=825996001520
          <idle>-0     [018] d.h1   827.675085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.675085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.675087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826012000000 softexpires=826012000000
          <idle>-0     [018] d..2   827.675088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826012000000 softexpires=826012000000
          <idle>-0     [018] d.h2   827.691084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.691084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.691084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826012001280
          <idle>-0     [001] d.h1   827.691084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826012001480
          <idle>-0     [018] d.h1   827.691085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.691085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.691086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826028000000 softexpires=826028000000
          <idle>-0     [001] d..2   827.691088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826028000000 softexpires=826028000000
          <idle>-0     [018] d.h2   827.707084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.707084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.707084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826028001300
          <idle>-0     [001] d.h1   827.707084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826028001520
          <idle>-0     [018] d.h1   827.707085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.707085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.707087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826044000000 softexpires=826044000000
          <idle>-0     [018] d..2   827.707087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826044000000 softexpires=826044000000
          <idle>-0     [018] d.h2   827.723084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d.h1   827.723084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826044001280
          <idle>-0     [001] d.h2   827.723084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   827.723085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826044001480
          <idle>-0     [018] d.h1   827.723085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.723086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.723086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826060000000 softexpires=826060000000
          <idle>-0     [001] d..2   827.723088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826060000000 softexpires=826060000000
          <idle>-0     [018] d.h2   827.739084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.739084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.739084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826060001280
          <idle>-0     [001] d.h1   827.739084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826060001460
          <idle>-0     [018] d.h1   827.739085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.739085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.739087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826076000000 softexpires=826076000000
          <idle>-0     [001] d..2   827.739087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826076000000 softexpires=826076000000
          <idle>-0     [018] d.h2   827.755084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.755084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.755084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826076001280
          <idle>-0     [001] d.h1   827.755084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826076001460
          <idle>-0     [018] d.h1   827.755085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.755085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.755086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826092000000 softexpires=826092000000
          <idle>-0     [001] d..2   827.755088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826092000000 softexpires=826092000000
          <idle>-0     [018] d.h2   827.771084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.771084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.771084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826092001240
          <idle>-0     [001] d.h1   827.771084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826092001460
          <idle>-0     [018] d.h1   827.771085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.771085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.771087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826108000000 softexpires=826108000000
          <idle>-0     [001] d..2   827.771087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826108000000 softexpires=826108000000
          <idle>-0     [018] d.h2   827.787084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.787084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.787084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826108001280
          <idle>-0     [001] d.h1   827.787084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826108001500
          <idle>-0     [018] d.h1   827.787085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.787085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.787086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826124000000 softexpires=826124000000
          <idle>-0     [001] d..2   827.787087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826124000000 softexpires=826124000000
          <idle>-0     [018] d.h2   827.803084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.803084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.803084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826124001280
          <idle>-0     [001] d.h1   827.803084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826124001480
          <idle>-0     [018] d.h1   827.803085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.803085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.803087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826140000000 softexpires=826140000000
          <idle>-0     [018] d..2   827.803087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826140000000 softexpires=826140000000
          <idle>-0     [018] d.h2   827.819084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.819084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.819084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826140001280
          <idle>-0     [001] d.h1   827.819084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826140001480
          <idle>-0     [018] d.h1   827.819085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.819085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.819086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826156000000 softexpires=826156000000
          <idle>-0     [001] d..2   827.819088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826156000000 softexpires=826156000000
          <idle>-0     [018] d.h2   827.835084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.835084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.835084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826156001260
          <idle>-0     [001] d.h1   827.835084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826156001460
          <idle>-0     [018] d.h1   827.835085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.835085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.835087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826172000000 softexpires=826172000000
          <idle>-0     [018] d..2   827.835087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826172000000 softexpires=826172000000
          <idle>-0     [018] d.h2   827.851084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.851084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.851084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826172001260
          <idle>-0     [001] d.h1   827.851084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826172001440
          <idle>-0     [018] d.h1   827.851085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.851085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.851086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826188000000 softexpires=826188000000
          <idle>-0     [001] d..2   827.851087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826188000000 softexpires=826188000000
          <idle>-0     [018] d.h2   827.867084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.867084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.867084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826188001280
          <idle>-0     [001] d.h1   827.867084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826188001500
          <idle>-0     [018] d.h1   827.867085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.867085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.867087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826204000000 softexpires=826204000000
          <idle>-0     [001] d..2   827.867087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826204000000 softexpires=826204000000
          <idle>-0     [018] d.h2   827.883084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.883084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.883084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826204001260
          <idle>-0     [001] d.h1   827.883084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826204001460
          <idle>-0     [018] d.h1   827.883085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.883085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.883086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826220000000 softexpires=826220000000
          <idle>-0     [001] d..2   827.883088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826220000000 softexpires=826220000000
          <idle>-0     [018] d.h2   827.899084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.899084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.899084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826220001280
          <idle>-0     [001] d.h1   827.899084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826220001440
          <idle>-0     [018] d.h1   827.899085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.899085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.899087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826236000000 softexpires=826236000000
          <idle>-0     [001] d..2   827.899087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826236000000 softexpires=826236000000
          <idle>-0     [000] dn.2   827.913426: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   827.913427: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826236000000 softexpires=826236000000
          <idle>-0     [018] d.h2   827.915084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.915084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h2   827.915084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   827.915084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826236001200
          <idle>-0     [001] d.h1   827.915084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826236001400
              ps-2012  [000] d.h1   827.915085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=826236001280
          <idle>-0     [018] d.h1   827.915085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.915085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.915086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826252000000 softexpires=826252000000
              ps-2012  [000] d.h1   827.915088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h2   827.915088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826240000000 softexpires=826240000000
          <idle>-0     [001] d..2   827.915090: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826252000000 softexpires=826252000000
          <idle>-0     [000] d..1   827.916071: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   827.916072: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.916073: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826252000000 softexpires=826252000000
          <idle>-0     [000] d..2   827.920194: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.920195: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826268000000 softexpires=826268000000
          <idle>-0     [018] d.h2   827.931084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.931084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.931084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826252001280
          <idle>-0     [001] d.h1   827.931084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826252001500
          <idle>-0     [018] d.h1   827.931085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.931085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   827.931088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826268000000 softexpires=826268000000
          <idle>-0     [018] d..2   827.931088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826268000000 softexpires=826268000000
          <idle>-0     [000] d..2   827.935471: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.935471: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826284000000 softexpires=826284000000
          <idle>-0     [018] d.h2   827.947084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.947084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.947084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826268001260
          <idle>-0     [001] d.h1   827.947084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826268001480
          <idle>-0     [018] d.h1   827.947085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.947085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.947086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826284000000 softexpires=826284000000
          <idle>-0     [001] d..2   827.947088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826284000000 softexpires=826284000000
          <idle>-0     [000] d..2   827.952136: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.952137: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826300000000 softexpires=826300000000
          <idle>-0     [005] d..2   827.960777: hrtimer_cancel: hrtimer=ffff8017fbec8808
          <idle>-0     [005] d..2   827.960779: hrtimer_start: hrtimer=ffff8017fbec8808 function=tick_sched_timer expires=1267075202655 softexpires=1267075202655
          <idle>-0     [062] d..2   827.960781: hrtimer_cancel: hrtimer=ffff8017dba25808
          <idle>-0     [062] d..2   827.960783: hrtimer_start: hrtimer=ffff8017dba25808 function=tick_sched_timer expires=1267075202655 softexpires=1267075202655
          <idle>-0     [018] d.h2   827.963085: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.963085: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.963085: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826284002420
          <idle>-0     [001] d.h1   827.963085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826284002560
          <idle>-0     [018] d.h1   827.963086: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.963087: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.963089: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826300000000 softexpires=826300000000
          <idle>-0     [001] d..2   827.963089: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826300000000 softexpires=826300000000
          <idle>-0     [000] d..2   827.967413: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.967414: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826316000000 softexpires=826316000000
          <idle>-0     [004] d..2   827.968778: hrtimer_cancel: hrtimer=ffff8017fbead808
          <idle>-0     [004] d..2   827.968779: hrtimer_start: hrtimer=ffff8017fbead808 function=tick_sched_timer expires=1267083202655 softexpires=1267083202655
          <idle>-0     [036] d..2   827.969900: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2   827.969902: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=1267083202655 softexpires=1267083202655
          <idle>-0     [018] d.h2   827.979084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.979084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.979084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826300001260
          <idle>-0     [001] d.h1   827.979084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826300001480
          <idle>-0     [018] d.h1   827.979085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.979085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.979087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826316000000 softexpires=826316000000
          <idle>-0     [001] d..2   827.979088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826316000000 softexpires=826316000000
          <idle>-0     [039] d..2   827.980320: hrtimer_cancel: hrtimer=ffff8017dbb18808
          <idle>-0     [039] d..2   827.980321: hrtimer_start: hrtimer=ffff8017dbb18808 function=tick_sched_timer expires=1267095202655 softexpires=1267095202655
          <idle>-0     [000] d..2   827.984080: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.984080: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826332000000 softexpires=826332000000
          <idle>-0     [018] d.h2   827.995084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   827.995084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   827.995084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826316001280
          <idle>-0     [001] d.h1   827.995084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826316001460
          <idle>-0     [018] d.h1   827.995085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   827.995085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   827.995087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826332000000 softexpires=826332000000
          <idle>-0     [001] d..2   827.995088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826332000000 softexpires=826332000000
          <idle>-0     [000] d..2   827.999356: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   827.999356: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826348000000 softexpires=826348000000
          <idle>-0     [018] d.h2   828.011084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.011084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   828.011084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826332001500
          <idle>-0     [018] d.h1   828.011084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826332001300
          <idle>-0     [001] d.h1   828.011085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.011085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   828.011087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826348000000 softexpires=826348000000
          <idle>-0     [001] d..2   828.011088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826348000000 softexpires=826348000000
          <idle>-0     [000] d..2   828.016021: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.016022: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [018] d.h2   828.027084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.027084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.027084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826348001300
          <idle>-0     [001] d.h1   828.027084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826348001520
          <idle>-0     [018] d.h1   828.027085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.027085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.027087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [018] d..2   828.027087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826364000000 softexpires=826364000000
          <idle>-0     [000] d.h2   828.043085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   828.043085: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.043085: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.043085: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826364002620
          <idle>-0     [034] d.h2   828.043085: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [001] d.h1   828.043085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826364002780
          <idle>-0     [000] d.h1   828.043086: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=826364002620
          <idle>-0     [034] d.h1   828.043086: hrtimer_expire_entry: hrtimer=ffff8017dba91808 function=tick_sched_timer now=826364002780
          <idle>-0     [018] d.h1   828.043086: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.043087: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   828.043087: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d..2   828.043088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826380000000 softexpires=826380000000
          <idle>-0     [034] d.h1   828.043088: hrtimer_expire_exit: hrtimer=ffff8017dba91808
          <idle>-0     [000] d.s2   828.043088: timer_cancel: timer=ffff8017d3923408
          <idle>-0     [000] d.s1   828.043088: timer_expire_entry: timer=ffff8017d3923408 function=delayed_work_timer_fn now=4295098888
          <idle>-0     [034] d.s2   828.043089: timer_cancel: timer=ffff00000909a9a0
          <idle>-0     [034] d.s1   828.043089: timer_expire_entry: timer=ffff00000909a9a0 function=delayed_work_timer_fn now=4295098888
          <idle>-0     [001] d..2   828.043089: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826380000000 softexpires=826380000000
          <idle>-0     [034] dns1   828.043090: timer_expire_exit: timer=ffff00000909a9a0
          <idle>-0     [000] dns1   828.043090: timer_expire_exit: timer=ffff8017d3923408
          <idle>-0     [034] dn.2   828.043094: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=826368000000 softexpires=826368000000
          <idle>-0     [000] dn.2   828.043095: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826368000000 softexpires=826368000000
     kworker/0:0-3     [000] d..1   828.043098: timer_start: timer=ffff8017d3923408 function=delayed_work_timer_fn expires=4295099138 [timeout=250] cpu=0 idx=65 flags=I
          <idle>-0     [000] d..1   828.043101: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   828.043101: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.043101: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826380000000 softexpires=826380000000
    kworker/34:2-1587  [034] d..1   828.043102: timer_start: timer=ffff00000909a9a0 function=delayed_work_timer_fn expires=4295099138 [timeout=250] cpu=34 idx=65 flags=I
          <idle>-0     [034] d..1   828.043104: tick_stop: success=1 dependency=NONE
          <idle>-0     [034] d..2   828.043105: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [034] d..2   828.043105: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=827388000000 softexpires=827388000000
          <idle>-0     [000] d..2   828.047965: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.047965: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826396000000 softexpires=826396000000
          <idle>-0     [018] d.h2   828.059084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.059084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.059084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826380001280
          <idle>-0     [001] d.h1   828.059084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826380001500
          <idle>-0     [018] d.h1   828.059085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.059085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.059087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826396000000 softexpires=826396000000
          <idle>-0     [001] d..2   828.059088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826396000000 softexpires=826396000000
          <idle>-0     [000] d.h2   828.075084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   828.075084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.075084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.075084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826396001280
          <idle>-0     [000] d.h1   828.075084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=826396001280
          <idle>-0     [001] d.h1   828.075084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826396001480
          <idle>-0     [018] d.h1   828.075085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.075085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   828.075085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   828.075086: timer_cancel: timer=ffff8017d3923c08
          <idle>-0     [018] d..2   828.075086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826412000000 softexpires=826412000000
          <idle>-0     [000] d.s1   828.075086: timer_expire_entry: timer=ffff8017d3923c08 function=delayed_work_timer_fn now=4295098896
          <idle>-0     [000] dns1   828.075088: timer_expire_exit: timer=ffff8017d3923c08
          <idle>-0     [001] d..2   828.075088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826412000000 softexpires=826412000000
          <idle>-0     [000] dn.2   828.075091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826400000000 softexpires=826400000000
     kworker/0:0-3     [000] d..1   828.075093: timer_start: timer=ffff8017d3923c08 function=delayed_work_timer_fn expires=4295099146 [timeout=250] cpu=0 idx=66 flags=I
          <idle>-0     [000] d..1   828.075095: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   828.075095: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.075096: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826412000000 softexpires=826412000000
          <idle>-0     [000] d..2   828.079906: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.079907: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826428000000 softexpires=826428000000
          <idle>-0     [018] d.h2   828.091084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.091084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.091084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826412001280
          <idle>-0     [001] d.h1   828.091084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826412001460
          <idle>-0     [018] d.h1   828.091085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.091085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.091087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826428000000 softexpires=826428000000
          <idle>-0     [001] d..2   828.091087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826428000000 softexpires=826428000000
          <idle>-0     [000] d..2   828.095183: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.095183: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826444000000 softexpires=826444000000
          <idle>-0     [018] d.h2   828.107084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.107084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.107084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826428001260
          <idle>-0     [001] d.h1   828.107084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826428001480
          <idle>-0     [018] d.h1   828.107085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.107085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.107086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826444000000 softexpires=826444000000
          <idle>-0     [001] d..2   828.107088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826444000000 softexpires=826444000000
          <idle>-0     [000] d..2   828.111848: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.111849: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826460000000 softexpires=826460000000
          <idle>-0     [018] d.h2   828.123084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.123084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.123084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826444001280
          <idle>-0     [001] d.h1   828.123084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826444001460
          <idle>-0     [018] d.h1   828.123085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.123085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.123087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826460000000 softexpires=826460000000
          <idle>-0     [001] d..2   828.123087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826460000000 softexpires=826460000000
          <idle>-0     [000] d..2   828.127125: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.127126: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826476000000 softexpires=826476000000
          <idle>-0     [018] d.h2   828.139084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.139084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.139084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826460001260
          <idle>-0     [001] d.h1   828.139084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826460001460
          <idle>-0     [018] d.h1   828.139085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.139085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.139086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826476000000 softexpires=826476000000
          <idle>-0     [001] d..2   828.139088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826476000000 softexpires=826476000000
          <idle>-0     [000] d..2   828.143791: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.143791: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826492000000 softexpires=826492000000
          <idle>-0     [018] d.h2   828.155084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.155084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.155084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826476001280
          <idle>-0     [001] d.h1   828.155084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826476001480
          <idle>-0     [018] d.h1   828.155085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.155085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.155087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826492000000 softexpires=826492000000
          <idle>-0     [018] d..2   828.155087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826492000000 softexpires=826492000000
          <idle>-0     [000] d..2   828.160457: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.160457: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826508000000 softexpires=826508000000
          <idle>-0     [018] d.h2   828.171084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.171084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.171084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826492001300
          <idle>-0     [001] d.h1   828.171084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826492001500
          <idle>-0     [018] d.h1   828.171085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.171085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.171086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826508000000 softexpires=826508000000
          <idle>-0     [001] d..2   828.171087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826508000000 softexpires=826508000000
          <idle>-0     [000] d..2   828.175733: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.175734: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826524000000 softexpires=826524000000
          <idle>-0     [018] d.h2   828.187084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.187084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.187084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826508001300
          <idle>-0     [001] d.h1   828.187084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826508001480
          <idle>-0     [018] d.h1   828.187085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.187085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.187087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826524000000 softexpires=826524000000
          <idle>-0     [001] d..2   828.187087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826524000000 softexpires=826524000000
          <idle>-0     [000] d..2   828.192399: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.192399: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826540000000 softexpires=826540000000
          <idle>-0     [018] d.h2   828.203084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.203084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.203084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826524001260
          <idle>-0     [001] d.h1   828.203084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826524001460
          <idle>-0     [018] d.h1   828.203085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.203085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.203086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826540000000 softexpires=826540000000
          <idle>-0     [001] d..2   828.203087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826540000000 softexpires=826540000000
          <idle>-0     [000] d..2   828.207676: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.207676: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826556000000 softexpires=826556000000
          <idle>-0     [018] d.h2   828.219084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.219084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.219084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826540001260
          <idle>-0     [001] d.h1   828.219084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826540001420
          <idle>-0     [018] d.h1   828.219085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.219085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.219087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826556000000 softexpires=826556000000
          <idle>-0     [001] d..2   828.219087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826556000000 softexpires=826556000000
          <idle>-0     [000] d..2   828.224341: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.224342: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826572000000 softexpires=826572000000
          <idle>-0     [018] d.h2   828.235084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.235084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.235084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826556001260
          <idle>-0     [001] d.h1   828.235084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826556001440
          <idle>-0     [018] d.h1   828.235085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.235085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.235086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826572000000 softexpires=826572000000
          <idle>-0     [001] d..2   828.235087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826572000000 softexpires=826572000000
          <idle>-0     [000] d..2   828.239618: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.239619: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826588000000 softexpires=826588000000
          <idle>-0     [000] dn.2   828.249341: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   828.249342: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826572000000 softexpires=826572000000
          <idle>-0     [018] d.h2   828.251084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.251084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h2   828.251084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   828.251084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826572001200
          <idle>-0     [001] d.h1   828.251084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826572001420
              ps-2012  [000] d.h1   828.251085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=826572001280
          <idle>-0     [018] d.h1   828.251085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.251085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.251087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826588000000 softexpires=826588000000
              ps-2012  [000] d.h1   828.251088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h2   828.251088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826576000000 softexpires=826576000000
          <idle>-0     [001] d..2   828.251093: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826588000000 softexpires=826588000000
          <idle>-0     [000] d..1   828.251937: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   828.251937: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.251938: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826588000000 softexpires=826588000000
          <idle>-0     [000] d..2   828.256023: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.256024: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826604000000 softexpires=826604000000
          <idle>-0     [018] d.h2   828.267084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d.h1   828.267084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826588001240
          <idle>-0     [001] d.h2   828.267084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   828.267085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826588001440
          <idle>-0     [018] d.h1   828.267085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.267086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.267086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826604000000 softexpires=826604000000
          <idle>-0     [001] d..2   828.267088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826604000000 softexpires=826604000000
          <idle>-0     [000] d..2   828.271300: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.271301: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826620000000 softexpires=826620000000
          <idle>-0     [018] d.h2   828.283084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.283084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.283084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826604001240
          <idle>-0     [001] d.h1   828.283084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826604001420
          <idle>-0     [018] d.h1   828.283085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.283085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.283087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826620000000 softexpires=826620000000
          <idle>-0     [001] d..2   828.283087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826620000000 softexpires=826620000000
          <idle>-0     [000] d..2   828.287966: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.287967: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826636000000 softexpires=826636000000
          <idle>-0     [018] d.h2   828.299084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.299084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.299084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826620001260
          <idle>-0     [001] d.h1   828.299084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826620001460
          <idle>-0     [018] d.h1   828.299085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.299085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.299086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826636000000 softexpires=826636000000
          <idle>-0     [001] d..2   828.299087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826636000000 softexpires=826636000000
          <idle>-0     [000] d..2   828.303242: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.303243: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826652000000 softexpires=826652000000
          <idle>-0     [018] d.h2   828.315084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.315084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.315084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826636001260
          <idle>-0     [001] d.h1   828.315084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826636001460
          <idle>-0     [018] d.h1   828.315085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.315085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.315087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826652000000 softexpires=826652000000
          <idle>-0     [001] d..2   828.315087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826652000000 softexpires=826652000000
          <idle>-0     [000] d..2   828.319908: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.319909: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826668000000 softexpires=826668000000
          <idle>-0     [018] d.h2   828.331084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.331084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.331084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826652001240
          <idle>-0     [001] d.h1   828.331084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826652001440
          <idle>-0     [018] d.h1   828.331085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.331085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.331086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826668000000 softexpires=826668000000
          <idle>-0     [001] d..2   828.331087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826668000000 softexpires=826668000000
          <idle>-0     [000] d..2   828.335185: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.335185: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826684000000 softexpires=826684000000
          <idle>-0     [018] d.h2   828.347084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.347084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.347084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826668001260
          <idle>-0     [001] d.h1   828.347084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826668001460
          <idle>-0     [018] d.h1   828.347085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.347085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.347087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826684000000 softexpires=826684000000
          <idle>-0     [001] d..2   828.347087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826684000000 softexpires=826684000000
          <idle>-0     [000] d..2   828.351850: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.351851: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826700000000 softexpires=826700000000
          <idle>-0     [018] d.h2   828.363084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.363084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.363084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826684001260
          <idle>-0     [001] d.h1   828.363084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826684001460
          <idle>-0     [018] d.h1   828.363085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.363085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.363086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826700000000 softexpires=826700000000
          <idle>-0     [001] d..2   828.363087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826700000000 softexpires=826700000000
          <idle>-0     [000] d..2   828.367127: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.367128: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826716000000 softexpires=826716000000
          <idle>-0     [018] d.h2   828.379084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.379084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.379084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826700001260
          <idle>-0     [001] d.h1   828.379084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826700001440
          <idle>-0     [018] d.h1   828.379085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.379085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.379087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826716000000 softexpires=826716000000
          <idle>-0     [018] d..2   828.379087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826716000000 softexpires=826716000000
          <idle>-0     [000] d..2   828.383793: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.383794: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826732000000 softexpires=826732000000
          <idle>-0     [018] d.h2   828.395084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.395084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.395084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826716001260
          <idle>-0     [001] d.h1   828.395084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826716001480
          <idle>-0     [018] d.h1   828.395085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.395085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.395086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826732000000 softexpires=826732000000
          <idle>-0     [001] d..2   828.395087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826732000000 softexpires=826732000000
          <idle>-0     [000] d..2   828.400458: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.400459: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826748000000 softexpires=826748000000
          <idle>-0     [018] d.h2   828.411084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.411084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.411084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826732001300
          <idle>-0     [001] d.h1   828.411084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826732001500
          <idle>-0     [018] d.h1   828.411085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.411085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.411087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826748000000 softexpires=826748000000
          <idle>-0     [018] d..2   828.411087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826748000000 softexpires=826748000000
          <idle>-0     [000] d..2   828.415735: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.415736: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826764000000 softexpires=826764000000
          <idle>-0     [018] d.h2   828.427084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.427084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.427084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826748001320
          <idle>-0     [001] d.h1   828.427084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826748001520
          <idle>-0     [018] d.h1   828.427085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.427085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.427086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826764000000 softexpires=826764000000
          <idle>-0     [001] d..2   828.427087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826764000000 softexpires=826764000000
          <idle>-0     [000] d..2   828.432401: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.432401: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826780000000 softexpires=826780000000
          <idle>-0     [018] d.h2   828.443084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.443084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.443084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826764001260
          <idle>-0     [001] d.h1   828.443084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826764001480
          <idle>-0     [018] d.h1   828.443085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.443085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.443087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826780000000 softexpires=826780000000
          <idle>-0     [001] d..2   828.443087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826780000000 softexpires=826780000000
          <idle>-0     [000] d..2   828.447678: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.447678: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826796000000 softexpires=826796000000
          <idle>-0     [018] d.h2   828.459084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.459084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.459084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826780001260
          <idle>-0     [001] d.h1   828.459084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826780001460
          <idle>-0     [018] d.h1   828.459085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.459085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.459086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826796000000 softexpires=826796000000
          <idle>-0     [001] d..2   828.459087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826796000000 softexpires=826796000000
          <idle>-0     [000] d..2   828.464343: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.464344: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826812000000 softexpires=826812000000
          <idle>-0     [018] d.h2   828.475084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.475084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.475084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826796001240
          <idle>-0     [001] d.h1   828.475084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826796001460
          <idle>-0     [018] d.h1   828.475085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.475085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.475087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826812000000 softexpires=826812000000
          <idle>-0     [001] d..2   828.475087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826812000000 softexpires=826812000000
          <idle>-0     [000] d..2   828.479620: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.479621: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826828000000 softexpires=826828000000
          <idle>-0     [018] d.h2   828.491084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.491084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.491084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826812001260
          <idle>-0     [001] d.h1   828.491084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826812001460
          <idle>-0     [018] d.h1   828.491085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.491085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.491086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826828000000 softexpires=826828000000
          <idle>-0     [001] d..2   828.491087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826828000000 softexpires=826828000000
          <idle>-0     [000] d..2   828.496286: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.496286: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826844000000 softexpires=826844000000
          <idle>-0     [018] d.h2   828.507084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.507084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.507084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826828001260
          <idle>-0     [001] d.h1   828.507084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826828001480
          <idle>-0     [018] d.h1   828.507085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.507085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.507087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826844000000 softexpires=826844000000
          <idle>-0     [018] d..2   828.507087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826844000000 softexpires=826844000000
          <idle>-0     [000] d..2   828.511562: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.511563: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826860000000 softexpires=826860000000
          <idle>-0     [018] d.h2   828.523084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.523084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.523084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826844001300
          <idle>-0     [001] d.h1   828.523084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826844001480
          <idle>-0     [018] d.h1   828.523085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.523085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.523087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826860000000 softexpires=826860000000
          <idle>-0     [001] d..2   828.523087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826860000000 softexpires=826860000000
          <idle>-0     [000] d..2   828.528228: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.528229: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826876000000 softexpires=826876000000
          <idle>-0     [018] d.h2   828.539084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.539084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.539084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826860001260
          <idle>-0     [001] d.h1   828.539084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826860001460
          <idle>-0     [018] d.h1   828.539085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.539085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.539087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826876000000 softexpires=826876000000
          <idle>-0     [001] d..2   828.539087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826876000000 softexpires=826876000000
          <idle>-0     [000] d..2   828.543505: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.543505: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826892000000 softexpires=826892000000
          <idle>-0     [018] d.h2   828.555084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.555084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.555084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826876001240
          <idle>-0     [001] d.h1   828.555084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826876001420
          <idle>-0     [018] d.h1   828.555085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.555085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.555087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826892000000 softexpires=826892000000
          <idle>-0     [001] d..2   828.555088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826892000000 softexpires=826892000000
          <idle>-0     [000] d..2   828.560170: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.560171: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826908000000 softexpires=826908000000
          <idle>-0     [018] d.h2   828.571084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.571084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.571084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826892001320
          <idle>-0     [001] d.h1   828.571084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826892001520
          <idle>-0     [018] d.h1   828.571085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.571085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.571087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826908000000 softexpires=826908000000
          <idle>-0     [001] d..2   828.571088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826908000000 softexpires=826908000000
          <idle>-0     [000] d..2   828.575447: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.575448: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
          <idle>-0     [000] dn.2   828.585170: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   828.585171: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826908000000 softexpires=826908000000
          <idle>-0     [018] d.h2   828.587084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.587084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h1   828.587084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   828.587084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826908001200
          <idle>-0     [001] d.h1   828.587084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826908001420
              ps-2012  [000] d.h.   828.587085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=826908001320
          <idle>-0     [018] d.h1   828.587085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.587085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.587086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
              ps-2012  [000] d.h.   828.587088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h1   828.587088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826912000000 softexpires=826912000000
              ps-2012  [000] d.s1   828.587090: timer_cancel: timer=ffff0000090295a8
              ps-2012  [000] d.s.   828.587090: timer_expire_entry: timer=ffff0000090295a8 function=delayed_work_timer_fn now=4295099024
              ps-2012  [000] dns.   828.587092: timer_expire_exit: timer=ffff0000090295a8
          <idle>-0     [001] d..2   828.587095: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
          <idle>-0     [001] dn.2   828.587101: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] dn.2   828.587101: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826912000000 softexpires=826912000000
          <idle>-0     [018] dn.2   828.587106: hrtimer_cancel: hrtimer=ffff8017fbc74808
     kworker/1:1-1158  [001] d..1   828.587107: timer_start: timer=ffff8017fbe5e558 function=delayed_work_timer_fn expires=4295099247 [timeout=223] cpu=1 idx=131 flags=D|I
          <idle>-0     [018] dn.2   828.587107: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826912000000 softexpires=826912000000
     kworker/0:0-3     [000] d..1   828.587108: timer_start: timer=ffff0000090295a8 function=delayed_work_timer_fn expires=4295099250 [timeout=226] cpu=0 idx=80 flags=D|I
          <idle>-0     [001] d..1   828.587110: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   828.587110: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.587110: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
     kworker/0:0-3     [000] d..1   828.587112: timer_start: timer=ffff8017fbe43558 function=delayed_work_timer_fn expires=4295099250 [timeout=226] cpu=0 idx=101 flags=D|I
    kworker/18:1-1177  [018] d..1   828.587115: timer_start: timer=ffff8017fbc76558 function=delayed_work_timer_fn expires=4295099446 [timeout=422] cpu=18 idx=70 flags=D|I
          <idle>-0     [018] d..1   828.587119: tick_stop: success=1 dependency=NONE
          <idle>-0     [018] d..2   828.587119: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   828.587120: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
          <idle>-0     [000] d..1   828.587808: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   828.587809: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.587809: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826924000000 softexpires=826924000000
          <idle>-0     [000] d..2   828.591939: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.591940: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826940000000 softexpires=826940000000
          <idle>-0     [018] d.h2   828.603084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.603084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.603084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826924001400
          <idle>-0     [001] d.h1   828.603084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826924001640
          <idle>-0     [018] d.h1   828.603085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.603086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.603088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826940000000 softexpires=826940000000
          <idle>-0     [001] d..2   828.603088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826940000000 softexpires=826940000000
          <idle>-0     [000] d..2   828.607216: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.607217: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826956000000 softexpires=826956000000
          <idle>-0     [018] d.h2   828.619084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.619084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.619084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826940001300
          <idle>-0     [001] d.h1   828.619084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826940001520
          <idle>-0     [018] d.h1   828.619085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.619085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.619087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826956000000 softexpires=826956000000
          <idle>-0     [001] d..2   828.619088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826956000000 softexpires=826956000000
          <idle>-0     [000] d..2   828.623882: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.623882: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826972000000 softexpires=826972000000
          <idle>-0     [018] d.h2   828.635084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.635084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.635084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826956001340
          <idle>-0     [001] d.h1   828.635084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826956001540
          <idle>-0     [018] d.h1   828.635085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.635085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   828.635087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826972000000 softexpires=826972000000
          <idle>-0     [018] d..2   828.635087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826972000000 softexpires=826972000000
          <idle>-0     [000] d..2   828.639158: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.639159: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=826988000000 softexpires=826988000000
          <idle>-0     [018] d.h2   828.651084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.651084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.651084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826972001300
          <idle>-0     [001] d.h1   828.651084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826972001520
          <idle>-0     [018] d.h1   828.651085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.651085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.651086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=826988000000 softexpires=826988000000
          <idle>-0     [001] d..2   828.651088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=826988000000 softexpires=826988000000
          <idle>-0     [000] d..2   828.655824: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.655825: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827004000000 softexpires=827004000000
          <idle>-0     [018] d.h2   828.667084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.667084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.667084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=826988001320
          <idle>-0     [001] d.h1   828.667084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=826988001540
          <idle>-0     [018] d.h1   828.667085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.667085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.667087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827004000000 softexpires=827004000000
          <idle>-0     [001] d..2   828.667087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827004000000 softexpires=827004000000
          <idle>-0     [000] d..2   828.671101: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.671101: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827020000000 softexpires=827020000000
          <idle>-0     [018] d.h2   828.683084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.683084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.683084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827004001340
          <idle>-0     [001] d.h1   828.683084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827004001520
          <idle>-0     [018] d.h1   828.683085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.683085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.683086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827020000000 softexpires=827020000000
          <idle>-0     [001] d..2   828.683088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827020000000 softexpires=827020000000
          <idle>-0     [000] d..2   828.687766: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.687767: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827036000000 softexpires=827036000000
          <idle>-0     [018] d.h2   828.699084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.699084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.699084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827020001320
          <idle>-0     [001] d.h1   828.699084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827020001520
          <idle>-0     [018] d.h1   828.699085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.699085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.699087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827036000000 softexpires=827036000000
          <idle>-0     [001] d..2   828.699088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827036000000 softexpires=827036000000
          <idle>-0     [000] d..2   828.704432: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.704433: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827052000000 softexpires=827052000000
          <idle>-0     [018] d.h2   828.715084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.715084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.715084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827036001320
          <idle>-0     [001] d.h1   828.715084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827036001520
          <idle>-0     [018] d.h1   828.715085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.715085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.715086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827052000000 softexpires=827052000000
          <idle>-0     [001] d..2   828.715088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827052000000 softexpires=827052000000
          <idle>-0     [000] d..2   828.719709: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.719709: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827068000000 softexpires=827068000000
          <idle>-0     [018] d.h2   828.731084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.731084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.731084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827052001320
          <idle>-0     [001] d.h1   828.731084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827052001520
          <idle>-0     [018] d.h1   828.731085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.731085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.731087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827068000000 softexpires=827068000000
          <idle>-0     [001] d..2   828.731087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827068000000 softexpires=827068000000
          <idle>-0     [000] d..2   828.736374: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.736375: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827084000000 softexpires=827084000000
          <idle>-0     [018] d.h2   828.747084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.747084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.747084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827068001320
          <idle>-0     [001] d.h1   828.747084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827068001500
          <idle>-0     [018] d.h1   828.747085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.747085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.747086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827084000000 softexpires=827084000000
          <idle>-0     [001] d..2   828.747088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827084000000 softexpires=827084000000
          <idle>-0     [000] d..2   828.751651: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.751652: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827100000000 softexpires=827100000000
          <idle>-0     [018] d.h2   828.763084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.763084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.763084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827084001340
          <idle>-0     [001] d.h1   828.763084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827084001560
          <idle>-0     [018] d.h1   828.763085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.763085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.763087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827100000000 softexpires=827100000000
          <idle>-0     [001] d..2   828.763087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827100000000 softexpires=827100000000
          <idle>-0     [000] d..2   828.768317: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.768317: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827116000000 softexpires=827116000000
          <idle>-0     [018] d.h2   828.779084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.779084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.779084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827100001320
          <idle>-0     [001] d.h1   828.779085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827100001520
          <idle>-0     [018] d.h1   828.779085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.779086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.779086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827116000000 softexpires=827116000000
          <idle>-0     [001] d..2   828.779088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827116000000 softexpires=827116000000
          <idle>-0     [000] d..2   828.783594: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.783594: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827132000000 softexpires=827132000000
          <idle>-0     [018] d.h2   828.795084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.795084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.795084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827116001320
          <idle>-0     [001] d.h1   828.795084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827116001520
          <idle>-0     [018] d.h1   828.795085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.795085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.795087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827132000000 softexpires=827132000000
          <idle>-0     [001] d..2   828.795087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827132000000 softexpires=827132000000
          <idle>-0     [000] d..2   828.800259: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.800260: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827148000000 softexpires=827148000000
          <idle>-0     [018] d.h2   828.811084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.811084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.811084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827132001320
          <idle>-0     [001] d.h1   828.811084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827132001520
          <idle>-0     [018] d.h1   828.811085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.811085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.811086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827148000000 softexpires=827148000000
          <idle>-0     [001] d..2   828.811088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827148000000 softexpires=827148000000
          <idle>-0     [000] d..2   828.815536: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.815537: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827164000000 softexpires=827164000000
          <idle>-0     [018] d.h2   828.827084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.827084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.827084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827148001300
          <idle>-0     [001] d.h1   828.827084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827148001500
          <idle>-0     [018] d.h1   828.827085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.827085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.827087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827164000000 softexpires=827164000000
          <idle>-0     [001] d..2   828.827087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827164000000 softexpires=827164000000
          <idle>-0     [000] d..2   828.832202: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.832202: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827180000000 softexpires=827180000000
          <idle>-0     [018] d.h2   828.843084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.843084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.843084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827164001320
          <idle>-0     [001] d.h1   828.843084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827164001520
          <idle>-0     [018] d.h1   828.843085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.843085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.843086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827180000000 softexpires=827180000000
          <idle>-0     [001] d..2   828.843088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827180000000 softexpires=827180000000
          <idle>-0     [000] d..2   828.847478: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.847479: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827196000000 softexpires=827196000000
          <idle>-0     [018] d.h2   828.859084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.859084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.859084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827180001300
          <idle>-0     [001] d.h1   828.859084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827180001500
          <idle>-0     [018] d.h1   828.859085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.859085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.859087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827196000000 softexpires=827196000000
          <idle>-0     [001] d..2   828.859087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827196000000 softexpires=827196000000
          <idle>-0     [000] d..2   828.864144: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.864145: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827212000000 softexpires=827212000000
          <idle>-0     [018] d.h2   828.875084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.875084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.875084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827196001320
          <idle>-0     [001] d.h1   828.875084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827196001500
          <idle>-0     [018] d.h1   828.875085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.875085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.875086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827212000000 softexpires=827212000000
          <idle>-0     [001] d..2   828.875087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827212000000 softexpires=827212000000
          <idle>-0     [000] d..2   828.879421: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.879421: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827228000000 softexpires=827228000000
          <idle>-0     [018] d.h2   828.891084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.891084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.891084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827212001340
          <idle>-0     [001] d.h1   828.891084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827212001560
          <idle>-0     [018] d.h1   828.891085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.891085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.891087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827228000000 softexpires=827228000000
          <idle>-0     [001] d..2   828.891087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827228000000 softexpires=827228000000
          <idle>-0     [000] d..2   828.896086: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.896087: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827244000000 softexpires=827244000000
          <idle>-0     [018] d.h2   828.907084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.907084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.907084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827228001300
          <idle>-0     [001] d.h1   828.907084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827228001500
          <idle>-0     [018] d.h1   828.907085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.907085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.907086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827244000000 softexpires=827244000000
          <idle>-0     [001] d..2   828.907088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827244000000 softexpires=827244000000
          <idle>-0     [000] d..2   828.911363: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.911364: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827260000000 softexpires=827260000000
          <idle>-0     [000] dn.2   828.921086: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   828.921087: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827244000000 softexpires=827244000000
          <idle>-0     [018] d.h2   828.923084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.923084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h1   828.923084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   828.923084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827244001340
          <idle>-0     [001] d.h1   828.923084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827244001520
              ps-2012  [000] d.h.   828.923085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=827244001400
          <idle>-0     [018] d.h1   828.923085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.923085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.923087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827260000000 softexpires=827260000000
              ps-2012  [000] d.h.   828.923088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h1   828.923088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827248000000 softexpires=827248000000
          <idle>-0     [001] d..2   828.923089: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827260000000 softexpires=827260000000
          <idle>-0     [000] d..1   828.923707: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   828.923708: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.923708: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827260000000 softexpires=827260000000
          <idle>-0     [000] d..2   828.927855: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.927856: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827276000000 softexpires=827276000000
          <idle>-0     [018] d.h2   828.939084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.939084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.939084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827260001320
          <idle>-0     [001] d.h1   828.939084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827260001560
          <idle>-0     [018] d.h1   828.939085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.939085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.939086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827276000000 softexpires=827276000000
          <idle>-0     [001] d..2   828.939088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827276000000 softexpires=827276000000
          <idle>-0     [000] d..2   828.943132: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.943133: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827292000000 softexpires=827292000000
          <idle>-0     [018] d.h2   828.955084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.955084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.955084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827276001340
          <idle>-0     [001] d.h1   828.955084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827276001560
          <idle>-0     [018] d.h1   828.955085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.955085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.955087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827292000000 softexpires=827292000000
          <idle>-0     [001] d..2   828.955087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827292000000 softexpires=827292000000
          <idle>-0     [000] d..2   828.959798: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.959798: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827308000000 softexpires=827308000000
          <idle>-0     [018] d.h2   828.971084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.971084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.971084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827292001300
          <idle>-0     [001] d.h1   828.971084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827292001480
          <idle>-0     [018] d.h1   828.971085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.971085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.971086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827308000000 softexpires=827308000000
          <idle>-0     [001] d..2   828.971088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827308000000 softexpires=827308000000
          <idle>-0     [000] d..2   828.976463: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.976464: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827324000000 softexpires=827324000000
          <idle>-0     [018] d.h2   828.987084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   828.987084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   828.987084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827308001320
          <idle>-0     [001] d.h1   828.987084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827308001520
          <idle>-0     [018] d.h1   828.987085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   828.987085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   828.987087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827324000000 softexpires=827324000000
          <idle>-0     [001] d..2   828.987087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827324000000 softexpires=827324000000
          <idle>-0     [000] d..2   828.991740: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   828.991741: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827340000000 softexpires=827340000000
          <idle>-0     [018] d.h2   829.003084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.003084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.003084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827324001300
          <idle>-0     [001] d.h1   829.003084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827324001520
          <idle>-0     [018] d.h1   829.003085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.003085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.003086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827340000000 softexpires=827340000000
          <idle>-0     [001] d..2   829.003088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827340000000 softexpires=827340000000
          <idle>-0     [000] d..2   829.008406: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.008406: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827356000000 softexpires=827356000000
          <idle>-0     [018] d.h2   829.019084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.019084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.019084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827340001340
          <idle>-0     [001] d.h1   829.019084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827340001580
          <idle>-0     [018] d.h1   829.019085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.019085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.019087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827356000000 softexpires=827356000000
          <idle>-0     [001] d..2   829.019087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827356000000 softexpires=827356000000
          <idle>-0     [000] d..2   829.023682: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.023683: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827372000000 softexpires=827372000000
          <idle>-0     [018] d.h2   829.035084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.035084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.035084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827356001300
          <idle>-0     [001] d.h1   829.035084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827356001520
          <idle>-0     [018] d.h1   829.035085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.035085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.035087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827372000000 softexpires=827372000000
          <idle>-0     [001] d..2   829.035088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827372000000 softexpires=827372000000
          <idle>-0     [000] d..2   829.040348: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.040349: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827388000000 softexpires=827388000000
          <idle>-0     [018] d.h2   829.051084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.051084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.051084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827372001300
          <idle>-0     [001] d.h1   829.051084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827372001480
          <idle>-0     [018] d.h1   829.051085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.051085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   829.051087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827388000000 softexpires=827388000000
          <idle>-0     [018] d..2   829.051087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827388000000 softexpires=827388000000
          <idle>-0     [001] d.h2   829.067085: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h2   829.067085: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   829.067085: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.067086: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827388002960
          <idle>-0     [018] d.h1   829.067086: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827388003120
          <idle>-0     [034] d.h2   829.067086: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [000] d.h1   829.067086: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=827388002980
          <idle>-0     [034] d.h1   829.067086: hrtimer_expire_entry: hrtimer=ffff8017dba91808 function=tick_sched_timer now=827388003140
          <idle>-0     [018] d.h1   829.067087: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.067087: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   829.067088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [034] d.h1   829.067088: hrtimer_expire_exit: hrtimer=ffff8017dba91808
          <idle>-0     [018] d..2   829.067088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827404000000 softexpires=827404000000
          <idle>-0     [034] d.s2   829.067089: timer_cancel: timer=ffff00000909a9a0
          <idle>-0     [000] d.s2   829.067089: timer_cancel: timer=ffff8017d3923408
          <idle>-0     [034] d.s1   829.067089: timer_expire_entry: timer=ffff00000909a9a0 function=delayed_work_timer_fn now=4295099144
          <idle>-0     [000] d.s1   829.067089: timer_expire_entry: timer=ffff8017d3923408 function=delayed_work_timer_fn now=4295099144
          <idle>-0     [001] d..2   829.067089: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827404000000 softexpires=827404000000
          <idle>-0     [034] dns1   829.067091: timer_expire_exit: timer=ffff00000909a9a0
          <idle>-0     [000] dns1   829.067091: timer_expire_exit: timer=ffff8017d3923408
          <idle>-0     [034] dn.2   829.067094: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=827392000000 softexpires=827392000000
          <idle>-0     [000] dn.2   829.067094: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827392000000 softexpires=827392000000
     kworker/0:0-3     [000] d..1   829.067097: timer_start: timer=ffff8017d3923408 function=delayed_work_timer_fn expires=4295099394 [timeout=250] cpu=0 idx=97 flags=I
          <idle>-0     [000] d..1   829.067100: tick_stop: success=1 dependency=NONE
    kworker/34:2-1587  [034] d..1   829.067101: timer_start: timer=ffff00000909a9a0 function=delayed_work_timer_fn expires=4295099394 [timeout=250] cpu=34 idx=97 flags=I
          <idle>-0     [000] d..2   829.067101: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.067102: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827404000000 softexpires=827404000000
          <idle>-0     [034] d..1   829.067104: tick_stop: success=1 dependency=NONE
          <idle>-0     [034] d..2   829.067104: hrtimer_cancel: hrtimer=ffff8017dba91808
          <idle>-0     [034] d..2   829.067104: hrtimer_start: hrtimer=ffff8017dba91808 function=tick_sched_timer expires=828412000000 softexpires=828412000000
          <idle>-0     [000] d..2   829.072292: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.072292: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827420000000 softexpires=827420000000
          <idle>-0     [018] d.h2   829.083084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.083084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.083084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827404001380
          <idle>-0     [001] d.h1   829.083084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827404001600
          <idle>-0     [018] d.h1   829.083085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.083086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.083087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827420000000 softexpires=827420000000
          <idle>-0     [001] d..2   829.083088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827420000000 softexpires=827420000000
          <idle>-0     [000] d.h2   829.099084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   829.099084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.099084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.099084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827420001460
          <idle>-0     [000] d.h1   829.099084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=827420001460
          <idle>-0     [001] d.h1   829.099084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827420001660
          <idle>-0     [018] d.h1   829.099085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.099085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   829.099086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   829.099086: timer_cancel: timer=ffff8017d3923c08
          <idle>-0     [018] d..2   829.099087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827436000000 softexpires=827436000000
          <idle>-0     [000] d.s1   829.099087: timer_expire_entry: timer=ffff8017d3923c08 function=delayed_work_timer_fn now=4295099152
          <idle>-0     [001] d..2   829.099088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827436000000 softexpires=827436000000
          <idle>-0     [000] dns1   829.099088: timer_expire_exit: timer=ffff8017d3923c08
          <idle>-0     [000] dn.2   829.099092: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827424000000 softexpires=827424000000
     kworker/0:0-3     [000] d..1   829.099094: timer_start: timer=ffff8017d3923c08 function=delayed_work_timer_fn expires=4295099402 [timeout=250] cpu=0 idx=98 flags=I
          <idle>-0     [000] d..1   829.099096: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.099097: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.099097: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827436000000 softexpires=827436000000
          <idle>-0     [000] d..2   829.104233: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.104233: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827452000000 softexpires=827452000000
          <idle>-0     [018] d.h2   829.115084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.115084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.115084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827436001340
          <idle>-0     [001] d.h1   829.115084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827436001540
          <idle>-0     [018] d.h1   829.115085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.115085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.115087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827452000000 softexpires=827452000000
          <idle>-0     [001] d..2   829.115087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827452000000 softexpires=827452000000
          <idle>-0     [000] d..2   829.119510: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.119510: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827468000000 softexpires=827468000000
          <idle>-0     [018] d.h2   829.131084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.131084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.131084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827452001360
          <idle>-0     [001] d.h1   829.131084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827452001580
          <idle>-0     [018] d.h1   829.131085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.131085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.131086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827468000000 softexpires=827468000000
          <idle>-0     [001] d..2   829.131087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827468000000 softexpires=827468000000
          <idle>-0     [000] d..2   829.136175: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.136176: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827484000000 softexpires=827484000000
          <idle>-0     [018] d.h2   829.147084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.147084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.147084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827468001400
          <idle>-0     [001] d.h1   829.147084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827468001620
          <idle>-0     [018] d.h1   829.147085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.147085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.147087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827484000000 softexpires=827484000000
          <idle>-0     [001] d..2   829.147087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827484000000 softexpires=827484000000
          <idle>-0     [000] d..2   829.151452: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.151453: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827500000000 softexpires=827500000000
          <idle>-0     [018] d.h2   829.163084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.163084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.163084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827484001300
          <idle>-0     [001] d.h1   829.163084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827484001480
          <idle>-0     [018] d.h1   829.163085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.163085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.163086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827500000000 softexpires=827500000000
          <idle>-0     [001] d..2   829.163087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827500000000 softexpires=827500000000
          <idle>-0     [000] d..2   829.168118: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.168118: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827516000000 softexpires=827516000000
          <idle>-0     [018] d.h2   829.179084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.179084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   829.179084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827500001540
          <idle>-0     [018] d.h1   829.179084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827500001340
          <idle>-0     [001] d.h1   829.179085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.179085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d..2   829.179087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827516000000 softexpires=827516000000
          <idle>-0     [018] d..2   829.179088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827516000000 softexpires=827516000000
          <idle>-0     [000] d..2   829.183394: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.183395: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827532000000 softexpires=827532000000
          <idle>-0     [018] d.h2   829.195084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.195084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.195084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827516001340
          <idle>-0     [001] d.h1   829.195084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827516001540
          <idle>-0     [018] d.h1   829.195085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.195085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.195086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827532000000 softexpires=827532000000
          <idle>-0     [001] d..2   829.195088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827532000000 softexpires=827532000000
          <idle>-0     [000] d..2   829.200060: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.200061: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827548000000 softexpires=827548000000
          <idle>-0     [018] d.h2   829.211084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.211084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.211084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827532001380
          <idle>-0     [001] d.h1   829.211084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827532001560
          <idle>-0     [018] d.h1   829.211085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.211085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   829.211087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827548000000 softexpires=827548000000
          <idle>-0     [018] d..2   829.211087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827548000000 softexpires=827548000000
          <idle>-0     [000] d..2   829.215337: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.215337: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827564000000 softexpires=827564000000
          <idle>-0     [018] d.h2   829.227084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.227084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.227084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827548001340
          <idle>-0     [001] d.h1   829.227084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827548001560
          <idle>-0     [018] d.h1   829.227085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.227085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.227086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827564000000 softexpires=827564000000
          <idle>-0     [001] d..2   829.227088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827564000000 softexpires=827564000000
          <idle>-0     [000] d..2   829.232002: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.232003: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827580000000 softexpires=827580000000
          <idle>-0     [018] d.h2   829.243084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.243084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.243084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827564001360
          <idle>-0     [001] d.h1   829.243084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827564001580
          <idle>-0     [018] d.h1   829.243085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.243085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.243087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827580000000 softexpires=827580000000
          <idle>-0     [001] d..2   829.243087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827580000000 softexpires=827580000000
          <idle>-0     [000] d..2   829.247279: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.247280: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827596000000 softexpires=827596000000
          <idle>-0     [000] dn.2   829.257002: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.257003: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827580000000 softexpires=827580000000
          <idle>-0     [018] d.h2   829.259084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.259084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h1   829.259084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   829.259084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827580001360
          <idle>-0     [001] d.h1   829.259084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827580001540
              ps-2012  [000] d.h.   829.259085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=827580001460
          <idle>-0     [018] d.h1   829.259085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.259085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.259086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827596000000 softexpires=827596000000
              ps-2012  [000] d.h.   829.259088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h1   829.259089: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827584000000 softexpires=827584000000
          <idle>-0     [001] d..2   829.259094: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827596000000 softexpires=827596000000
          <idle>-0     [000] d..1   829.259641: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.259642: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.259642: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827596000000 softexpires=827596000000
          <idle>-0     [000] d..2   829.263771: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.263772: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827612000000 softexpires=827612000000
          <idle>-0     [018] d.h2   829.275084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.275084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.275084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827596001380
          <idle>-0     [001] d.h1   829.275084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827596001620
          <idle>-0     [018] d.h1   829.275085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.275085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.275087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827612000000 softexpires=827612000000
          <idle>-0     [001] d..2   829.275087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827612000000 softexpires=827612000000
          <idle>-0     [000] d..2   829.280437: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.280437: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827628000000 softexpires=827628000000
          <idle>-0     [018] d.h2   829.291084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.291084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.291084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827612001360
          <idle>-0     [001] d.h1   829.291084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827612001580
          <idle>-0     [018] d.h1   829.291085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.291085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.291086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827628000000 softexpires=827628000000
          <idle>-0     [001] d..2   829.291088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827628000000 softexpires=827628000000
          <idle>-0     [000] d..2   829.295714: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.295714: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827644000000 softexpires=827644000000
          <idle>-0     [018] d.h2   829.307084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.307084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.307084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827628001420
          <idle>-0     [001] d.h1   829.307084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827628001640
          <idle>-0     [018] d.h1   829.307085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.307085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.307087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827644000000 softexpires=827644000000
          <idle>-0     [001] d..2   829.307087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827644000000 softexpires=827644000000
          <idle>-0     [000] d..2   829.312379: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.312380: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827660000000 softexpires=827660000000
          <idle>-0     [018] d.h2   829.323084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.323084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.323084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827644001340
          <idle>-0     [001] d.h1   829.323085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827644001560
          <idle>-0     [018] d.h1   829.323085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.323086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.323086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827660000000 softexpires=827660000000
          <idle>-0     [001] d..2   829.323088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827660000000 softexpires=827660000000
          <idle>-0     [000] d..2   829.327656: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.327657: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827676000000 softexpires=827676000000
          <idle>-0     [018] d.h2   829.339084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.339084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.339084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827660001460
          <idle>-0     [001] d.h1   829.339084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827660001660
          <idle>-0     [018] d.h1   829.339085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.339085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.339087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827676000000 softexpires=827676000000
          <idle>-0     [001] d..2   829.339087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827676000000 softexpires=827676000000
          <idle>-0     [000] d..2   829.344322: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.344322: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827692000000 softexpires=827692000000
          <idle>-0     [018] d.h2   829.355084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.355084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.355084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827676001340
          <idle>-0     [001] d.h1   829.355084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827676001560
          <idle>-0     [018] d.h1   829.355085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.355085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.355086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827692000000 softexpires=827692000000
          <idle>-0     [001] d..2   829.355088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827692000000 softexpires=827692000000
          <idle>-0     [000] d..2   829.359599: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.359599: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827708000000 softexpires=827708000000
          <idle>-0     [018] d.h2   829.371084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.371084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.371084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827692001360
          <idle>-0     [001] d.h1   829.371084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827692001580
          <idle>-0     [018] d.h1   829.371085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.371085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.371087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827708000000 softexpires=827708000000
          <idle>-0     [001] d..2   829.371087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827708000000 softexpires=827708000000
          <idle>-0     [000] d..2   829.376264: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.376265: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827724000000 softexpires=827724000000
          <idle>-0     [018] d.h2   829.387084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.387084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.387084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827708001360
          <idle>-0     [001] d.h1   829.387084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827708001560
          <idle>-0     [018] d.h1   829.387085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.387085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.387086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827724000000 softexpires=827724000000
          <idle>-0     [001] d..2   829.387088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827724000000 softexpires=827724000000
          <idle>-0     [000] d..2   829.391541: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.391541: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827740000000 softexpires=827740000000
          <idle>-0     [018] d.h2   829.403084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.403084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.403084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827724001380
          <idle>-0     [001] d.h1   829.403084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827724001580
          <idle>-0     [018] d.h1   829.403085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.403085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.403087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827740000000 softexpires=827740000000
          <idle>-0     [001] d..2   829.403087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827740000000 softexpires=827740000000
          <idle>-0     [000] d..2   829.408206: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.408207: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827756000000 softexpires=827756000000
          <idle>-0     [018] d.h2   829.419084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.419084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.419084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827740001360
          <idle>-0     [001] d.h1   829.419084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827740001560
          <idle>-0     [018] d.h1   829.419085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.419085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.419086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827756000000 softexpires=827756000000
          <idle>-0     [001] d..2   829.419088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827756000000 softexpires=827756000000
          <idle>-0     [000] d..2   829.423483: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.423484: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827772000000 softexpires=827772000000
          <idle>-0     [018] d.h2   829.435084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.435084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.435084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827756001340
          <idle>-0     [001] d.h1   829.435084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827756001560
          <idle>-0     [018] d.h1   829.435085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.435085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.435087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827772000000 softexpires=827772000000
          <idle>-0     [001] d..2   829.435087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827772000000 softexpires=827772000000
          <idle>-0     [000] d..2   829.440149: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.440149: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827788000000 softexpires=827788000000
          <idle>-0     [018] d.h2   829.451084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.451084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.451084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827772001360
          <idle>-0     [001] d.h1   829.451084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827772001560
          <idle>-0     [018] d.h1   829.451085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.451085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.451087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827788000000 softexpires=827788000000
          <idle>-0     [001] d..2   829.451088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827788000000 softexpires=827788000000
          <idle>-0     [000] d..2   829.455426: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.455426: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827804000000 softexpires=827804000000
          <idle>-0     [018] d.h2   829.467084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.467084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.467084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827788001380
          <idle>-0     [001] d.h1   829.467084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827788001560
          <idle>-0     [018] d.h1   829.467085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.467085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   829.467087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827804000000 softexpires=827804000000
          <idle>-0     [018] d..2   829.467087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827804000000 softexpires=827804000000
          <idle>-0     [000] d..2   829.472091: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.472092: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827820000000 softexpires=827820000000
          <idle>-0     [018] d.h2   829.483084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.483084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.483084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827804001360
          <idle>-0     [001] d.h1   829.483084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827804001580
          <idle>-0     [018] d.h1   829.483085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.483085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.s2   829.483086: timer_cancel: timer=ffff8017fbe5e558
          <idle>-0     [018] d..2   829.483086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827820000000 softexpires=827820000000
          <idle>-0     [001] d.s1   829.483087: timer_expire_entry: timer=ffff8017fbe5e558 function=delayed_work_timer_fn now=4295099248
          <idle>-0     [001] dns1   829.483089: timer_expire_exit: timer=ffff8017fbe5e558
          <idle>-0     [001] dn.2   829.483091: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827808000000 softexpires=827808000000
          <idle>-0     [001] d..1   829.483097: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   829.483098: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   829.483098: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827820000000 softexpires=827820000000
          <idle>-0     [000] d..2   829.487368: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.487369: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827836000000 softexpires=827836000000
          <idle>-0     [018] d.h2   829.499084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.499084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.499084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827820001420
          <idle>-0     [001] d.h1   829.499084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827820001660
          <idle>-0     [018] d.h1   829.499085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.499085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.499087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827836000000 softexpires=827836000000
          <idle>-0     [001] d..2   829.499088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827836000000 softexpires=827836000000
          <idle>-0     [000] d..2   829.504034: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.504034: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827852000000 softexpires=827852000000
          <idle>-0     [018] d.h2   829.515084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.515084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.515084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827836001640
          <idle>-0     [001] d.h1   829.515084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827836001780
          <idle>-0     [018] d.h1   829.515085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.515085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.515087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827852000000 softexpires=827852000000
          <idle>-0     [001] d..2   829.515088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827852000000 softexpires=827852000000
          <idle>-0     [000] d..2   829.519310: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.519311: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827868000000 softexpires=827868000000
          <idle>-0     [018] d.h2   829.531084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.531084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.531084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827852001340
          <idle>-0     [001] d.h1   829.531084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827852001540
          <idle>-0     [018] d.h1   829.531085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.531085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.531087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827868000000 softexpires=827868000000
          <idle>-0     [001] d..2   829.531087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827868000000 softexpires=827868000000
          <idle>-0     [000] d..2   829.535976: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.535977: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827884000000 softexpires=827884000000
          <idle>-0     [018] d.h2   829.547084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.547084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.547084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827868001360
          <idle>-0     [001] d.h1   829.547084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827868001560
          <idle>-0     [018] d.h1   829.547085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.547085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.547086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827884000000 softexpires=827884000000
          <idle>-0     [001] d..2   829.547088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827884000000 softexpires=827884000000
          <idle>-0     [000] d..2   829.551253: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.551253: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827900000000 softexpires=827900000000
          <idle>-0     [018] d.h2   829.563084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.563084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.563084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827884001380
          <idle>-0     [001] d.h1   829.563084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827884001580
          <idle>-0     [018] d.h1   829.563085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.563085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.563087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827900000000 softexpires=827900000000
          <idle>-0     [001] d..2   829.563087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827900000000 softexpires=827900000000
          <idle>-0     [000] d..2   829.567918: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.567919: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827916000000 softexpires=827916000000
          <idle>-0     [018] d.h2   829.579084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.579084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.579084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827900001360
          <idle>-0     [001] d.h1   829.579084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827900001600
          <idle>-0     [018] d.h1   829.579085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.579085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.579087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827916000000 softexpires=827916000000
          <idle>-0     [001] d..2   829.579088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827916000000 softexpires=827916000000
          <idle>-0     [000] d..2   829.583195: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.583196: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827932000000 softexpires=827932000000
          <idle>-0     [000] dn.2   829.592918: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.592919: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827916000000 softexpires=827916000000
          <idle>-0     [018] d.h2   829.595084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.595084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
              ps-2012  [000] d.h1   829.595084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   829.595084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827916001380
          <idle>-0     [001] d.h1   829.595084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827916001600
              ps-2012  [000] d.h.   829.595085: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=827916001380
          <idle>-0     [018] d.h1   829.595085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.595086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.595087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827932000000 softexpires=827932000000
              ps-2012  [000] d.h.   829.595088: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
              ps-2012  [000] d.h1   829.595088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827920000000 softexpires=827920000000
              ps-2012  [000] d.s1   829.595090: timer_cancel: timer=ffff8017fbe43558
              ps-2012  [000] d.s.   829.595090: timer_expire_entry: timer=ffff8017fbe43558 function=delayed_work_timer_fn now=4295099276
              ps-2012  [000] dns.   829.595092: timer_expire_exit: timer=ffff8017fbe43558
              ps-2012  [000] dns1   829.595092: timer_cancel: timer=ffff0000090295a8
              ps-2012  [000] dns.   829.595093: timer_expire_entry: timer=ffff0000090295a8 function=delayed_work_timer_fn now=4295099276
              ps-2012  [000] dns.   829.595093: timer_expire_exit: timer=ffff0000090295a8
          <idle>-0     [001] d..2   829.595094: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827932000000 softexpires=827932000000
     kworker/0:0-3     [000] d..1   829.595102: timer_start: timer=ffff8017fbe43558 function=delayed_work_timer_fn expires=4295099500 [timeout=224] cpu=0 idx=111 flags=D|I
     kworker/0:0-3     [000] d..1   829.595109: timer_start: timer=ffff0000090295a8 function=delayed_work_timer_fn expires=4295099500 [timeout=224] cpu=0 idx=111 flags=D|I
          <idle>-0     [001] dn.2   829.595344: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] dn.2   829.595344: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827920000000 softexpires=827920000000
          <idle>-0     [000] d..1   829.595363: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.595364: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.595365: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827932000000 softexpires=827932000000
          <idle>-0     [001] d..1   829.595418: tick_stop: success=1 dependency=NONE
          <idle>-0     [001] d..2   829.595419: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d..2   829.595419: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827932000000 softexpires=827932000000
          <idle>-0     [000] d..2   829.599340: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.599341: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827948000000 softexpires=827948000000
          <idle>-0     [018] d.h2   829.611084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.611084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.611085: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827932001760
          <idle>-0     [001] d.h1   829.611085: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827932002100
          <idle>-0     [018] d.h1   829.611086: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.611086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.611087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827948000000 softexpires=827948000000
          <idle>-0     [001] d..2   829.611090: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827948000000 softexpires=827948000000
          <idle>-0     [000] d..2   829.616006: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.616006: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827964000000 softexpires=827964000000
          <idle>-0     [018] d.h2   829.627084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.627084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.627084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827948001600
          <idle>-0     [001] d.h1   829.627084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827948001860
          <idle>-0     [018] d.h1   829.627085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.627086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.627087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827964000000 softexpires=827964000000
          <idle>-0     [001] d..2   829.627088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827964000000 softexpires=827964000000
          <idle>-0     [000] d..2   829.631282: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.631283: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827980000000 softexpires=827980000000
          <idle>-0     [018] d.h2   829.643084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.643084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.643084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827964001500
          <idle>-0     [001] d.h1   829.643084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827964001720
          <idle>-0     [018] d.h1   829.643085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.643085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.643087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827980000000 softexpires=827980000000
          <idle>-0     [001] d..2   829.643088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827980000000 softexpires=827980000000
          <idle>-0     [000] d..2   829.647948: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.647949: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=827996000000 softexpires=827996000000
          <idle>-0     [018] d.h2   829.659084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.659084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.659084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827980001460
          <idle>-0     [001] d.h1   829.659084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827980001680
          <idle>-0     [018] d.h1   829.659085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.659085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.659087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=827996000000 softexpires=827996000000
          <idle>-0     [001] d..2   829.659088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=827996000000 softexpires=827996000000
          <idle>-0     [000] d..2   829.663225: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.663225: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828012000000 softexpires=828012000000
          <idle>-0     [018] d.h2   829.675084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.675084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.675084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=827996001340
          <idle>-0     [001] d.h1   829.675084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=827996001560
          <idle>-0     [018] d.h1   829.675085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.675085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.675086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828012000000 softexpires=828012000000
          <idle>-0     [001] d..2   829.675088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828012000000 softexpires=828012000000
          <idle>-0     [000] d..2   829.679890: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.679891: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828028000000 softexpires=828028000000
          <idle>-0     [018] d.h2   829.691084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.691084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.691084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828012001360
          <idle>-0     [001] d.h1   829.691084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828012001560
          <idle>-0     [018] d.h1   829.691085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.691085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.691087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828028000000 softexpires=828028000000
          <idle>-0     [001] d..2   829.691087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828028000000 softexpires=828028000000
          <idle>-0     [000] d..2   829.695167: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.695168: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828044000000 softexpires=828044000000
          <idle>-0     [018] d.h2   829.707084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.707084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.707084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828028001380
          <idle>-0     [001] d.h1   829.707084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828028001600
          <idle>-0     [018] d.h1   829.707085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.707085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.707086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828044000000 softexpires=828044000000
          <idle>-0     [001] d..2   829.707088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828044000000 softexpires=828044000000
          <idle>-0     [000] d..2   829.711833: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.711833: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828060000000 softexpires=828060000000
          <idle>-0     [018] d.h2   829.723084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.723084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [001] d.h1   829.723084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828044001580
          <idle>-0     [018] d.h1   829.723084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828044001380
          <idle>-0     [001] d.h1   829.723085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.723085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d..2   829.723087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828060000000 softexpires=828060000000
          <idle>-0     [018] d..2   829.723088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828060000000 softexpires=828060000000
          <idle>-0     [000] d..2   829.727110: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.727110: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828076000000 softexpires=828076000000
          <idle>-0     [018] d.h2   829.739084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.739084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.739084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828060001360
          <idle>-0     [001] d.h1   829.739084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828060001580
          <idle>-0     [018] d.h1   829.739085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.739085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.739086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828076000000 softexpires=828076000000
          <idle>-0     [001] d..2   829.739088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828076000000 softexpires=828076000000
          <idle>-0     [000] d..2   829.743775: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.743776: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828092000000 softexpires=828092000000
          <idle>-0     [018] d.h2   829.755084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.755084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.755084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828076001360
          <idle>-0     [001] d.h1   829.755084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828076001540
          <idle>-0     [001] d.h1   829.755085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.755085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   829.755087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828092000000 softexpires=828092000000
          <idle>-0     [001] d..2   829.755087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828092000000 softexpires=828092000000
          <idle>-0     [000] d..2   829.760441: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.760441: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828108000000 softexpires=828108000000
          <idle>-0     [018] d.h2   829.771084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.771084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.771084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828092001360
          <idle>-0     [001] d.h1   829.771084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828092001540
          <idle>-0     [018] d.h1   829.771085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.771085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.771086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828108000000 softexpires=828108000000
          <idle>-0     [001] d..2   829.771088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828108000000 softexpires=828108000000
          <idle>-0     [000] d..2   829.775718: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.775718: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828124000000 softexpires=828124000000
          <idle>-0     [018] d.h2   829.787084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.787084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.787084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828108001380
          <idle>-0     [001] d.h1   829.787084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828108001600
          <idle>-0     [018] d.h1   829.787085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.787085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.787087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828124000000 softexpires=828124000000
          <idle>-0     [001] d..2   829.787088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828124000000 softexpires=828124000000
          <idle>-0     [000] d..2   829.792383: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.792384: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828140000000 softexpires=828140000000
          <idle>-0     [018] d.h2   829.803084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.803084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.803084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828124001360
          <idle>-0     [001] d.h1   829.803084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828124001540
          <idle>-0     [018] d.h1   829.803085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.803085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.803086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828140000000 softexpires=828140000000
          <idle>-0     [001] d..2   829.803088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828140000000 softexpires=828140000000
          <idle>-0     [000] d..2   829.807660: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.807661: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828156000000 softexpires=828156000000
          <idle>-0     [018] d.h2   829.819084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.819084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.819084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828140001340
          <idle>-0     [001] d.h1   829.819084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828140001520
          <idle>-0     [018] d.h1   829.819085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.819086: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.819087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828156000000 softexpires=828156000000
          <idle>-0     [001] d..2   829.819088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828156000000 softexpires=828156000000
          <idle>-0     [000] d..2   829.824326: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.824326: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828172000000 softexpires=828172000000
          <idle>-0     [018] d.h2   829.835084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.835084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.835084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828156001340
          <idle>-0     [001] d.h1   829.835084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828156001540
          <idle>-0     [018] d.h1   829.835085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.835085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.835086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828172000000 softexpires=828172000000
          <idle>-0     [001] d..2   829.835088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828172000000 softexpires=828172000000
          <idle>-0     [000] d..2   829.839602: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.839603: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828188000000 softexpires=828188000000
          <idle>-0     [018] d.h2   829.851084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.851084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.851084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828172001380
          <idle>-0     [001] d.h1   829.851084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828172001580
          <idle>-0     [018] d.h1   829.851085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.851085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.851087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828188000000 softexpires=828188000000
          <idle>-0     [001] d..2   829.851088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828188000000 softexpires=828188000000
          <idle>-0     [000] d..2   829.856268: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.856269: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [018] d.h2   829.867084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.867084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.867084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828188001420
          <idle>-0     [001] d.h1   829.867084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828188001640
          <idle>-0     [018] d.h1   829.867085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.867085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.867086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [001] d..2   829.867088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [000] d..2   829.871545: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.871545: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.872935: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.872936: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828196000000 softexpires=828196000000
          <idle>-0     [000] d..1   829.872940: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.872941: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.872941: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.874323: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.874324: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828196000000 softexpires=828196000000
          <idle>-0     [000] d..1   829.874327: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.874327: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.874328: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.875713: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.875713: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828200000000 softexpires=828200000000
          <idle>-0     [000] d..1   829.875717: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.875717: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.875718: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.877101: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.877101: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828200000000 softexpires=828200000000
          <idle>-0     [000] d..1   829.877104: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.877105: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.877105: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.878489: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.878490: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828200000000 softexpires=828200000000
          <idle>-0     [000] d..1   829.878493: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.878493: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.878494: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.879879: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.879880: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [000] d..1   829.879883: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.879883: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.879884: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.881267: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.881268: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [000] d..1   829.881271: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.881271: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.881271: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.882656: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.882656: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828204000000 softexpires=828204000000
          <idle>-0     [000] d..1   829.882659: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.882660: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.882660: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [018] d.h2   829.883084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.883084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.883084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828204001360
          <idle>-0     [001] d.h1   829.883084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828204001580
          <idle>-0     [018] d.h1   829.883085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.883085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.883087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [001] d..2   829.883087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.884045: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.884046: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828208000000 softexpires=828208000000
          <idle>-0     [000] d..1   829.884049: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.884049: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.884049: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.885433: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.885434: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828208000000 softexpires=828208000000
          <idle>-0     [000] d..1   829.885437: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.885437: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.885438: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.886822: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.886823: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828208000000 softexpires=828208000000
          <idle>-0     [000] d..1   829.886826: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.886826: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.886826: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
          <idle>-0     [000] dn.2   829.888212: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.888213: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828212000000 softexpires=828212000000
          <idle>-0     [000] d..1   829.888216: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.888216: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.888217: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] dn.2   829.889600: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.889600: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828212000000 softexpires=828212000000
          <idle>-0     [000] d..1   829.889603: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.889604: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.889604: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] dn.2   829.890989: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.890989: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828212000000 softexpires=828212000000
          <idle>-0     [000] d..1   829.890992: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.890992: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.890993: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] dn.2   829.892378: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.892379: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828216000000 softexpires=828216000000
          <idle>-0     [000] d..1   829.892382: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.892382: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.892383: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] dn.2   829.893766: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.893767: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828216000000 softexpires=828216000000
          <idle>-0     [000] d..1   829.893770: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.893770: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.893771: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] dn.2   829.895155: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] dn.2   829.895156: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828220000000 softexpires=828220000000
              sh-1993  [000] ....   829.895158: timer_init: timer=ffff8017db00fb40
              sh-1993  [000] d..1   829.895158: timer_start: timer=ffff8017db00fb40 function=process_timeout expires=4295099353 [timeout=2] cpu=0 idx=0 flags=
          <idle>-0     [000] d..1   829.895161: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.895161: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.895161: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828228000000 softexpires=828228000000
          <idle>-0     [018] d.h2   829.899084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.899084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.899084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828220001340
          <idle>-0     [001] d.h1   829.899084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828220001540
          <idle>-0     [018] d.h1   829.899085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.899085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.899086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [001] d..2   829.899088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828236000000 softexpires=828236000000
          <idle>-0     [000] d.h2   829.907084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.h1   829.907084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828228001680
          <idle>-0     [000] d.h1   829.907086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d.s2   829.907087: timer_cancel: timer=ffff8017db00fb40
          <idle>-0     [000] ..s1   829.907087: timer_expire_entry: timer=ffff8017db00fb40 function=process_timeout now=4295099354
          <idle>-0     [000] .ns1   829.907089: timer_expire_exit: timer=ffff8017db00fb40
          <idle>-0     [000] dn.2   829.907092: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828232000000 softexpires=828232000000
          <idle>-0     [000] d..1   829.907120: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2   829.907120: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [000] d..2   829.907121: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828252000000 softexpires=828252000000
          <idle>-0     [018] d.h2   829.915084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.915084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.915084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828236001260
          <idle>-0     [001] d.h1   829.915084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828236001480
          <idle>-0     [018] d.h1   829.915085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.915085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.915087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828252000000 softexpires=828252000000
          <idle>-0     [001] d..2   829.915087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828252000000 softexpires=828252000000
          <idle>-0     [018] d.h2   829.931084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h2   829.931084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h2   829.931084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.931084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828252001300
          <idle>-0     [000] d.h1   829.931084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828252001300
          <idle>-0     [001] d.h1   829.931084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828252001460
          <idle>-0     [018] d.h1   829.931085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.931085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   829.931085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d..2   829.931086: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828268000000 softexpires=828268000000
          <idle>-0     [001] d..2   829.931088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828268000000 softexpires=828268000000
          <idle>-0     [000] d..2   829.931098: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828268000000 softexpires=828268000000
          <idle>-0     [001] d.h2   829.947084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h2   829.947084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h2   829.947084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h1   829.947084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828268001500
          <idle>-0     [018] d.h1   829.947084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828268001480
          <idle>-0     [000] d.h1   829.947084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828268001740
          <idle>-0     [001] d.h1   829.947085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.947085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h1   829.947086: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d..2   829.947087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828284000000 softexpires=828284000000
          <idle>-0     [001] d..2   829.947087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828284000000 softexpires=828284000000
          <idle>-0     [000] d..2   829.947089: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828284000000 softexpires=828284000000
          <idle>-0     [000] d.h2   829.963084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   829.963084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   829.963084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   829.963084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828284001460
          <idle>-0     [000] d.h1   829.963084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828284001480
          <idle>-0     [001] d.h1   829.963084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828284001600
          <idle>-0     [018] d.h1   829.963085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h1   829.963085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h1   829.963085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.963087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828300000000 softexpires=828300000000
          <idle>-0     [001] d..2   829.963088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828300000000 softexpires=828300000000
          <idle>-0     [000] d..2   829.963088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828300000000 softexpires=828300000000
          <idle>-0     [018] d.h2   829.979085: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d.h1   829.979085: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828300002260
          <idle>-0     [000] d.h2   829.979087: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h2   829.979088: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   829.979088: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828300005100
          <idle>-0     [001] d.h1   829.979088: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828300005260
          <idle>-0     [018] d.h1   829.979088: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h1   829.979089: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h1   829.979089: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d..2   829.979090: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828316000000 softexpires=828316000000
          <idle>-0     [001] d..2   829.979091: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828316000000 softexpires=828316000000
          <idle>-0     [000] d..2   829.979092: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828316000000 softexpires=828316000000
          <idle>-0     [001] d.h2   829.995084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h2   829.995084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h2   829.995084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h1   829.995084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828316001520
          <idle>-0     [000] d.h1   829.995084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828316001680
          <idle>-0     [001] d.h1   829.995084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828316001460
          <idle>-0     [018] d.h1   829.995085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h1   829.995085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [000] d.h1   829.995085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d..2   829.995087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828332000000 softexpires=828332000000
          <idle>-0     [001] d..2   829.995088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828332000000 softexpires=828332000000
          <idle>-0     [000] d..2   829.995089: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828332000000 softexpires=828332000000
          <idle>-0     [000] d.h2   830.011084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d.h2   830.011084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [001] d.h2   830.011084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   830.011084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828332001440
          <idle>-0     [000] d.h1   830.011084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828332001480
          <idle>-0     [001] d.h1   830.011084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828332001640
          <idle>-0     [000] d.h1   830.011085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h1   830.011085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   830.011085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [018] d..2   830.011088: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828348000000 softexpires=828348000000
          <idle>-0     [001] d..2   830.011088: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828348000000 softexpires=828348000000
          <idle>-0     [000] d..2   830.011088: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828348000000 softexpires=828348000000
          <idle>-0     [001] d.h2   830.027084: hrtimer_cancel: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h2   830.027084: hrtimer_cancel: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h2   830.027084: hrtimer_cancel: hrtimer=ffff8017fbe41808
          <idle>-0     [001] d.h1   830.027084: hrtimer_expire_entry: hrtimer=ffff8017fbe5c808 function=tick_sched_timer now=828348001500
          <idle>-0     [018] d.h1   830.027084: hrtimer_expire_entry: hrtimer=ffff8017fbc74808 function=tick_sched_timer now=828348001500
          <idle>-0     [000] d.h1   830.027084: hrtimer_expire_entry: hrtimer=ffff8017fbe41808 function=tick_sched_timer now=828348001660
          <idle>-0     [001] d.h1   830.027085: hrtimer_expire_exit: hrtimer=ffff8017fbe5c808
          <idle>-0     [018] d.h1   830.027085: hrtimer_expire_exit: hrtimer=ffff8017fbc74808
          <idle>-0     [000] d.h1   830.027085: hrtimer_expire_exit: hrtimer=ffff8017fbe41808
          <idle>-0     [018] d..2   830.027087: hrtimer_start: hrtimer=ffff8017fbc74808 function=tick_sched_timer expires=828364000000 softexpires=828364000000
          <idle>-0     [001] d..2   830.027087: hrtimer_start: hrtimer=ffff8017fbe5c808 function=tick_sched_timer expires=828364000000 softexpires=828364000000
          <idle>-0     [000] d..2   830.027091: hrtimer_start: hrtimer=ffff8017fbe41808 function=tick_sched_timer expires=828364000000 softexpires=828364000000
 

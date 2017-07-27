Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJHlD16nmzDrJc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:40:07 +1000 (AEST)
Date: Thu, 27 Jul 2017 17:39:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, <abdhalee@linux.vnet.ibm.com>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170727173923.000001b2@huawei.com>
In-Reply-To: <20170727144903.000022a1@huawei.com>
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
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

On Thu, 27 Jul 2017 14:49:03 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Jul 2017 05:49:13 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Thu, Jul 27, 2017 at 02:34:00PM +1000, Nicholas Piggin wrote:  
> > > On Wed, 26 Jul 2017 18:42:14 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >     
> > > > On Wed, Jul 26, 2017 at 04:22:00PM -0700, David Miller wrote:    
> > >     
> > > > > Indeed, that really wouldn't explain how we end up with a RCU stall
> > > > > dump listing almost all of the cpus as having missed a grace period.      
> > > > 
> > > > I have seen stranger things, but admittedly not often.    
> > > 
> > > So the backtraces show the RCU gp thread in schedule_timeout.
> > > 
> > > Are you sure that it's timeout has expired and it's not being scheduled,
> > > or could it be a bad (large) timeout (looks unlikely) or that it's being
> > > scheduled but not correctly noting gps on other CPUs?
> > > 
> > > It's not in R state, so if it's not being scheduled at all, then it's
> > > because the timer has not fired:    
> > 
> > Good point, Nick!
> > 
> > Jonathan, could you please reproduce collecting timer event tracing?  
> I'm a little new to tracing (only started playing with it last week)
> so fingers crossed I've set it up right.  No splats yet.  Was getting
> splats on reading out the trace when running with the RCU stall timer
> set to 4 so have increased that back to the default and am rerunning.
> 
> This may take a while.  Correct me if I've gotten this wrong to save time
> 
> echo "timer:*" > /sys/kernel/debug/tracing/set_event
> 
> when it dumps, just send you the relevant part of what is in
> /sys/kernel/debug/tracing/trace?

Interestingly the only thing that can make trip for me with tracing on
is peaking in the tracing buffers.  Not sure this is a valid case or
not.

Anyhow all timer activity seems to stop around the area of interest.


[ 9442.413624] INFO: rcu_sched detected stalls on CPUs/tasks:
[ 9442.419107] 	1-...: (1 GPs behind) idle=844/0/0 softirq=27747/27755 fqs=0 last_accelerate: dd6a/de80, nonlazy_posted: 0, L.
[ 9442.430224] 	3-...: (2 GPs behind) idle=8f8/0/0 softirq=32197/32198 fqs=0 last_accelerate: 29b1/de80, nonlazy_posted: 0, L.
[ 9442.441340] 	4-...: (7 GPs behind) idle=740/0/0 softirq=22351/22352 fqs=0 last_accelerate: ca88/de80, nonlazy_posted: 0, L.
[ 9442.452456] 	5-...: (2 GPs behind) idle=9b0/0/0 softirq=21315/21319 fqs=0 last_accelerate: b280/de88, nonlazy_posted: 0, L.
[ 9442.463572] 	6-...: (2 GPs behind) idle=794/0/0 softirq=19699/19707 fqs=0 last_accelerate: ba62/de88, nonlazy_posted: 0, L.
[ 9442.474688] 	7-...: (2 GPs behind) idle=ac4/0/0 softirq=22547/22554 fqs=0 last_accelerate: b280/de88, nonlazy_posted: 0, L.
[ 9442.485803] 	8-...: (9 GPs behind) idle=118/0/0 softirq=281/291 fqs=0 last_accelerate: c3fe/de88, nonlazy_posted: 0, L.
[ 9442.496571] 	9-...: (9 GPs behind) idle=8fc/0/0 softirq=284/292 fqs=0 last_accelerate: 6030/de88, nonlazy_posted: 0, L.
[ 9442.507339] 	10-...: (14 GPs behind) idle=f78/0/0 softirq=254/254 fqs=0 last_accelerate: 5487/de88, nonlazy_posted: 0, L.
[ 9442.518281] 	11-...: (9 GPs behind) idle=c9c/0/0 softirq=301/308 fqs=0 last_accelerate: 3d3e/de99, nonlazy_posted: 0, L.
[ 9442.529136] 	12-...: (9 GPs behind) idle=4a4/0/0 softirq=735/737 fqs=0 last_accelerate: 6010/de99, nonlazy_posted: 0, L.
[ 9442.539992] 	13-...: (9 GPs behind) idle=34c/0/0 softirq=1121/1131 fqs=0 last_accelerate: b280/de99, nonlazy_posted: 0, L.
[ 9442.551020] 	14-...: (9 GPs behind) idle=2f4/0/0 softirq=707/713 fqs=0 last_accelerate: 6030/de99, nonlazy_posted: 0, L.
[ 9442.561875] 	15-...: (2 GPs behind) idle=b30/0/0 softirq=821/976 fqs=0 last_accelerate: c208/de99, nonlazy_posted: 0, L.
[ 9442.572730] 	17-...: (2 GPs behind) idle=5a8/0/0 softirq=1456/1565 fqs=0 last_accelerate: ca88/de99, nonlazy_posted: 0, L.
[ 9442.583759] 	18-...: (2 GPs behind) idle=2e4/0/0 softirq=1923/1936 fqs=0 last_accelerate: ca88/dea7, nonlazy_posted: 0, L.
[ 9442.594787] 	19-...: (2 GPs behind) idle=138/0/0 softirq=1421/1432 fqs=0 last_accelerate: b280/dea7, nonlazy_posted: 0, L.
[ 9442.605816] 	20-...: (50 GPs behind) idle=634/0/0 softirq=217/219 fqs=0 last_accelerate: c96f/dea7, nonlazy_posted: 0, L.
[ 9442.616758] 	21-...: (2 GPs behind) idle=eb8/0/0 softirq=1368/1369 fqs=0 last_accelerate: b599/deb2, nonlazy_posted: 0, L.
[ 9442.627786] 	22-...: (1 GPs behind) idle=aa8/0/0 softirq=229/232 fqs=0 last_accelerate: c604/deb2, nonlazy_posted: 0, L.
[ 9442.638641] 	23-...: (1 GPs behind) idle=488/0/0 softirq=247/248 fqs=0 last_accelerate: c600/deb2, nonlazy_posted: 0, L.
[ 9442.649496] 	24-...: (33 GPs behind) idle=f7c/0/0 softirq=319/319 fqs=0 last_accelerate: 5290/deb2, nonlazy_posted: 0, L.
[ 9442.660437] 	25-...: (33 GPs behind) idle=944/0/0 softirq=308/308 fqs=0 last_accelerate: 52c0/deb2, nonlazy_posted: 0, L.
[ 9442.671379] 	26-...: (9 GPs behind) idle=6d4/0/0 softirq=265/275 fqs=0 last_accelerate: 6034/dec0, nonlazy_posted: 0, L.
[ 9442.682234] 	27-...: (115 GPs behind) idle=e3c/0/0 softirq=212/226 fqs=0 last_accelerate: 5420/dec0, nonlazy_posted: 0, L.
[ 9442.693263] 	28-...: (9 GPs behind) idle=ea4/0/0 softirq=540/552 fqs=0 last_accelerate: 603c/dec0, nonlazy_posted: 0, L.
[ 9442.704118] 	29-...: (115 GPs behind) idle=83c/0/0 softirq=342/380 fqs=0 last_accelerate: 5420/dec0, nonlazy_posted: 0, L.
[ 9442.715147] 	30-...: (33 GPs behind) idle=e3c/0/0 softirq=509/509 fqs=0 last_accelerate: 52bc/dec0, nonlazy_posted: 0, L.
[ 9442.726088] 	31-...: (9 GPs behind) idle=df4/0/0 softirq=619/641 fqs=0 last_accelerate: 603c/decb, nonlazy_posted: 0, L.
[ 9442.736944] 	32-...: (9 GPs behind) idle=aa4/0/0 softirq=1841/1848 fqs=0 last_accelerate: 6030/decb, nonlazy_posted: 0, L.
[ 9442.747972] 	34-...: (9 GPs behind) idle=e6c/0/0 softirq=5082/5086 fqs=0 last_accelerate: 6039/decb, nonlazy_posted: 0, L.
[ 9442.759001] 	35-...: (9 GPs behind) idle=7fc/0/0 softirq=1396/1406 fqs=0 last_accelerate: 603e/decb, nonlazy_posted: 0, L.
[ 9442.770030] 	36-...: (0 ticks this GP) idle=f28/0/0 softirq=255/255 fqs=0 last_accelerate: c9fc/decb, nonlazy_posted: 0, L.
[ 9442.781145] 	37-...: (50 GPs behind) idle=53c/0/0 softirq=227/230 fqs=0 last_accelerate: 45c0/decb, nonlazy_posted: 0, L.
[ 9442.792087] 	38-...: (9 GPs behind) idle=958/0/0 softirq=185/192 fqs=0 last_accelerate: 6030/decb, nonlazy_posted: 0, L.
[ 9442.802942] 	40-...: (389 GPs behind) idle=41c/0/0 softirq=131/136 fqs=0 last_accelerate: 5800/decb, nonlazy_posted: 0, L.
[ 9442.813971] 	41-...: (389 GPs behind) idle=258/0/0 softirq=133/138 fqs=0 last_accelerate: c00f/decb, nonlazy_posted: 0, L.
[ 9442.825000] 	43-...: (50 GPs behind) idle=254/0/0 softirq=113/117 fqs=0 last_accelerate: 5420/dee5, nonlazy_posted: 0, L.
[ 9442.835942] 	44-...: (115 GPs behind) idle=178/0/0 softirq=1271/1276 fqs=0 last_accelerate: 68e9/dee5, nonlazy_posted: 0, L.
[ 9442.847144] 	45-...: (2 GPs behind) idle=04a/1/0 softirq=364/389 fqs=0 last_accelerate: dee5/dee5, nonlazy_posted: 0, L.
[ 9442.857999] 	46-...: (9 GPs behind) idle=ec4/0/0 softirq=183/189 fqs=0 last_accelerate: 6030/dee5, nonlazy_posted: 0, L.
[ 9442.868854] 	47-...: (115 GPs behind) idle=088/0/0 softirq=135/149 fqs=0 last_accelerate: 5420/dee5, nonlazy_posted: 0, L.
[ 9442.879883] 	48-...: (389 GPs behind) idle=200/0/0 softirq=103/110 fqs=0 last_accelerate: 58b0/dee5, nonlazy_posted: 0, L.
[ 9442.890911] 	49-...: (9 GPs behind) idle=a24/0/0 softirq=205/211 fqs=0 last_accelerate: 6030/dee5, nonlazy_posted: 0, L.
[ 9442.901766] 	50-...: (25 GPs behind) idle=a74/0/0 softirq=144/144 fqs=0 last_accelerate: 5420/dee5, nonlazy_posted: 0, L.
[ 9442.912708] 	51-...: (50 GPs behind) idle=f68/0/0 softirq=116/122 fqs=0 last_accelerate: 57bc/dee5, nonlazy_posted: 0, L.
[ 9442.923650] 	52-...: (9 GPs behind) idle=e08/0/0 softirq=202/486 fqs=0 last_accelerate: c87f/defe, nonlazy_posted: 0, L.
[ 9442.934505] 	53-...: (2 GPs behind) idle=128/0/0 softirq=365/366 fqs=0 last_accelerate: ca88/defe, nonlazy_posted: 0, L.
[ 9442.945360] 	54-...: (9 GPs behind) idle=ce8/0/0 softirq=126/373 fqs=0 last_accelerate: bef8/defe, nonlazy_posted: 0, L.
[ 9442.956215] 	56-...: (9 GPs behind) idle=330/0/0 softirq=2116/2126 fqs=0 last_accelerate: 6030/defe, nonlazy_posted: 0, L.
[ 9442.967243] 	57-...: (1 GPs behind) idle=288/0/0 softirq=1707/1714 fqs=0 last_accelerate: c87c/defe, nonlazy_posted: 0, L.
[ 9442.978272] 	58-...: (37 GPs behind) idle=390/0/0 softirq=1716/1721 fqs=0 last_accelerate: 53f7/defe, nonlazy_posted: 0, L.
[ 9442.989387] 	59-...: (37 GPs behind) idle=e54/0/0 softirq=1700/1701 fqs=0 last_accelerate: 40a1/defe, nonlazy_posted: 0, L.
[ 9443.000502] 	60-...: (116 GPs behind) idle=7b4/0/0 softirq=92/96 fqs=0 last_accelerate: 57d8/df10, nonlazy_posted: 0, L.
[ 9443.011357] 	61-...: (9 GPs behind) idle=9d8/0/0 softirq=161/170 fqs=0 last_accelerate: 6030/df10, nonlazy_posted: 0, L.
[ 9443.022212] 	62-...: (115 GPs behind) idle=aa8/0/0 softirq=95/101 fqs=0 last_accelerate: 5420/df17, nonlazy_posted: 0, L.
[ 9443.033154] 	63-...: (50 GPs behind) idle=958/0/0 softirq=81/84 fqs=0 last_accelerate: 57b8/df17, nonlazy_posted: 0, L.
[ 9443.043920] 	(detected by 39, t=5403 jiffies, g=443, c=442, q=1)
[ 9443.049919] Task dump for CPU 1:
[ 9443.053134] swapper/1       R  running task        0     0      1 0x00000000
[ 9443.060173] Call trace:
[ 9443.062619] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.067744] [<          (null)>]           (null)
[ 9443.072434] Task dump for CPU 3:
[ 9443.075650] swapper/3       R  running task        0     0      1 0x00000000
[ 9443.082686] Call trace:
[ 9443.085121] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.090246] [<          (null)>]           (null)
[ 9443.094936] Task dump for CPU 4:
[ 9443.098152] swapper/4       R  running task        0     0      1 0x00000000
[ 9443.105188] Call trace:
[ 9443.107623] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.112752] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.118224] Task dump for CPU 5:
[ 9443.121440] swapper/5       R  running task        0     0      1 0x00000000
[ 9443.128476] Call trace:
[ 9443.130910] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.136035] [<          (null)>]           (null)
[ 9443.140725] Task dump for CPU 6:
[ 9443.143941] swapper/6       R  running task        0     0      1 0x00000000
[ 9443.150976] Call trace:
[ 9443.153411] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.158535] [<          (null)>]           (null)
[ 9443.163226] Task dump for CPU 7:
[ 9443.166442] swapper/7       R  running task        0     0      1 0x00000000
[ 9443.173478] Call trace:
[ 9443.175912] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.181037] [<          (null)>]           (null)
[ 9443.185727] Task dump for CPU 8:
[ 9443.188943] swapper/8       R  running task        0     0      1 0x00000000
[ 9443.195979] Call trace:
[ 9443.198412] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.203537] [<          (null)>]           (null)
[ 9443.208227] Task dump for CPU 9:
[ 9443.211443] swapper/9       R  running task        0     0      1 0x00000000
[ 9443.218479] Call trace:
[ 9443.220913] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.226039] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.231510] Task dump for CPU 10:
[ 9443.234812] swapper/10      R  running task        0     0      1 0x00000000
[ 9443.241848] Call trace:
[ 9443.244283] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.249408] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.254879] Task dump for CPU 11:
[ 9443.258182] swapper/11      R  running task        0     0      1 0x00000000
[ 9443.265218] Call trace:
[ 9443.267652] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.272776] [<          (null)>]           (null)
[ 9443.277467] Task dump for CPU 12:
[ 9443.280769] swapper/12      R  running task        0     0      1 0x00000000
[ 9443.287806] Call trace:
[ 9443.290240] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.295364] [<          (null)>]           (null)
[ 9443.300054] Task dump for CPU 13:
[ 9443.303357] swapper/13      R  running task        0     0      1 0x00000000
[ 9443.310394] Call trace:
[ 9443.312828] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.317953] [<          (null)>]           (null)
[ 9443.322643] Task dump for CPU 14:
[ 9443.325945] swapper/14      R  running task        0     0      1 0x00000000
[ 9443.332981] Call trace:
[ 9443.335416] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.340540] [<          (null)>]           (null)
[ 9443.345230] Task dump for CPU 15:
[ 9443.348533] swapper/15      R  running task        0     0      1 0x00000000
[ 9443.355568] Call trace:
[ 9443.358002] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.363128] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.368599] Task dump for CPU 17:
[ 9443.371901] swapper/17      R  running task        0     0      1 0x00000000
[ 9443.378937] Call trace:
[ 9443.381372] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.386497] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.391968] Task dump for CPU 18:
[ 9443.395270] swapper/18      R  running task        0     0      1 0x00000000
[ 9443.402306] Call trace:
[ 9443.404740] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.409865] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.415336] Task dump for CPU 19:
[ 9443.418639] swapper/19      R  running task        0     0      1 0x00000000
[ 9443.425675] Call trace:
[ 9443.428109] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.433234] [<          (null)>]           (null)
[ 9443.437924] Task dump for CPU 20:
[ 9443.441226] swapper/20      R  running task        0     0      1 0x00000000
[ 9443.448263] Call trace:
[ 9443.450697] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.455826] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9443.462600] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9443.467986] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.473458] Task dump for CPU 21:
[ 9443.476760] swapper/21      R  running task        0     0      1 0x00000000
[ 9443.483796] Call trace:
[ 9443.486230] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.491354] [<          (null)>]           (null)
[ 9443.496045] Task dump for CPU 22:
[ 9443.499347] swapper/22      R  running task        0     0      1 0x00000000
[ 9443.506383] Call trace:
[ 9443.508817] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.513943] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.519414] Task dump for CPU 23:
[ 9443.522716] swapper/23      R  running task        0     0      1 0x00000000
[ 9443.529752] Call trace:
[ 9443.532186] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.537312] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.542784] Task dump for CPU 24:
[ 9443.546086] swapper/24      R  running task        0     0      1 0x00000000
[ 9443.553122] Call trace:
[ 9443.555556] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.560681] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.566153] Task dump for CPU 25:
[ 9443.569455] swapper/25      R  running task        0     0      1 0x00000000
[ 9443.576491] Call trace:
[ 9443.578925] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.584051] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9443.590825] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9443.596211] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.601682] Task dump for CPU 26:
[ 9443.604985] swapper/26      R  running task        0     0      1 0x00000000
[ 9443.612021] Call trace:
[ 9443.614455] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.619581] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.625052] Task dump for CPU 27:
[ 9443.628355] swapper/27      R  running task        0     0      1 0x00000000
[ 9443.635390] Call trace:
[ 9443.637824] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.642949] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.648421] Task dump for CPU 28:
[ 9443.651723] swapper/28      R  running task        0     0      1 0x00000000
[ 9443.658759] Call trace:
[ 9443.661193] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.666318] [<          (null)>]           (null)
[ 9443.671008] Task dump for CPU 29:
[ 9443.674310] swapper/29      R  running task        0     0      1 0x00000000
[ 9443.681346] Call trace:
[ 9443.683780] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.688905] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.694377] Task dump for CPU 30:
[ 9443.697679] swapper/30      R  running task        0     0      1 0x00000000
[ 9443.704715] Call trace:
[ 9443.707150] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.712275] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9443.719050] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9443.724436] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.729907] Task dump for CPU 31:
[ 9443.733210] swapper/31      R  running task        0     0      1 0x00000000
[ 9443.740246] Call trace:
[ 9443.742680] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.747805] [<          (null)>]           (null)
[ 9443.752496] Task dump for CPU 32:
[ 9443.755798] swapper/32      R  running task        0     0      1 0x00000000
[ 9443.762833] Call trace:
[ 9443.765267] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.770392] [<          (null)>]           (null)
[ 9443.775082] Task dump for CPU 34:
[ 9443.778384] swapper/34      R  running task        0     0      1 0x00000000
[ 9443.785420] Call trace:
[ 9443.787854] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.792980] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.798451] Task dump for CPU 35:
[ 9443.801753] swapper/35      R  running task        0     0      1 0x00000000
[ 9443.808789] Call trace:
[ 9443.811224] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.816348] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.821820] Task dump for CPU 36:
[ 9443.825122] swapper/36      R  running task        0     0      1 0x00000000
[ 9443.832158] Call trace:
[ 9443.834592] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.839718] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9443.846493] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9443.851878] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.857350] Task dump for CPU 37:
[ 9443.860652] swapper/37      R  running task        0     0      1 0x00000000
[ 9443.867688] Call trace:
[ 9443.870122] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.875248] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9443.882022] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9443.887408] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.892880] Task dump for CPU 38:
[ 9443.896182] swapper/38      R  running task        0     0      1 0x00000000
[ 9443.903218] Call trace:
[ 9443.905652] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.910776] [<          (null)>]           (null)
[ 9443.915466] Task dump for CPU 40:
[ 9443.918769] swapper/40      R  running task        0     0      1 0x00000000
[ 9443.925805] Call trace:
[ 9443.928239] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.933365] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.938836] Task dump for CPU 41:
[ 9443.942138] swapper/41      R  running task        0     0      1 0x00000000
[ 9443.949174] Call trace:
[ 9443.951609] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.956733] [<          (null)>]           (null)
[ 9443.961423] Task dump for CPU 43:
[ 9443.964725] swapper/43      R  running task        0     0      1 0x00000000
[ 9443.971761] Call trace:
[ 9443.974195] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9443.979320] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9443.984791] Task dump for CPU 44:
[ 9443.988093] swapper/44      R  running task        0     0      1 0x00000000
[ 9443.995130] Call trace:
[ 9443.997564] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.002688] [<          (null)>]           (null)
[ 9444.007378] Task dump for CPU 45:
[ 9444.010680] swapper/45      R  running task        0     0      1 0x00000000
[ 9444.017716] Call trace:
[ 9444.020151] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.025275] [<          (null)>]           (null)
[ 9444.029965] Task dump for CPU 46:
[ 9444.033267] swapper/46      R  running task        0     0      1 0x00000000
[ 9444.040302] Call trace:
[ 9444.042737] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.047862] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.053333] Task dump for CPU 47:
[ 9444.056636] swapper/47      R  running task        0     0      1 0x00000000
[ 9444.063672] Call trace:
[ 9444.066106] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.071231] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.076702] Task dump for CPU 48:
[ 9444.080004] swapper/48      R  running task        0     0      1 0x00000000
[ 9444.087041] Call trace:
[ 9444.089475] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.094600] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.100071] Task dump for CPU 49:
[ 9444.103374] swapper/49      R  running task        0     0      1 0x00000000
[ 9444.110409] Call trace:
[ 9444.112844] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.117968] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.123440] Task dump for CPU 50:
[ 9444.126742] swapper/50      R  running task        0     0      1 0x00000000
[ 9444.133777] Call trace:
[ 9444.136211] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.141336] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.146807] Task dump for CPU 51:
[ 9444.150109] swapper/51      R  running task        0     0      1 0x00000000
[ 9444.157144] Call trace:
[ 9444.159578] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.164703] [<          (null)>]           (null)
[ 9444.169393] Task dump for CPU 52:
[ 9444.172695] swapper/52      R  running task        0     0      1 0x00000000
[ 9444.179731] Call trace:
[ 9444.182165] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.187290] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.192761] Task dump for CPU 53:
[ 9444.196063] swapper/53      R  running task        0     0      1 0x00000000
[ 9444.203099] Call trace:
[ 9444.205533] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.210658] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.216129] Task dump for CPU 54:
[ 9444.219431] swapper/54      R  running task        0     0      1 0x00000000
[ 9444.226467] Call trace:
[ 9444.228901] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.234026] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.239498] Task dump for CPU 56:
[ 9444.242801] swapper/56      R  running task        0     0      1 0x00000000
[ 9444.249837] Call trace:
[ 9444.252271] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.257396] [<          (null)>]           (null)
[ 9444.262086] Task dump for CPU 57:
[ 9444.265388] swapper/57      R  running task        0     0      1 0x00000000
[ 9444.272424] Call trace:
[ 9444.274858] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.279982] [<          (null)>]           (null)
[ 9444.284672] Task dump for CPU 58:
[ 9444.287975] swapper/58      R  running task        0     0      1 0x00000000
[ 9444.295011] Call trace:
[ 9444.297445] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.302570] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9444.309345] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9444.314731] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.320202] Task dump for CPU 59:
[ 9444.323504] swapper/59      R  running task        0     0      1 0x00000000
[ 9444.330540] Call trace:
[ 9444.332974] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.338100] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.343571] Task dump for CPU 60:
[ 9444.346873] swapper/60      R  running task        0     0      1 0x00000000
[ 9444.353909] Call trace:
[ 9444.356343] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.361469] [<ffff00000813cf78>] rcu_eqs_enter_common.isra.32+0x1b8/0x228
[ 9444.368243] [<ffff00000813d044>] rcu_idle_enter+0x5c/0x60
[ 9444.373629] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.379101] Task dump for CPU 61:
[ 9444.382402] swapper/61      R  running task        0     0      1 0x00000000
[ 9444.389438] Call trace:
[ 9444.391872] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.396997] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.402469] Task dump for CPU 62:
[ 9444.405771] swapper/62      R  running task        0     0      1 0x00000000
[ 9444.412808] Call trace:
[ 9444.415242] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.420367] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.425838] Task dump for CPU 63:
[ 9444.429141] swapper/63      R  running task        0     0      1 0x00000000
[ 9444.436177] Call trace:
[ 9444.438611] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.443736] [<ffff0000090d9df0>] __cpu_online_mask+0x0/0x8
[ 9444.449211] rcu_sched kthread starved for 5743 jiffies! g443 c442 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[ 9444.458416] rcu_sched       S    0    10      2 0x00000000
[ 9444.463889] Call trace:
[ 9444.466324] [<ffff000008085cb8>] __switch_to+0x90/0xa8
[ 9444.471453] [<ffff000008ab70a4>] __schedule+0x1a4/0x720
[ 9444.476665] [<ffff000008ab7660>] schedule+0x40/0xa8
[ 9444.481530] [<ffff000008abac70>] schedule_timeout+0x178/0x358
[ 9444.487263] [<ffff00000813e694>] rcu_gp_kthread+0x534/0x7b8
[ 9444.492824] [<ffff0000080f33d0>] kthread+0x108/0x138
[ 9444.497775] [<ffff0000080836c0>] ret_from_fork+0x10/0x50



And the relevant chunk of trace is:
(I have a lot more.  There are substantial other pauses from to time, but not this long)


   rcu_preempt-9     [057] ....  9419.837631: timer_init: timer=ffff8017d5fcfda0
     rcu_preempt-9     [057] d..1  9419.837632: timer_start: timer=ffff8017d5fcfda0 function=process_timeout expires=4297246837 [timeout=1] cpu=57 idx=0 flags=
          <idle>-0     [057] d..1  9419.837634: tick_stop: success=1 dependency=NONE
          <idle>-0     [057] d..2  9419.837634: hrtimer_cancel: hrtimer=ffff8017db99e808
          <idle>-0     [057] d..2  9419.837635: hrtimer_start: hrtimer=ffff8017db99e808 function=tick_sched_timer expires=9418164000000 softexpires=9418164000000
          <idle>-0     [057] d.h2  9419.845621: hrtimer_cancel: hrtimer=ffff8017db99e808
          <idle>-0     [057] d.h1  9419.845621: hrtimer_expire_entry: hrtimer=ffff8017db99e808 function=tick_sched_timer now=9418164001440
          <idle>-0     [057] d.h1  9419.845622: hrtimer_expire_exit: hrtimer=ffff8017db99e808
          <idle>-0     [057] d.s2  9419.845623: timer_cancel: timer=ffff8017d5fcfda0
          <idle>-0     [057] ..s1  9419.845623: timer_expire_entry: timer=ffff8017d5fcfda0 function=process_timeout now=4297246838
          <idle>-0     [057] .ns1  9419.845624: timer_expire_exit: timer=ffff8017d5fcfda0
          <idle>-0     [057] dn.2  9419.845628: hrtimer_start: hrtimer=ffff8017db99e808 function=tick_sched_timer expires=9418168000000 softexpires=9418168000000
          <idle>-0     [057] d..1  9419.845635: tick_stop: success=1 dependency=NONE
          <idle>-0     [057] d..2  9419.845636: hrtimer_cancel: hrtimer=ffff8017db99e808
          <idle>-0     [057] d..2  9419.845636: hrtimer_start: hrtimer=ffff8017db99e808 function=tick_sched_timer expires=9418188000000 softexpires=9418188000000
          <idle>-0     [057] d.h2  9419.869621: hrtimer_cancel: hrtimer=ffff8017db99e808
          <idle>-0     [057] d.h1  9419.869621: hrtimer_expire_entry: hrtimer=ffff8017db99e808 function=tick_sched_timer now=9418188001420
          <idle>-0     [057] d.h1  9419.869622: hrtimer_expire_exit: hrtimer=ffff8017db99e808
          <idle>-0     [057] d..2  9419.869626: hrtimer_start: hrtimer=ffff8017db99e808 function=tick_sched_timer expires=9858983202655 softexpires=9858983202655
          <idle>-0     [016] d.h2  9419.885626: hrtimer_cancel: hrtimer=ffff8017fbc3d808
          <idle>-0     [016] d.h1  9419.885627: hrtimer_expire_entry: hrtimer=ffff8017fbc3d808 function=tick_sched_timer now=9418204006760
          <idle>-0     [016] d.h1  9419.885629: hrtimer_expire_exit: hrtimer=ffff8017fbc3d808
          <idle>-0     [016] d.s2  9419.885629: timer_cancel: timer=ffff8017d37dbca0
          <idle>-0     [016] ..s1  9419.885630: timer_expire_entry: timer=ffff8017d37dbca0 function=process_timeout now=4297246848
          <idle>-0     [016] .ns1  9419.885631: timer_expire_exit: timer=ffff8017d37dbca0
          <idle>-0     [016] dn.2  9419.885636: hrtimer_start: hrtimer=ffff8017fbc3d808 function=tick_sched_timer expires=9418208000000 softexpires=9418208000000
      khugepaged-778   [016] ....  9419.885668: timer_init: timer=ffff8017d37dbca0
      khugepaged-778   [016] d..1  9419.885668: timer_start: timer=ffff8017d37dbca0 function=process_timeout expires=4297249348 [timeout=2500] cpu=16 idx=0 flags=
          <idle>-0     [016] d..1  9419.885670: tick_stop: success=1 dependency=NONE
          <idle>-0     [016] d..2  9419.885671: hrtimer_cancel: hrtimer=ffff8017fbc3d808
          <idle>-0     [016] d..2  9419.885671: hrtimer_start: hrtimer=ffff8017fbc3d808 function=tick_sched_timer expires=9428444000000 softexpires=9428444000000
          <idle>-0     [045] d.h2  9419.890839: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9419.890839: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418209219940
          <idle>-0     [045] d.h3  9419.890844: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418310221420 softexpires=9418309221420
          <idle>-0     [045] d.h1  9419.890844: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [000] d.h2  9419.917625: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.h1  9419.917626: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9418236005860
          <idle>-0     [000] d.h1  9419.917628: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9419.917628: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9419.917629: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_disable_link now=4297246856
          <idle>-0     [000] d.s2  9419.917630: timer_start: timer=ffff80177fdc0840 function=link_timeout_enable_link expires=4297246881 [timeout=25] cpu=0 idx=81 flags=
          <idle>-0     [000] ..s1  9419.917633: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d..2  9419.917648: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9418340000000 softexpires=9418340000000
          <idle>-0     [045] d.h2  9419.991845: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9419.991845: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418310225960
          <idle>-0     [045] d.h3  9419.991849: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418411227320 softexpires=9418410227320
          <idle>-0     [045] d.h1  9419.991850: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [000] d.h2  9420.021625: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.h1  9420.021625: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9418340005520
          <idle>-0     [000] d.h1  9420.021627: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9420.021627: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9420.021628: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_enable_link now=4297246882
          <idle>-0     [000] d.s2  9420.021629: timer_start: timer=ffff80177fdc0840 function=link_timeout_disable_link expires=4297247107 [timeout=225] cpu=0 idx=34 flags=
          <idle>-0     [000] ..s1  9420.021632: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d..2  9420.021639: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419260000000 softexpires=9419260000000
          <idle>-0     [045] d.h2  9420.092851: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.092852: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418411231780
          <idle>-0     [045] d.h3  9420.092856: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418512233720 softexpires=9418511233720
          <idle>-0     [045] d.h1  9420.092856: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [055] d.h2  9420.141622: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d.h1  9420.141623: hrtimer_expire_entry: hrtimer=ffff8017db968808 function=tick_sched_timer now=9418460002540
          <idle>-0     [055] d.h1  9420.141625: hrtimer_expire_exit: hrtimer=ffff8017db968808
          <idle>-0     [055] d.s2  9420.141626: timer_cancel: timer=ffff80177db6cc08
          <idle>-0     [055] d.s1  9420.141626: timer_expire_entry: timer=ffff80177db6cc08 function=delayed_work_timer_fn now=4297246912
          <idle>-0     [055] dns1  9420.141628: timer_expire_exit: timer=ffff80177db6cc08
          <idle>-0     [055] dn.2  9420.141632: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9418464000000 softexpires=9418464000000
    kworker/55:1-1246  [055] d..1  9420.141634: timer_start: timer=ffff80177db6cc08 function=delayed_work_timer_fn expires=4297247162 [timeout=250] cpu=55 idx=88 flags=I
          <idle>-0     [055] d..1  9420.141637: tick_stop: success=1 dependency=NONE
          <idle>-0     [055] d..2  9420.141637: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d..2  9420.141637: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9419484000000 softexpires=9419484000000
          <idle>-0     [045] d.h2  9420.193855: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.193855: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418512235660
          <idle>-0     [045] d.h3  9420.193859: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418613237260 softexpires=9418612237260
          <idle>-0     [045] d.h1  9420.193860: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9420.294858: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.294858: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418613238380
          <idle>-0     [045] d.h3  9420.294862: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418714240000 softexpires=9418713240000
          <idle>-0     [045] d.h1  9420.294863: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9420.395861: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.395861: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418714241380
          <idle>-0     [045] d.h3  9420.395865: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418815242920 softexpires=9418814242920
          <idle>-0     [045] d.h1  9420.395865: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [042] d.h2  9420.461621: hrtimer_cancel: hrtimer=ffff8017dbb69808
          <idle>-0     [042] d.h1  9420.461622: hrtimer_expire_entry: hrtimer=ffff8017dbb69808 function=tick_sched_timer now=9418780002180
          <idle>-0     [042] d.h1  9420.461623: hrtimer_expire_exit: hrtimer=ffff8017dbb69808
          <idle>-0     [042] d.s2  9420.461624: timer_cancel: timer=ffff80177db6d408
          <idle>-0     [042] d.s1  9420.461625: timer_expire_entry: timer=ffff80177db6d408 function=delayed_work_timer_fn now=4297246992
          <idle>-0     [042] dns1  9420.461627: timer_expire_exit: timer=ffff80177db6d408
          <idle>-0     [042] dns2  9420.461627: timer_cancel: timer=ffff8017797d7868
          <idle>-0     [042] .ns1  9420.461628: timer_expire_entry: timer=ffff8017797d7868 function=hns_nic_service_timer now=4297246992
          <idle>-0     [042] dns2  9420.461628: timer_start: timer=ffff8017797d7868 function=hns_nic_service_timer expires=4297247242 [timeout=250] cpu=42 idx=98 flags=
          <idle>-0     [042] .ns1  9420.461629: timer_expire_exit: timer=ffff8017797d7868
          <idle>-0     [042] dn.2  9420.461632: hrtimer_start: hrtimer=ffff8017dbb69808 function=tick_sched_timer expires=9418784000000 softexpires=9418784000000
    kworker/42:1-1223  [042] d..1  9420.461773: timer_start: timer=ffff80177db6d408 function=delayed_work_timer_fn expires=4297247242 [timeout=250] cpu=42 idx=98 flags=I
          <idle>-0     [042] d..1  9420.461866: tick_stop: success=1 dependency=NONE
          <idle>-0     [042] d..2  9420.461867: hrtimer_cancel: hrtimer=ffff8017dbb69808
          <idle>-0     [042] d..2  9420.461867: hrtimer_start: hrtimer=ffff8017dbb69808 function=tick_sched_timer expires=9419804000000 softexpires=9419804000000
          <idle>-0     [045] d.h2  9420.496864: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.496864: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418815244580
          <idle>-0     [045] d.h3  9420.496868: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9418916246140 softexpires=9418915246140
          <idle>-0     [045] d.h1  9420.496868: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9420.597866: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.597867: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9418916247280
          <idle>-0     [045] d.h3  9420.597871: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419017248760 softexpires=9419016248760
          <idle>-0     [045] d.h1  9420.597871: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [033] d.h2  9420.621621: hrtimer_cancel: hrtimer=ffff8017dba76808
          <idle>-0     [033] d.h1  9420.621622: hrtimer_expire_entry: hrtimer=ffff8017dba76808 function=tick_sched_timer now=9418940002160
          <idle>-0     [033] d.h1  9420.621623: hrtimer_expire_exit: hrtimer=ffff8017dba76808
          <idle>-0     [033] d.s2  9420.621624: timer_cancel: timer=ffff00000917be40
          <idle>-0     [033] d.s1  9420.621625: timer_expire_entry: timer=ffff00000917be40 function=delayed_work_timer_fn now=4297247032
          <idle>-0     [033] dns1  9420.621626: timer_expire_exit: timer=ffff00000917be40
          <idle>-0     [033] dn.2  9420.621630: hrtimer_start: hrtimer=ffff8017dba76808 function=tick_sched_timer expires=9418944000000 softexpires=9418944000000
           <...>-1631  [033] d..1  9420.621636: timer_start: timer=ffff00000917be40 function=delayed_work_timer_fn expires=4297247282 [timeout=250] cpu=33 idx=103 flags=I
          <idle>-0     [033] d..1  9420.621639: tick_stop: success=1 dependency=NONE
          <idle>-0     [033] d..2  9420.621639: hrtimer_cancel: hrtimer=ffff8017dba76808
          <idle>-0     [033] d..2  9420.621639: hrtimer_start: hrtimer=ffff8017dba76808 function=tick_sched_timer expires=9419964000000 softexpires=9419964000000
          <idle>-0     [000] dn.2  9420.691401: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] dn.2  9420.691401: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419012000000 softexpires=9419012000000
          <idle>-0     [002] dn.2  9420.691408: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dn.2  9420.691408: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419012000000 softexpires=9419012000000
          <idle>-0     [000] d..1  9420.691409: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2  9420.691409: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d..2  9420.691409: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419260000000 softexpires=9419260000000
          <idle>-0     [002] d..1  9420.691423: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9420.691423: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9420.691424: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9859803202655 softexpires=9859803202655
          <idle>-0     [045] d.h2  9420.698872: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.698873: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419017253180
          <idle>-0     [045] d.h3  9420.698877: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419118254640 softexpires=9419117254640
          <idle>-0     [045] d.h1  9420.698877: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9420.799875: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.799875: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419118255760
          <idle>-0     [045] d.h3  9420.799879: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419219257140 softexpires=9419218257140
          <idle>-0     [045] d.h1  9420.799880: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [000] dn.2  9420.871369: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] dn.2  9420.871370: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419192000000 softexpires=9419192000000
          <idle>-0     [002] dn.2  9420.871375: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [000] d..1  9420.871376: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] dn.2  9420.871376: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419192000000 softexpires=9419192000000
          <idle>-0     [000] d..2  9420.871376: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d..2  9420.871376: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419260000000 softexpires=9419260000000
          <idle>-0     [002] d..1  9420.871398: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9420.871398: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9420.871398: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9859983202655 softexpires=9859983202655
          <idle>-0     [045] d.h2  9420.900881: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9420.900881: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419219261580
          <idle>-0     [045] d.h3  9420.900885: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419320263160 softexpires=9419319263160
          <idle>-0     [045] d.h1  9420.900886: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [001] d..2  9420.913601: hrtimer_cancel: hrtimer=ffff8017fbe5b808
          <idle>-0     [001] d..2  9420.913601: hrtimer_start: hrtimer=ffff8017fbe5b808 function=tick_sched_timer expires=9860023202655 softexpires=9860023202655
          <idle>-0     [000] d.h2  9420.941621: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.h1  9420.941621: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9419260001400
          <idle>-0     [000] d.h1  9420.941623: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9420.941623: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9420.941624: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_disable_link now=4297247112
          <idle>-0     [000] d.s2  9420.941624: timer_start: timer=ffff80177fdc0840 function=link_timeout_enable_link expires=4297247137 [timeout=25] cpu=0 idx=113 flags=
          <idle>-0     [000] ..s1  9420.941628: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d.s2  9420.941629: timer_cancel: timer=ffff8017fbe42558
          <idle>-0     [000] d.s1  9420.941629: timer_expire_entry: timer=ffff8017fbe42558 function=delayed_work_timer_fn now=4297247112
          <idle>-0     [000] dns1  9420.941630: timer_expire_exit: timer=ffff8017fbe42558
          <idle>-0     [000] dns2  9420.941631: timer_cancel: timer=ffff00000910a628
          <idle>-0     [000] dns1  9420.941631: timer_expire_entry: timer=ffff00000910a628 function=delayed_work_timer_fn now=4297247112
          <idle>-0     [000] dns1  9420.941631: timer_expire_exit: timer=ffff00000910a628
          <idle>-0     [000] dn.2  9420.941634: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419264000000 softexpires=9419264000000
          <idle>-0     [002] dn.2  9420.941643: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dn.2  9420.941643: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419264000000 softexpires=9419264000000
     kworker/0:0-3     [000] d..1  9420.941650: timer_start: timer=ffff00000910a628 function=delayed_work_timer_fn expires=4297247500 [timeout=388] cpu=0 idx=100 flags=D|I
     kworker/2:0-22    [002] d..1  9420.941651: timer_start: timer=ffff8017fbe78558 function=delayed_work_timer_fn expires=4297247494 [timeout=382] cpu=2 idx=114 flags=D|I
          <idle>-0     [000] d..1  9420.941652: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2  9420.941652: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d..2  9420.941653: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419364000000 softexpires=9419364000000
          <idle>-0     [002] d..1  9420.941654: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9420.941654: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9420.941654: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9860055202655 softexpires=9860055202655
          <idle>-0     [045] d.h2  9421.001887: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9421.001887: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419320267640
          <idle>-0     [045] d.h3  9421.001891: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419421269000 softexpires=9419420269000
          <idle>-0     [045] d.h1  9421.001892: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [000] d.h2  9421.045625: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.h1  9421.045625: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9419364005380
          <idle>-0     [000] d.h1  9421.045626: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9421.045627: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9421.045628: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_enable_link now=4297247138
          <idle>-0     [000] d.s2  9421.045628: timer_start: timer=ffff80177fdc0840 function=link_timeout_disable_link expires=4297247363 [timeout=225] cpu=0 idx=34 flags=
          <idle>-0     [000] ..s1  9421.045631: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d..2  9421.045644: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9420284000000 softexpires=9420284000000
          <idle>-0     [045] d.h2  9421.102893: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9421.102893: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419421273420
          <idle>-0     [045] d.h3  9421.102897: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419522275040 softexpires=9419521275040
          <idle>-0     [045] d.h1  9421.102897: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [055] d.h2  9421.165621: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d.h1  9421.165622: hrtimer_expire_entry: hrtimer=ffff8017db968808 function=tick_sched_timer now=9419484002280
          <idle>-0     [055] d.h1  9421.165624: hrtimer_expire_exit: hrtimer=ffff8017db968808
          <idle>-0     [055] d.s2  9421.165624: timer_cancel: timer=ffff80177db6cc08
          <idle>-0     [055] d.s1  9421.165625: timer_expire_entry: timer=ffff80177db6cc08 function=delayed_work_timer_fn now=4297247168
          <idle>-0     [055] dns1  9421.165626: timer_expire_exit: timer=ffff80177db6cc08
          <idle>-0     [055] dn.2  9421.165629: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9419488000000 softexpires=9419488000000
    kworker/55:1-1246  [055] d..1  9421.165632: timer_start: timer=ffff80177db6cc08 function=delayed_work_timer_fn expires=4297247418 [timeout=250] cpu=55 idx=120 flags=I
          <idle>-0     [055] d..1  9421.165634: tick_stop: success=1 dependency=NONE
          <idle>-0     [055] d..2  9421.165634: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d..2  9421.165635: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9420508000000 softexpires=9420508000000
          <idle>-0     [045] d.h2  9421.203896: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9421.203896: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419522276980
          <idle>-0     [045] d.h3  9421.203900: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419623278460 softexpires=9419622278460
          <idle>-0     [045] d.h1  9421.203901: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9421.304899: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9421.304899: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9419623279580
          <idle>-0     [045] d.h3  9421.304903: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9419724281060 softexpires=9419723281060
          <idle>-0     [045] d.h1  9421.304903: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [000] dn.2  9421.381179: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] dn.2  9421.381179: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9419700000000 softexpires=9419700000000
          <idle>-0     [002] dn.2  9421.381185: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dn.2  9421.381185: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419700000000 softexpires=9419700000000
          <idle>-0     [000] d..1  9421.381185: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2  9421.381186: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d..2  9421.381186: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9420284000000 softexpires=9420284000000
              sh-2256  [002] ....  9421.381193: timer_init: timer=ffff80176c26fb40
              sh-2256  [002] d..1  9421.381194: timer_start: timer=ffff80176c26fb40 function=process_timeout expires=4297247223 [timeout=2] cpu=2 idx=0 flags=
          <idle>-0     [002] d..1  9421.381196: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9421.381197: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9421.381197: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419708000000 softexpires=9419708000000
          <idle>-0     [002] d.h2  9421.389621: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d.h1  9421.389622: hrtimer_expire_entry: hrtimer=ffff8017fbe76808 function=tick_sched_timer now=9419708002000
          <idle>-0     [002] d.h1  9421.389623: hrtimer_expire_exit: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d.s2  9421.389624: timer_cancel: timer=ffff80176c26fb40
          <idle>-0     [002] ..s1  9421.389624: timer_expire_entry: timer=ffff80176c26fb40 function=process_timeout now=4297247224
          <idle>-0     [002] .ns1  9421.389626: timer_expire_exit: timer=ffff80176c26fb40
          <idle>-0     [002] dn.2  9421.389629: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419712000000 softexpires=9419712000000
              sh-2256  [002] ...1  9421.389682: hrtimer_init: hrtimer=ffff8017d4dde8a0 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
              sh-2256  [002] ...1  9421.389682: hrtimer_init: hrtimer=ffff8017d4dde8e0 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
              sh-2256  [002] ....  9421.389690: hrtimer_init: hrtimer=ffff80176cbb0088 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_REL
          <idle>-0     [039] dn.2  9421.389814: hrtimer_start: hrtimer=ffff8017dbb18808 function=tick_sched_timer expires=9419712000000 softexpires=9419712000000
          <idle>-0     [002] d..1  9421.389896: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9421.389897: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9421.389898: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9419724000000 softexpires=9419724000000
          <idle>-0     [002] dn.2  9444.510766: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dn.2  9444.510767: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9442832000000 softexpires=9442832000000
          <idle>-0     [036] d..1  9444.510812: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.510814: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.510815: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442844000000 softexpires=9442844000000
              sh-2256  [002] ....  9444.510857: timer_init: timer=ffff80176c26fb40
              sh-2256  [002] d..1  9444.510857: timer_start: timer=ffff80176c26fb40 function=process_timeout expires=4297253006 [timeout=2] cpu=2 idx=0 flags=
          <idle>-0     [002] d..1  9444.510864: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9444.510865: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9444.510866: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9442844000000 softexpires=9442844000000
          <idle>-0     [000] d.h2  9444.525625: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [002] d.h2  9444.525625: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [036] d.h2  9444.525625: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [002] d.h1  9444.525625: hrtimer_expire_entry: hrtimer=ffff8017fbe76808 function=tick_sched_timer now=9442844005600
          <idle>-0     [036] d.h1  9444.525625: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442844005460
          <idle>-0     [000] d.h1  9444.525627: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9442844005300
          <idle>-0     [002] d.h1  9444.525627: hrtimer_expire_exit: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d.s2  9444.525629: timer_cancel: timer=ffff8017fbe78558
          <idle>-0     [036] d.h1  9444.525629: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [002] d.s1  9444.525629: timer_expire_entry: timer=ffff8017fbe78558 function=delayed_work_timer_fn now=4297253008
          <idle>-0     [000] d.h1  9444.525629: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9444.525631: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9444.525631: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_disable_link now=4297253008
          <idle>-0     [002] dns1  9444.525631: timer_expire_exit: timer=ffff8017fbe78558
          <idle>-0     [000] d.s2  9444.525632: timer_start: timer=ffff80177fdc0840 function=link_timeout_enable_link expires=4297253033 [timeout=25] cpu=0 idx=82 flags=
          <idle>-0     [000] ..s1  9444.525633: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d.s2  9444.525634: timer_cancel: timer=ffff00000910a628
          <idle>-0     [000] d.s1  9444.525634: timer_expire_entry: timer=ffff00000910a628 function=delayed_work_timer_fn now=4297253008
          <idle>-0     [000] dns1  9444.525636: timer_expire_exit: timer=ffff00000910a628
          <idle>-0     [036] dn.2  9444.525639: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442848000000 softexpires=9442848000000
          <idle>-0     [000] dn.2  9444.525640: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9442848000000 softexpires=9442848000000
          <idle>-0     [002] dn.2  9444.525640: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9442848000000 softexpires=9442848000000
     rcu_preempt-9     [036] ....  9444.525648: timer_init: timer=ffff8017d5fcfda0
          <idle>-0     [002] d..1  9444.525648: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9444.525648: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9444.525649: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9442860000000 softexpires=9442860000000
     rcu_preempt-9     [036] d..1  9444.525649: timer_start: timer=ffff8017d5fcfda0 function=process_timeout expires=4297253009 [timeout=1] cpu=36 idx=0 flags=
     kworker/0:0-3     [000] d..1  9444.525650: timer_start: timer=ffff00000910a628 function=delayed_work_timer_fn expires=4297253250 [timeout=242] cpu=0 idx=82 flags=D|I
          <idle>-0     [000] d..1  9444.525652: tick_stop: success=1 dependency=NONE
          <idle>-0     [000] d..2  9444.525652: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d..2  9444.525653: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9442948000000 softexpires=9442948000000
          <idle>-0     [036] d..1  9444.525653: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.525654: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.525654: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442852000000 softexpires=9442852000000
          <idle>-0     [036] d.h2  9444.533624: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.h1  9444.533625: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442852004760
          <idle>-0     [036] d.h1  9444.533626: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.s2  9444.533627: timer_cancel: timer=ffff8017d5fcfda0
          <idle>-0     [036] ..s1  9444.533628: timer_expire_entry: timer=ffff8017d5fcfda0 function=process_timeout now=4297253010
          <idle>-0     [036] .ns1  9444.533629: timer_expire_exit: timer=ffff8017d5fcfda0
          <idle>-0     [036] dn.2  9444.533634: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442856000000 softexpires=9442856000000
          <idle>-0     [036] d..1  9444.533668: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.533668: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.533669: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442876000000 softexpires=9442876000000
          <idle>-0     [002] dnh2  9444.541626: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dnh1  9444.541627: hrtimer_expire_entry: hrtimer=ffff8017fbe76808 function=tick_sched_timer now=9442860007120
          <idle>-0     [002] dnh1  9444.541629: hrtimer_expire_exit: hrtimer=ffff8017fbe76808
          <idle>-0     [002] dn.2  9444.541630: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9442864000000 softexpires=9442864000000
          <idle>-0     [002] d..1  9444.541640: tick_stop: success=1 dependency=NONE
          <idle>-0     [002] d..2  9444.541640: hrtimer_cancel: hrtimer=ffff8017fbe76808
          <idle>-0     [002] d..2  9444.541640: hrtimer_start: hrtimer=ffff8017fbe76808 function=tick_sched_timer expires=9444316000000 softexpires=9444316000000
          <idle>-0     [036] dnh2  9444.557627: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] dnh1  9444.557628: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442876008220
          <idle>-0     [036] dnh1  9444.557630: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [036] dn.2  9444.557631: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442880000000 softexpires=9442880000000
          <idle>-0     [036] d..1  9444.557644: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.557645: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.557645: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442892000000 softexpires=9442892000000
          <idle>-0     [036] d.h2  9444.573621: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.h1  9444.573621: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442892001340
          <idle>-0     [036] d.h1  9444.573622: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [036] dn.2  9444.573628: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442896000000 softexpires=9442896000000
     rcu_preempt-9     [036] ....  9444.573631: timer_init: timer=ffff8017d5fcfda0
     rcu_preempt-9     [036] d..1  9444.573632: timer_start: timer=ffff8017d5fcfda0 function=process_timeout expires=4297253021 [timeout=1] cpu=36 idx=0 flags=
          <idle>-0     [036] d..1  9444.573634: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.573635: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.573635: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442900000000 softexpires=9442900000000
          <idle>-0     [036] d.h2  9444.581621: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.h1  9444.581621: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442900001400
          <idle>-0     [036] d.h1  9444.581622: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.s2  9444.581623: timer_cancel: timer=ffff8017d5fcfda0
          <idle>-0     [036] ..s1  9444.581623: timer_expire_entry: timer=ffff8017d5fcfda0 function=process_timeout now=4297253022
          <idle>-0     [036] .ns1  9444.581625: timer_expire_exit: timer=ffff8017d5fcfda0
          <idle>-0     [036] dn.2  9444.581628: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442904000000 softexpires=9442904000000
          <idle>-0     [036] d..1  9444.581636: tick_stop: success=1 dependency=NONE
          <idle>-0     [036] d..2  9444.581636: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.581637: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9442924000000 softexpires=9442924000000
          <idle>-0     [045] d.h2  9444.581718: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9444.581719: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9442900098200
          <idle>-0     [045] d.h3  9444.581724: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9443001101380 softexpires=9443000101380
          <idle>-0     [045] d.h1  9444.581725: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [036] d.h2  9444.605621: hrtimer_cancel: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d.h1  9444.605621: hrtimer_expire_entry: hrtimer=ffff8017dbac7808 function=tick_sched_timer now=9442924001600
          <idle>-0     [036] d.h1  9444.605622: hrtimer_expire_exit: hrtimer=ffff8017dbac7808
          <idle>-0     [036] d..2  9444.605629: hrtimer_start: hrtimer=ffff8017dbac7808 function=tick_sched_timer expires=9883719202655 softexpires=9883719202655
          <idle>-0     [000] d.h2  9444.629625: hrtimer_cancel: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.h1  9444.629625: hrtimer_expire_entry: hrtimer=ffff8017fbe40808 function=tick_sched_timer now=9442948005580
          <idle>-0     [000] d.h1  9444.629627: hrtimer_expire_exit: hrtimer=ffff8017fbe40808
          <idle>-0     [000] d.s2  9444.629628: timer_cancel: timer=ffff80177fdc0840
          <idle>-0     [000] ..s1  9444.629628: timer_expire_entry: timer=ffff80177fdc0840 function=link_timeout_enable_link now=4297253034
          <idle>-0     [000] d.s2  9444.629629: timer_start: timer=ffff80177fdc0840 function=link_timeout_disable_link expires=4297253259 [timeout=225] cpu=0 idx=42 flags=
          <idle>-0     [000] ..s1  9444.629638: timer_expire_exit: timer=ffff80177fdc0840
          <idle>-0     [000] d..2  9444.629661: hrtimer_start: hrtimer=ffff8017fbe40808 function=tick_sched_timer expires=9443868000000 softexpires=9443868000000
          <idle>-0     [045] d.h2  9444.682725: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9444.682725: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9443001105940
          <idle>-0     [045] d.h3  9444.682730: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9443102107440 softexpires=9443101107440
          <idle>-0     [045] d.h1  9444.682730: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [055] d.h2  9444.717626: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d.h1  9444.717627: hrtimer_expire_entry: hrtimer=ffff8017db968808 function=tick_sched_timer now=9443036006240
          <idle>-0     [055] d.h1  9444.717629: hrtimer_expire_exit: hrtimer=ffff8017db968808
          <idle>-0     [055] d.s2  9444.717630: timer_cancel: timer=ffff80177db6cc08
          <idle>-0     [055] d.s1  9444.717630: timer_expire_entry: timer=ffff80177db6cc08 function=delayed_work_timer_fn now=4297253056
          <idle>-0     [055] dns1  9444.717633: timer_expire_exit: timer=ffff80177db6cc08
          <idle>-0     [055] dn.2  9444.717637: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9443040000000 softexpires=9443040000000
    kworker/55:1-1246  [055] d..1  9444.717640: timer_start: timer=ffff80177db6cc08 function=delayed_work_timer_fn expires=4297253306 [timeout=250] cpu=55 idx=88 flags=I
          <idle>-0     [055] d..1  9444.717643: tick_stop: success=1 dependency=NONE
          <idle>-0     [055] d..2  9444.717643: hrtimer_cancel: hrtimer=ffff8017db968808
          <idle>-0     [055] d..2  9444.717644: hrtimer_start: hrtimer=ffff8017db968808 function=tick_sched_timer expires=9444060000000 softexpires=9444060000000
          <idle>-0     [045] d.h2  9444.783729: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9444.783729: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9443102109380
          <idle>-0     [045] d.h3  9444.783733: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9443203110880 softexpires=9443202110880
          <idle>-0     [045] d.h1  9444.783733: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9444.884731: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9444.884731: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9443203112000
          <idle>-0     [045] d.h3  9444.884735: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9443304113380 softexpires=9443303113380
          <idle>-0     [045] d.h1  9444.884736: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h2  9444.985734: hrtimer_cancel: hrtimer=ffff80176cb7ca90
          <idle>-0     [045] d.h1  9444.985735: hrtimer_expire_entry: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func now=9443304114500
          <idle>-0     [045] d.h3  9444.985738: hrtimer_start: hrtimer=ffff80176cb7ca90 function=ehci_hrtimer_func expires=9443405116440 softexpires=9443404116440
          <idle>-0     [045] d.h1  9444.985739: hrtimer_expire_exit: hrtimer=ffff80176cb7ca90
          <idle>-0     [042] d.h2  9445.037622: hrtimer_cancel: hrtimer=ffff8017dbb69808
> 
> Thanks,
> 
> Jonathan
> > 
> > 							Thanx, Paul
> >   
> > > [ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> > > [ 1984.638153] rcu_preempt     S    0     9      2 0x00000000
> > > [ 1984.643626] Call trace:
> > > [ 1984.646059] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> > > [ 1984.651189] [<ffff000008962274>] __schedule+0x19c/0x5d8
> > > [ 1984.656400] [<ffff0000089626e8>] schedule+0x38/0xa0
> > > [ 1984.661266] [<ffff000008965844>] schedule_timeout+0x124/0x218
> > > [ 1984.667002] [<ffff000008121424>] rcu_gp_kthread+0x4fc/0x748
> > > [ 1984.672564] [<ffff0000080df0b4>] kthread+0xfc/0x128
> > > [ 1984.677429] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
> > >     
> >   
> 
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm

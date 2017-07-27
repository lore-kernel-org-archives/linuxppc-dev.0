Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHzdm4k44zDrFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 14:34:20 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y25so9726406pfk.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 21:34:20 -0700 (PDT)
Date: Thu, 27 Jul 2017 14:34:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jonathan.Cameron@huawei.com,
 dzickus@redhat.com, sfr@canb.auug.org.au, linuxarm@huawei.com,
 abdhalee@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
In-Reply-To: <20170727014214.GH3730@linux.vnet.ibm.com>
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
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

On Wed, 26 Jul 2017 18:42:14 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Jul 26, 2017 at 04:22:00PM -0700, David Miller wrote:

> > Indeed, that really wouldn't explain how we end up with a RCU stall
> > dump listing almost all of the cpus as having missed a grace period.  
> 
> I have seen stranger things, but admittedly not often.

So the backtraces show the RCU gp thread in schedule_timeout.

Are you sure that it's timeout has expired and it's not being scheduled,
or could it be a bad (large) timeout (looks unlikely) or that it's being
scheduled but not correctly noting gps on other CPUs?

It's not in R state, so if it's not being scheduled at all, then it's
because the timer has not fired:

[ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[ 1984.638153] rcu_preempt     S    0     9      2 0x00000000
[ 1984.643626] Call trace:
[ 1984.646059] [<ffff000008084fb0>] __switch_to+0x90/0xa8
[ 1984.651189] [<ffff000008962274>] __schedule+0x19c/0x5d8
[ 1984.656400] [<ffff0000089626e8>] schedule+0x38/0xa0
[ 1984.661266] [<ffff000008965844>] schedule_timeout+0x124/0x218
[ 1984.667002] [<ffff000008121424>] rcu_gp_kthread+0x4fc/0x748
[ 1984.672564] [<ffff0000080df0b4>] kthread+0xfc/0x128
[ 1984.677429] [<ffff000008082ec0>] ret_from_fork+0x10/0x50

Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xL81n2CqHzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 02:59:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6UGwdp5160706
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 12:59:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c1eewg570-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 12:59:04 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 30 Jul 2017 12:59:04 -0400
Date: Sun, 30 Jul 2017 09:59:01 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
 <20170728190956.GA26640@linux.vnet.ibm.com>
 <20170730133747.anusyacw2l5hhjgx@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170730133747.anusyacw2l5hhjgx@tardis>
Message-Id: <20170730165901.GX3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 30, 2017 at 09:37:47PM +0800, Boqun Feng wrote:
> On Fri, Jul 28, 2017 at 12:09:56PM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
> > 
> > [ . . . ]
> > 
> > > > Even though Jonathan's testing indicates that it didn't fix this
> > > > particular problem:
> > > > 
> > > > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > And while we are at it:
> > > 
> > > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > Not because it it fixed the TREE01 issue -- it did not.  But as near
> > as I can see, it didn't cause any additional issues.
> > 
> 
> Understood.
> 
> Still work on waketorture for a test case which could trigger this
> problem in a real world. My old plan is to send this out when I could
> use waketorture to show this patch actually resolves some potential
> bugs, but just put it ahead here in case it may help.
> 
> Will send it out with your Tested-by and Acked-by and continue to work
> on waketorture.

Sounds good!

Given that Jonathan's traces didn't show a timer expiration, the problems
might be in timers.

							Thanx, Paul

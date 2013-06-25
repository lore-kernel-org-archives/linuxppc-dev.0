Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 778C82C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 13:14:54 +1000 (EST)
Message-ID: <1372130007.3944.185.camel@pasglop>
Subject: Re: [PATCH 40/45] powerpc, irq: Use GFP_ATOMIC allocations in
 atomic context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 13:13:27 +1000
In-Reply-To: <20130625025858.GE14051@concordia>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134657.19094.93687.stgit@srivatsabhat.in.ibm.com>
 <20130625020842.GD14051@concordia> <1372126384.3944.177.camel@pasglop>
 <20130625025858.GE14051@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 Ian Munsie <imunsie@au1.ibm.com>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 12:58 +1000, Michael Ellerman wrote:
> On Tue, Jun 25, 2013 at 12:13:04PM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2013-06-25 at 12:08 +1000, Michael Ellerman wrote:
> > > We're not checking for allocation failure, which we should be.
> > > 
> > > But this code is only used on powermac and 85xx, so it should probably
> > > just be a TODO to fix this up to handle the failure.
> > 
> > And what can we do if they fail ?
> 
> Fail up the chain and not unplug the CPU presumably.

BTW. Isn't Srivatsa series removing the need to stop_machine() for
unplug ? That should mean we should be able to use GFP_KERNEL no ?

Cheers,
Ben.

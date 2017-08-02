Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMv4J1pGnzDrFK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 23:22:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72DJOcF065966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 09:22:21 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c39p12n0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 09:22:21 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 23:22:18 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72DM7Qx20250770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:22:15 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72DLhSO027706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:21:43 +1000
Date: Wed, 2 Aug 2017 18:51:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/xmon: Disable and enable tracing command
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
 <1501521731-12123-2-git-send-email-leitao@debian.org>
 <20170801064024.colxo4i3z764m36k@naverao1-tp.localdomain>
 <20170801142145.ill2cpq5grybflwp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170801142145.ill2cpq5grybflwp@gmail.com>
Message-Id: <20170802132124.4ik7govvogeud7pp@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/08/01 11:21AM, Breno Leitao wrote:
> Hi Naveen,
> 
> On Tue, Aug 01, 2017 at 12:10:24PM +0530, Naveen N. Rao wrote:
> > On 2017/07/31 02:22PM, Breno Leitao wrote:
> > > If tracing is enabled and you get into xmon, the tracing buffer
> > > continues to be updated, causing possible loss of data due to buffer
> > > overflow and unnecessary tracing information coming from xmon functions.
> > > 
> > > This patch adds a new option that allows the tracing to be disabled and
> > > re-enabled from inside xmon.
> > 
> > How is this new option useful? In the next patch, you disable tracing by 
> > default -- in what scenario do you expect to have to re-enable tracing 
> > from within xmon?
> 
> I see it being useful on two different scenarios:
> 
> 1) You can reenable tracing if you want to call a function from xmon
> (with 'p'), or even for code stepping (with 's').

Hmm... those are just debugging aids, so I don't see why enabling the 
function tracer helps, unless you're debugging the tracer itself..

> 
> 2) You may also want to reenable tracing once you resume from xmon with
> 'zr'.

'zr' is for reboot, so not sure what you meant there...

If tracing was enabled before we went into xmon, I think that we should 
just restore it by default.

> 
> > > +		case 'v':
> > > +			if (tracing_is_on()) {
> > > +				printk("Disabling tracing\n");
> > > +				tracing_enabled = 0;
> > > +				tracing_off();
> > 
> > This only disables trace buffer updates - ftrace (and all its callbacks, 
> > et al) remains active, which isn't desirable.
> 
> Why isn't it desirable? In fact, I thought it would be *the* desirable
> function to call, since it does not do a lot of stuff, as disabling
> tracing, in xmon mode, but, just disable the tracing buffer to be updated.
> 
> Since we are in xmon, we are in a very bad state, and something went
> very wrong. Disabling the whole tracing might not be what we want to do
> in this scenario, since it can hit the broken subsystem causing xmon to
> fail.
> 
> For bad state scenario, I understand that it is desirable to be less
> instrusive as possible, and tracing_off() does exactly it.

My concern was that we will still go through all the callbacks and I was 
wondering if we could get rid of that. However, I don't see any easy way 
to do that with the current ftrace infrastructure.

> 
> > Can you see if this works for you:
> > https://patchwork.ozlabs.org/patch/769611/
> 
> Well, I understand that this patch solves a different issue, this does
> not reduce the tracing caused by function tracer after you got into into
> xmon.
> 
> As for example, with your patch applied, I can see a lot of xmon
> functions polluting the tracing buffer as:
> 
> 	1:mon> dt
> 	[  359.196593] Dumping ftrace buffer:
> 	[  359.196689] ---------------------------------
> 	[  359.196904]   1)               |          xmon_printf() {
> 	<110+ lines snipped>
> 	[  359.197727]   1) + 22.930 us   |          }
> 	[  359.199405]   1)               |          skipbl() {
> 	<50+ lines snipped>
> 	[  359.225069]   1) + 23.750 us   |          }
> 
> 
> Since tracing continues to be enabled during xmon, these messages
> continue to show up. That is exactly what I am trying to avoid with this
> current patchset. Avoiding all xmon-related tracing is my main goal.

Ok, makes sense.


Thanks,
Naveen
 

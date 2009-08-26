Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep15-int.chello.at (viefep15-int.chello.at [62.179.121.35])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 1F292B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 21:43:11 +1000 (EST)
Subject: Re: [v2 PATCH 2/2]: pseries: Implement Pseries Processor Idle idle
	module.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090826113217.GA14758@linux.vnet.ibm.com>
References: <20090826110721.GA29759@linux.vnet.ibm.com>
	<20090826111003.GC29759@linux.vnet.ibm.com>
	<1251286038.1329.1.camel@twins>
	<20090826113217.GA14758@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Aug 2009 13:37:05 +0200
Message-Id: <1251286625.1329.6.camel@twins>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-26 at 17:02 +0530, Arun R Bharadwaj wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-08-26 13:27:18]:
> 
> > On Wed, 2009-08-26 at 16:40 +0530, Arun R Bharadwaj wrote:
> > > +void (*pm_idle)(void);
> > > +EXPORT_SYMBOL_GPL(pm_idle);
> > 
> > Seriously.. this caused plenty problems over on x86 and you're doing the
> > exact same dumb thing?
> > 
> 
> Hi Peter,
> 
> Cpuidle assumes pm_idle to be the default idle power management
> function. So i should either do this, or change the stuff in cpuidle.c
> so that it is more abstract.

I would much prefer the latter, I've been telling the x86 power folks to
fix this like forever, but they never seem to get around to it.

They even tried adding a second such unmanaged function pointer for
play-dead, instead of integrating everything into a single management
interface.

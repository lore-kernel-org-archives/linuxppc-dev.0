Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8C63B7D14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 17:03:11 +1000 (EST)
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
From: Peter Zijlstra <peterz@infradead.org>
To: arun@linux.vnet.ibm.com
In-Reply-To: <1251442085.18584.120.camel@twins>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
	<20090828061434.GA11863@linux.vnet.ibm.com>
	<1251442085.18584.120.camel@twins>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 09:01:12 +0200
Message-Id: <1251442872.18584.125.camel@twins>
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

On Fri, 2009-08-28 at 08:48 +0200, Peter Zijlstra wrote:
> 
> > void cpuidle_install_idle_handler(void)
> > {
> >       .........
> >       .........
> >       cpuidle_pm_idle = cpuidle_idle_call;
> > }
> 
> All I'm seeing here is a frigging mess.
> 
> How on earths can something called: cpuidle_install_idle_handler() have
> a void argument, _WHAT_ handler is it going to install?

Argh, now I see, it installs itself as the platform idle handler.

so cpuidle_install_idle_handler() pokes at the unmanaged pm_idle pointer
to make cpuidle take control.

On module load it does:

 pm_idle_old = pm_idle;

then in the actual idle loop it does:

        if (!dev || !dev->enabled) {
                if (pm_idle_old)
                        pm_idle_old();

who is to say that the pointer stored at module init time is still
around at that time?

So cpuidle recognised the pm_idle stuff was a flaky, but instead of
fixing it, they build a whole new layer on top of it. Brilliant.

/me goes mark this whole thread read, I've got enough things to do.

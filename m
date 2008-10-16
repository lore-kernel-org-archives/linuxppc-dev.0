Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EB2A5DDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 06:49:47 +1100 (EST)
Date: Thu, 16 Oct 2008 12:49:23 -0700 (PDT)
Message-Id: <20081016.124923.222595655.davem@davemloft.net>
To: johannes@sipsolutions.net
Subject: Re: powerpc allmodconfig
From: David Miller <davem@davemloft.net>
In-Reply-To: <1224169039.735.57.camel@johannes.berg>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
	<1224169039.735.57.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: bzolnier@gmail.com, marek.vasut@gmail.com, tiwai@suse.de,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	dan.j.williams@intel.com, mchehab@infradead.org, arjan@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 16 Oct 2008 16:57:19 +0200

> On Wed, 2008-10-15 at 22:02 -0700, David Miller wrote:
> > 
> > 
> > > net/sched/sch_generic.c: In function 'dev_watchdog':
> > > net/sched/sch_generic.c:224: warning: unused variable 'drivername'
> > 
> > Sucky, if WARN_ONCE() evaluates to nothing the sprintf() string buffer
> > on the stack looks unused.
> 
> I've complained about this to Arjan before, we actually lose all
> messages passed to WARN() or WARN_ONCE() on platforms that use bug traps
> for warnings too.

Ok I see how that works, yes, it should be fixed.

If the platform defines a __WARN (which powerpc does) the
whole format string and printf args go unevaluated, it's
because of the following sequence in asm-generic/bug.h:

#ifndef __WARN
#ifndef __ASSEMBLY__
extern void warn_on_slowpath(const char *file, const int line);
extern void warn_slowpath(const char *file, const int line,
		const char *fmt, ...) __attribute__((format(printf, 3, 4)));
#define WANT_WARN_ON_SLOWPATH
#endif
#define __WARN() warn_on_slowpath(__FILE__, __LINE__)
#define __WARN_printf(arg...) warn_slowpath(__FILE__, __LINE__, arg)
#else
#define __WARN_printf(arg...) __WARN()
#endif

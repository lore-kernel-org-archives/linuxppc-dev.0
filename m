Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 6C39C685A1
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 09:03:45 +1000 (EST)
Date: Sat, 22 Oct 2005 16:03:43 -0700
From: Brad Boyer <flar@allandria.com>
To: Olaf Hering <olh@suse.de>
Message-ID: <20051022230343.GA10060@pants.nu>
References: <20051022194626.GA3496@suse.de> <20051022210122.GA9638@pants.nu>
	<20051022211906.GA5820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051022211906.GA5820@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] dmasound_pmac depends on pmac specific config options
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 22, 2005 at 11:19:06PM +0200, Olaf Hering wrote:
>  On Sat, Oct 22, Brad Boyer wrote:
> 
> > I disagree. I think a much better solution would be to change the
> > code to be conditionalized internally on PMU support, rather than
> > having #ifdef CONFIG_PM since the functions being called inside
> > that protection are actually out of the PMU code, not the generic
> > power management system. By doing this, you could for example
> > have a kernel compiled for a 1st gen PCI PowerMac without any
> > extra drivers. In this case, you have CUDA and AWACS, but there
> > is no PMU support and no need for sleep notifiers.
> 
> May patch would allow that, you need either CUDA or PMU support.

The problem is not that you need CUDA or PMU support. The real
problem is that if you have CONFIG_PM set and do not have
CONFIG_ADB_PMU set, the pmac sound drivers don't compile because
they have calls into the pmu code protected by #ifdef CONFIG_PM,
which isn't enough to ensure that those symbols actually exist.
That code gets into the kernel only if you have CONFIG_PM and
CONFIG_ADB_PMU both set. Your patch will still fail in the
following case:

CONFIG_PM set
CONFIG_CUDA set
CONFIG_ADB_PMU not set

If you enable either of the pmac sound drivers with this setup,
it will fail to compile with exactly the same error.

	Brad Boyer
	flar@allandria.com

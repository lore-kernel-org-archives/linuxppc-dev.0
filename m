Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 3B3AB6855F
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 07:01:25 +1000 (EST)
Date: Sat, 22 Oct 2005 14:01:22 -0700
From: Brad Boyer <flar@allandria.com>
To: Olaf Hering <olh@suse.de>
Message-ID: <20051022210122.GA9638@pants.nu>
References: <20051022194626.GA3496@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051022194626.GA3496@suse.de>
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

On Sat, Oct 22, 2005 at 09:46:26PM +0200, Olaf Hering wrote:
> 
> dmasound_pmac should depend on pmac specific .config options.
> Since PMAC is always defined, but PMAC wont boot without either
> CUDA or PMU, one of these options indicates that the kernel is
> for a PowerMac.
> CONFIG_PM can be selected unconditionally.

I disagree. I think a much better solution would be to change the
code to be conditionalized internally on PMU support, rather than
having #ifdef CONFIG_PM since the functions being called inside
that protection are actually out of the PMU code, not the generic
power management system. By doing this, you could for example
have a kernel compiled for a 1st gen PCI PowerMac without any
extra drivers. In this case, you have CUDA and AWACS, but there
is no PMU support and no need for sleep notifiers.

Similar comments on the other patch.

	Brad Boyer
	flar@allandria.com

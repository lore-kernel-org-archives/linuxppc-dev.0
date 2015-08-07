Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 89C6B1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 08:31:05 +1000 (AEST)
Date: Fri, 07 Aug 2015 15:31:02 -0700 (PDT)
Message-Id: <20150807.153102.533553009548852567.davem@davemloft.net>
To: igal.liberman@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 stephen@networkplumber.org
Subject: Re: [v4, 0/9] Freescale DPAA FMan
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438766725-8053-1-git-send-email-igal.liberman@freescale.com>
References: <1438766725-8053-1-git-send-email-igal.liberman@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: <igal.liberman@freescale.com>
Date: Wed, 5 Aug 2015 12:25:16 +0300

> The Freescale Data Path Acceleration Architecture (DPAA)
> is a set of hardware components on specific QorIQ multicore processors.
> This architecture provides the infrastructure to support simplified
> sharing of networking interfaces and accelerators by multiple CPU cores
> and the accelerators.

I think the directory and code structure of this new driver is
quite excessive.

Because you've split things up _so_ much, you have to have
all of these directories, and even worse and much more important
to me you have to export so many functions from one source file
to another.

I think this is way too much.

For example, in one file you have a bunch of initialization routines.
init_a(), init_b(), init_c(), and you export them all.  Then they
are always called in sequence:

	init_a();
	init_b();
	init_c();

This is completely pointless.  You just needed to export one
function which calls all three functions.

The namespace pollution of this driver is out of control.

You really need to completely rework the architecture and
layout of this driver before I will even begin to review it
again.

And the lack of review interest by other developers should be an
indication to you how undesirable this code submission is to read.

Thanks.

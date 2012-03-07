Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62BEAB6F98
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2012 08:42:06 +1100 (EST)
Message-ID: <4F57D621.7090505@freescale.com>
Date: Wed, 7 Mar 2012 15:41:53 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <dbaryshkov@gmail.com>, <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
In-Reply-To: <1322669957-8259-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Commit 46d026ac ("powerpc/85xx: consolidate of_platform_bus_probe calls")
> replaced platform-specific of_device_id tables with a single function
> that probes the most of the busses in 85xx device trees.  If a specific
> platform needed additional busses probed, then it could call
> of_platform_bus_probe() again.  Typically, the additional platform-specific
> busses are children of existing busses that have already been probed.
> of_platform_bus_probe() does not handle those child busses automatically.
> 
> Unfortunately, this doesn't actually work.  The second (platform-specific)
> call to of_platform_bus_probe() never finds any of the busses it's asked
> to find.
> 
> To remedy this, the platform-specific of_device_id tables are eliminated,
> and their entries are merged into mpc85xx_common_ids[], so that all busses
> are probed at once.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Kumar, without this patch, audio is broken on the P1022DS in your 'merge'
branch.  I posted it back in November, six days after you applied the
patch that broke the P1022DS.

Is there any chance of getting this into 3.3?  This is a real bug fix, and
I would hate for audio to be broken in 3.3.

-- 
Timur Tabi
Linux kernel developer at Freescale

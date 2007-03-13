Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3801DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 18:12:21 +1100 (EST)
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200703122254.27087.sr@denx.de>
References: <200703122254.27087.sr@denx.de>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 08:12:14 +0100
Message-Id: <1173769934.24454.67.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-12 at 22:54 +0100, Stefan Roese wrote:
> This patch adds support for the PAGE_SIZE set equal to 64 KB on
> PPC32 platforms. Increasing the PAGE_SIZE may improve the performance
> of the system in some cases.
> 
> The RAID processing with the dedicated hardware that offloads the CPU
> is one of such cases. Using the bigger PAGE_SIZE we decrease the number
> of CPU operations required to process the data blocks, decrease the
> control overheads and so improve the overall performance. For example,
> changing the PAGE_SIZE from 4KB to 64KB on a Yucca (440SPe) gives ~300%
> performance benefit of the full-stripe writing in the (7d+1p) RAID-5
> setup.
> 
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Acked-by: Wolfgang Denk <wd@denx.de>
> Acked-by: Stefan Roese <sr@denx.de>

While it's a good idea, there are a couple of issues with the patch:

 - It's arch/ppc. We shouldn't do new major features on this codebase.
You are welcome however in helping moving over 4xx to arch/powerpc :-)

 - You only adapted head_4xx.S but the config option is global to all of
arch/ppc, thus changing it will probably break everything else. Make
sure the option is done in such a way that it can't be changed or the
kernel doesn't build if changed for a processor family where you haven't
implemented the support

 - Have you tried other page sizes ? How hard would it be to support 16K
and what kind of performance numbers do you get with 16K ? It's a better
compromise for some applications as 64K causes significant bloat of the
page cache (among other things).

Cheers,
Ben.

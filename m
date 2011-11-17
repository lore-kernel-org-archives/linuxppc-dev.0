Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 15AF9B724F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 07:44:52 +1100 (EST)
Date: Thu, 17 Nov 2011 14:44:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 08/29] powerpc/85xx: Rework MPC8536DS device trees
Message-ID: <20111117204444.GA14736@schlenkerla.am.freescale.net>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 01:16:00AM -0600, Kumar Gala wrote:
> Utilize new split between board & SoC, and new SoC device trees split
> into pre & post utilizing 'template' includes for SoC IP blocks.
> 
> Other changes include:
> * Moved to specifying interrupt-parent for mpic at root
> * Moved to 4-cell mpic interrupt cells to support MPIC timers
> * Added localbus node, but no chipselect details at this point
> * Reworked PCIe nodes to allow supportin IRQs for controller (errors)
> * and moved
>   PCI device IRQs down to virtual bridge level
> * Moved mdio nodes up one level instead of under tsec nodes
> * Added GPIO controller node to MPC8536 SoC template
>   [ marked as MPC8572 compatiable to get errata handling that applies ]
> * Added missing cache-line-size & cache-size properties missing from
>   L2-cache node
> * Added IP level IEEE 1588 / ptp timer node
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |  248 ++++++++++++++
>  arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi  |   63 ++++

OK, so rather than ask again what the real reason for this is, I went
ahead and tried it without the pre/post split.

It seems the issue with putting everything in "pre" is that we can't
rewrite a node name.  We can let the board supply its own reg/ranges, but
not the unit address of a previously-defined node.

Putting everything in post works, provided the setting of board-level
compatible is removed from the "si" file.  And since the board file is
driving this process, if it really wanted to override something from the
"si" file, it could do so after the include (just as it would currently
need to do to override anything in "post").

-Scott

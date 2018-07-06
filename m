Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MkCP50VFzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 04:44:00 +1000 (AEST)
Message-ID: <bdc2e385580cc08bcbf9d5b3595cbca5162314f8.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Tim Small <tim@seoss.co.uk>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 06 Jul 2018 13:41:41 -0500
In-Reply-To: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
References: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: NXP p1010se device trees only correct for P1010E/P1014E, not
 P1010/P1014 SoCs.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-06 at 15:50 +0100, Tim Small wrote:
> Hello,
> 
> I contributed a patch to OpenWRT a couple of days ago to fix the device 
> tree for a device which uses an NXP p1014 without the SEC4 module.  I 
> was wondering about getting a similar fix applied upstream...
> 
> The device uses the P1014 (without SEC4 functionality), and includes:
> 
> fsl/p1010si-pre.dtsi and fsl/p1010si-post.dtsi
> 
> ... in its device tree.  The latter pulls in leads to a node for 
> soc@ffe00000/crypto@30000 - which then causes the CAAM modules to be 
> used for crypto operations, when then fail at runtime.
> 
> AN4938 states that there are versions of both the p1010 and p1014 
> without the SEC4 module.
> 
> The P1010 errata at:
> 
> https://media.digikey.com/pdf/PCNs/Freescale/P1010CE_RevL.pdf
> 
> (table 2 on page 2), says that the P1010 and P1014 don't have the SEC4 
> module, only the P1010E and P1014E models do.
> 
> So, I think there should probably be device trees for p101xE (with SEC) 
> and p101x (without SEC).
> 
> Any thoughts?  Not really sure how best to do that...  My openwrt patch 
> just does a:
> 
> /delete-node/ crypto@30000;
> 
> after the p1010si-post.dtsi include.

U-Boot should already be removing the node on non-E chips -- see
ft_cpu_setup() in arch/powerpc/cpu/mpc85xx/fdt.c

-Scott

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EFE2DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 22:11:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8PCBg3q014868
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 08:11:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8PCBfVZ213654
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:11:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8PCBfBY013882
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:11:41 -0600
Date: Thu, 25 Sep 2008 08:11:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Fix PCI in Holly device tree
Message-ID: <20080925081129.7f882085@zod.rchland.ibm.com>
In-Reply-To: <20080925023904.GC15169@yookeroo.seuss>
References: <20080925023904.GC15169@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Sep 2008 12:39:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The PCI bridge on the Holly board is current incorrectly represented
> in the device tree.  The current device tree node for the PCI bridge
> sits under the tsi-bridge node.  That's not obviously wrong, but the
> PCI bridge translated some PCI spaces into CPU address ranges which
> were not translated by the tsi-bridge node.
> 
> We used to get away with this problem because the PCI bridge discovery
> code was also buggy, assuming incorrectly that PCI host bridge nodes
> were always directly under the root bus and treating the translated
> addresses as raw CPU addresses, rather than parent bus addresses.
> This has since been fixed, breaking Holly.
> 
> This could be fixed by adding extra translations to the tsi-bridge
> node, but this patch instead moves the Holly PCI bridge out of the
> tsi-bridge node to the root bus.  This makes the tsi-bridge node
> represent only the built-in IO devices in the bridge, with a
> more-or-less contiguous address range.  This is the same convention
> used on Freescale SoC chips, where the "soc" node represents only the
> IMMR region, and the PCI and other bus bridges are separate nodes
> under the root bus.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Paul, I can include this in my 'next' branch if you aren't opposed.
I'll have another set of patches going in there today/tomorrow.

josh

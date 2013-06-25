Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB7652C016F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 17:59:53 +1000 (EST)
Message-ID: <1372147064.3944.200.camel@pasglop>
Subject: Re: [PATCH 03/10] powerpc/eeh: Check PCIe link after reset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 17:57:44 +1000
In-Reply-To: <20130625074755.GA8486@shangw.(null)>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1372140384.3944.189.camel@pasglop> <20130625074755.GA8486@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 15:47 +0800, Gavin Shan wrote:
> If we just have complete reset for fenced PHB, we need restore it
> from the cache (edev->config_space[1]) instead of reading that from
> hardware. Fenced PHB is the special case on PowerNV :-)

Well not really...

In general we can also end up doing a hard reset under pHyp, and bridges
can lose their state as well, which means they need to be restored from
cache.

We don't see the real PHB, but we might see the bridges if we have a PE
that contains a bridge, for example, a PCIe card with a switch on it.

If we hard reset that (because the driver requested it) or if pHyp did a
reset due to a fence behind the scene, that bridge *will* have lost its
state and will need to be reconfigured too... or is RTAS doing it all ?

Cheers,
Ben.

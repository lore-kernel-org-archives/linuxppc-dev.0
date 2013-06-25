Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D32712C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 21:55:24 +1000 (EST)
Message-ID: <1372161315.3944.201.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 21:55:15 +1000
In-Reply-To: <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
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

On Tue, 2013-06-25 at 18:00 +0800, Gavin Shan wrote:
> +       /*
> +        * When the PHB is fenced or dead, it's pointless to collect
> +        * the data from PCI config space because it should return
> +        * 0xFF's. For ER, we still retrieve the data from the PCI
> +        * config space.
> +        */
> +       if (eeh_probe_mode_dev() &&
> +           (pe->type & EEH_PE_PHB) &&
> +           (pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)))
> +               valid_cfg_log = false;
> +

I'm still unsure about that one. EEH_PE_ISOLATED could be the result
of a normal ER of PE#0 (which can happen for various reasons other
than a fence) in which case the config space is available and
interesting.

I would either not bother and collect the FF's, or make this specific
to fence and only fence.

Cheers,
Ben.

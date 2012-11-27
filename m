Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EA4E2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 11:22:00 +1100 (EST)
Message-ID: <1353975701.2179.18.camel@pasglop>
Subject: Re: [PATCH] vfio powerpc: enabled and supported on powernv platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 27 Nov 2012 11:21:41 +1100
In-Reply-To: <1353953070.1809.103.camel@bling.home>
References: <20121113033832.GW4696@truffula.fritz.box>
 <1353372530-25205-1-git-send-email-aik@ozlabs.ru>
 <1353435584.2234.87.camel@bling.home>
 <C5ECD7A89D1DC44195F34B25E172658D294605@039-SN2MPN1-013.039d.mgd.msft.net>
 <50AED94E.4000006@ozlabs.ru> <1353943130.1809.29.camel@bling.home>
 <1353953070.1809.103.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-26 at 11:04 -0700, Alex Williamson wrote:
> Ok, I see tces are put on shutdown via tce_iommu_detach_group, so you're
> more concerned about the guest simply mapping over top of it's own
> mappings.  Is that common?  Is it common enough for every multi-page
> mapping to assume it will happen?  I know this is a performance
> sensitive path for you and it seems like a map-only w/ fallback to
> unmap, remap would be better in the general case.
> 
> On x86 we do exactly that, but we do the unmap, remap from userspace
> when we get an EBUSY.  Thanks, 

Right, Linux as guest at least will never map "over" an existing
mapping. It will always unmap first. IE. The only transition we do on
H_PUT_TCE are 0 -> valid and valid -> 0.

So it would be fine to simplify the code and keep the "map over map" as
a slow fallback. I can't tell for other operating systems but we don't
care about those at this point :-)

Cheers,
Ben.

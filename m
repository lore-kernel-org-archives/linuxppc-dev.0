Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 101551A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 08:10:37 +1000 (AEST)
Message-ID: <1431468627.20218.64.camel@kernel.crashing.org>
Subject: Re: mpt2sas DMA mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 13 May 2015 08:10:27 +1000
In-Reply-To: <555279A8.6060906@linux.vnet.ibm.com>
References: <555279A8.6060906@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Sreekanth Reddy <sreekanth.reddy@avagotech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 17:07 -0500, Brian King wrote:
> The mpt2sas driver was changed late last year in that it now requests a 64 bit DMA
> mask, then requests a 32 bit coherent DMA mask, then later requests a 64 bit coherent
> DMA mask. This was 5fb1bf8aaa832e1e9ca3198de7bbecb8eff7db9c. This breaks 64 bit DMA
> support for mpt2sas on Power and we always fall back to using 32 bit DMA. Looking
> at the commit log, it looks like this was an intentional change.
> 
> Ben - you had a patch set you had posted to the list back in Feb of this year, but it
> doesn't look like it got merged. 

Right, it was broken, we can't do that unfortunately. It's a hard
problem to fix.

> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125087.html
> 
> This would fix the issue I'm seeing on mpt2sas. Do you plan to dust that patch set
> off and upstream it? Were there issues with it that still need to be resolved?

No that patch doesn't actually work.

What we need is essentially a new set of DMA ops that can route an
individual map request via the iommu or the bypass window depending on
what mask applies.

Ben.

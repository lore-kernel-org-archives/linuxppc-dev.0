Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT5TK3YmgzDqcg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:27:11 +1000 (AEST)
Message-ID: <1465853216.3022.26.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to
 dynamic debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 07:26:56 +1000
In-Reply-To: <575EB4DE.9080807@linux.vnet.ibm.com>
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-13 at 10:27 -0300, Mauricio Faria de Oliveira wrote:
> Hi Ben,
> 
> On 06/11/2016 08:02 PM, Benjamin Herrenschmidt wrote:
> > I'm not fan of this. This is a very useful message to diagnose why,
> > for example, your network adapter is not working properly.
> > 
> > A lot of drivers don't deal well with IOMMU errors.
> > 
> > The fact that NVME trigger these is a problem that needs to be
> > solved
> > differently.
> 
> Ok, I understand your points.
> 
> Thanks for the review -- helps in setting another direction.

I've been thinking about this a bit... it might be worthwhile adding
a dma_* call to query the approximate size of the IOMMU window, as
a way for the device to adjust its requirements dynamically.

Another option would be to use a dma_attr for silencing mapping errors
which NVME could use provided it does handle them gracefully ...

Cheers,
Ben.

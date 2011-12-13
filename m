Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E6591007D4
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 15:27:16 +1100 (EST)
Message-ID: <1323750427.19891.59.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Date: Tue, 13 Dec 2011 15:27:07 +1100
In-Reply-To: <4BCA9D4A-4284-4DE8-95B9-D5DBA9254CC1@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
 <1323314600.12793.19.camel@pasglop>
 <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
 <4BCA9D4A-4284-4DE8-95B9-D5DBA9254CC1@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-12 at 21:55 -0600, Becky Bruce wrote:
> 1) dma_direct_alloc_coherent strips GFP_HIGHMEM out of the flags field
> when calling the actual allocator and the iotlb version does not.  I
> don't know how much this matters - I did a quick grep and I don't see
> any users that specify that, but somebody went through the trouble of
> putting it in there in the first place and without knowing why I
> wasn't willing to get rid of it.  Now, since my patch it looks like
> someone added a VM_BUG_ON into __get_free_pages() if GFP_HIGHMEM so
> this would get caught.  However, I don't know if we really want to
> throw a bug there.
> 
> 2)  The iotlb code doesn't deal with the !coherent parts like 8xx.  We
> can work around that by setting up the dma_ops differently for that
> case instead.

Does the rest of it handle them ? I mean swiotlb_map_sg_attrs etc...

If not then it's broken anyway so may as well not care for now.

Cheers,
Ben.

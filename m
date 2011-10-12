Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2316AB7C19
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:30:08 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/fsl-booke: Fix setup_initial_memory_limit to
 not blindly map
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1316187599-27549-2-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:30:02 -0500
Message-Id: <B5219D67-F5D1-45E2-A6CD-170EB76B7AB5@kernel.crashing.org>
References: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
 <1316187599-27549-2-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2011, at 10:39 AM, Kumar Gala wrote:

> On FSL Book-E devices we support multiple large TLB sizes and so we can
> get into situations in which the initial 1G TLB size is too big and
> we're asked for a size that is not mappable by a single entry (like
> 512M).  The single entry is important because when we bring up secondary
> cores they need to ensure any data structure they need to access (eg
> PACA or stack) is always mapped.
> 
> So we really need to determine what size will actually be mapped by the
> first TLB entry to ensure we limit early memory references to that
> region.  We refactor the map_mem_in_cams() code to provider a helper
> function that we can utilize to determine the size of the first TLB
> entry while taking into account size and alignment constraints.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/mm/fsl_booke_mmu.c |   31 +++++++++++++++++++------------
> arch/powerpc/mm/mmu_decl.h      |    2 ++
> arch/powerpc/mm/tlb_nohash.c    |   21 ++++++++++++++++++---
> 3 files changed, 39 insertions(+), 15 deletions(-)

applied

- k

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yw6NW0zF18d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:36 +1100 (AEDT)
In-Reply-To: <20180207063551.8991-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm/pgtable: Split mappings on hot-unplug
Message-Id: <3zd1Yw1YWgz9t3F@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-07 at 06:35:51 UTC, Balbir Singh wrote:
> This patch splits the a linear mapping if the hot-unplug range
> is smaller than the mapping size. The code detects if the mapping
> needs to be split into a smaller size and if so, uses the stop
> machine infrastructure to map the current linear mapping with
> a smaller size mapping. Then the requested area is unmapped.
> 
> The code will skip any region of the mapping that overlaps with
> kernel text and warn about it once. We don't want to remove
> a mapping where the kernel text and the LMB we intend to remove
> overlap in the same TLB mapping as it may affect the currently
> executing code (being cautious, we might be able to remove this
> restriction later, see TODOs below)
> 
> I've tested these changes under a kvm guest with 2 vcpus, from
> a split mapping point of view, some of the caveats mentioned
> above applied to the testing I did.
> 
> TODOs:
> 1. Refine the stop machine with an atomic replacement of the
> PMD. The code needs to be refactored to support those changes.
> I intend to publish those changes, but this is a minimal set
> that should be also probably backported to stable
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4dd5f8a99e791a8c6500e3592f3ce8

cheers

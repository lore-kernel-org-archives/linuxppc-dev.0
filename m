Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8023B70CC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 09:41:37 +1100 (EST)
Subject: Re: [PATCH RFC] PPC: /dev/mem: All RAM is cacheable,
	not just the kernel's.
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101018223256.GA30946@udp111988uds.am.freescale.net>
Date: Mon, 18 Oct 2010 17:41:12 -0500
Message-Id: <5A0A36FB-FFC5-4E9B-AD8F-2636DB79CE01@kernel.crashing.org>
References: <20101018223256.GA30946@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 18, 2010, at 5:32 PM, Scott Wood wrote:

> If mem=3D is used on the kernel command line to create reserved =
regions
> for userspace to map using /dev/mem, let it be mapped cacheable as =
long
> as it is within the memory region described in the device tree.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Just a nit, but subject should be powerpc:.. not PPC:

> This isn't just a performance issue, but it could also be a =
correctness
> issue, if the reserved portion of RAM is mapped cacheable by e.g. a =
KVM
> guest.  This patch does not address cases where such regions could =
show up
> as something other than a standard memory node -- such as shared =
regions
> in an AMP configuration.  Ideally there would be some means for a =
platform
> to register cacheable regions, without having to completely replace =
the
> entire phys_mem_access_prot function.
>=20
> This patch assumes that there is no region between memstart and memend =
that
> must be non-cacheable.  This is already the case with the "for now"
> implementation of page_is_ram on 32-bit, but will this be a problem on
> 64-bit?
>=20
> arch/powerpc/kernel/pci-common.c |    5 ++++-
> arch/powerpc/kernel/prom.c       |    3 +++
> arch/powerpc/mm/mem.c            |    3 ++-
> arch/powerpc/mm/mmu_decl.h       |    1 +
> 4 files changed, 10 insertions(+), 2 deletions(-)

For some time I've been meaning for us to look at the address range =
tracking that x86 does so one can make sure we aren't mapping regions =
with different WIMG settings.  However, never enough time for this.  So =
I think this is reasonable for now.  Hopefully Ben will comment on =
64-bit side of the world.

- k=

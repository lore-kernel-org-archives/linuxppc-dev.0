Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXb1zQ1zDrVC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:27 +1100 (AEDT)
In-Reply-To: <20171114092910.20399-2-kamalesh@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Jessica Yu <jeyu@kernel.org>,
 linux-kernel@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 live-patching@vger.kernel.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v4,
 1/3] kernel/modules: Add REL24 relocation support of livepatch symbols
Message-Id: <3ywyXZ6nm7z9t2f@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-14 at 09:29:08 UTC, Kamalesh Babulal wrote:
> Livepatch re-uses module loader function apply_relocate_add() to write
> relocations, instead of managing them by arch-dependent
> klp_write_module_reloc() function.
> 
> apply_relocate_add() doesn't understand livepatch symbols (marked with
> SHN_LIVEPATCH symbol section index) and assumes them to be local symbols
> by default for R_PPC64_REL24 relocation type. It fails with an error,
> when trying to calculate offset with local_entry_offset():
> 
>  module_64: kpatch_meminfo: REL24 -1152921504897399800 out of range!
> 
> Whereas livepatch symbols are essentially SHN_UNDEF, should be
> called via stub used for global calls. This issue can be fixed by
> teaching apply_relocate_add() to handle both SHN_UNDEF/SHN_LIVEPATCH
> symbols via the same stub. This patch extends SHN_UNDEF code to handle
> livepatch symbols too.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> CC: Balbir Singh <bsingharora@gmail.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Cc: Torsten Duwe <duwe@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a443bf6e8a7674b86221f4922cae82

cheers

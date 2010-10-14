Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39726B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 11:56:21 +1100 (EST)
Subject: Re: Please pull 'next' branch of 4xx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20101013131608.GA6154@zod.rchland.ibm.com>
References: <20100928130941.GA31993@zod.rchland.ibm.com>
	<20101013131608.GA6154@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 11:56:15 +1100
Message-ID: <1287017775.2205.49.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-10-13 at 09:16 -0400, Josh Boyer wrote:
> On Tue, Sep 28, 2010 at 09:09:41AM -0400, Josh Boyer wrote:
> >Hi Ben,
> >
> >A few small updates for the next branch.  A new board/SoC from AMCC, and
> >some 476 changes from Shaggy.  Please pull.
> 
> OK, below is a fixed up tree that drops the patch Shaggy said was
> broken, and rebases on top of your new -next branch.  Please pull.

please, rebase again without Shaggy's lazy flush patch. I'll handle that
one separately, I think it needs a little bit more massaging.

Cheers,
Ben.
 
> josh
> 
> The following changes since commit 4108d9ba9091c55cfb968d42dd7dcae9a098b876:
> 
>   powerpc/Makefiles: Change to new flag variables (2010-10-13 16:19:22 +1100)
> 
> are available in the git repository at:
>   ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next
> 
> Dave Kleikamp (1):
>       powerpc/476: lazy flush_tlb_mm for nohash architectures
> 
> Josh Boyer (1):
>       powerpc/44x: Update ppc44x_defconfig
> 
> Tirumala Marri (1):
>       powerpc/44x: Add support for the AMCC APM821xx SoC
> 
>  arch/powerpc/boot/dts/bluestone.dts          |  254 ++++++++++++++++++++++++++
>  arch/powerpc/configs/44x/bluestone_defconfig |   68 +++++++
>  arch/powerpc/configs/ppc44x_defconfig        |    9 +-
>  arch/powerpc/kernel/cpu_setup_44x.S          |    1 +
>  arch/powerpc/kernel/cputable.c               |   15 ++
>  arch/powerpc/mm/mmu_context_nohash.c         |  154 ++++++++++++++--
>  arch/powerpc/mm/mmu_decl.h                   |    8 +
>  arch/powerpc/mm/tlb_nohash.c                 |   28 +++-
>  arch/powerpc/platforms/44x/Kconfig           |   16 ++
>  arch/powerpc/platforms/44x/ppc44x_simple.c   |    1 +
>  10 files changed, 534 insertions(+), 20 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/bluestone.dts
>  create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig

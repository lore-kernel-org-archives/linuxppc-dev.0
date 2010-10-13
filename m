Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A6ADB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 00:16:18 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9DD5M6k018506
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 07:05:22 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o9DDGABq030294
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 07:16:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9DDG9Gp004919
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 07:16:10 -0600
Date: Wed, 13 Oct 2010 09:16:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'next' branch of 4xx tree
Message-ID: <20101013131608.GA6154@zod.rchland.ibm.com>
References: <20100928130941.GA31993@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100928130941.GA31993@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2010 at 09:09:41AM -0400, Josh Boyer wrote:
>Hi Ben,
>
>A few small updates for the next branch.  A new board/SoC from AMCC, and
>some 476 changes from Shaggy.  Please pull.

OK, below is a fixed up tree that drops the patch Shaggy said was
broken, and rebases on top of your new -next branch.  Please pull.

josh

The following changes since commit 4108d9ba9091c55cfb968d42dd7dcae9a098b876:

  powerpc/Makefiles: Change to new flag variables (2010-10-13 16:19:22 +1100)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Kleikamp (1):
      powerpc/476: lazy flush_tlb_mm for nohash architectures

Josh Boyer (1):
      powerpc/44x: Update ppc44x_defconfig

Tirumala Marri (1):
      powerpc/44x: Add support for the AMCC APM821xx SoC

 arch/powerpc/boot/dts/bluestone.dts          |  254 ++++++++++++++++++++++++++
 arch/powerpc/configs/44x/bluestone_defconfig |   68 +++++++
 arch/powerpc/configs/ppc44x_defconfig        |    9 +-
 arch/powerpc/kernel/cpu_setup_44x.S          |    1 +
 arch/powerpc/kernel/cputable.c               |   15 ++
 arch/powerpc/mm/mmu_context_nohash.c         |  154 ++++++++++++++--
 arch/powerpc/mm/mmu_decl.h                   |    8 +
 arch/powerpc/mm/tlb_nohash.c                 |   28 +++-
 arch/powerpc/platforms/44x/Kconfig           |   16 ++
 arch/powerpc/platforms/44x/ppc44x_simple.c   |    1 +
 10 files changed, 534 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/bluestone.dts
 create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig

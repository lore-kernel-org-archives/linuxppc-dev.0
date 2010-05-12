Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28B8CB7DF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 22:22:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4CCGYJc008348
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 06:16:34 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4CCMsjS080494
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 06:22:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4CCMsfE010209
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 06:22:54 -0600
Date: Wed, 12 May 2010 08:22:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'next' branch of 4xx (again)
Message-ID: <20100512122253.GF10526@zod.rchland.ibm.com>
References: <20100507195453.GN29593@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100507195453.GN29593@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 07, 2010 at 03:54:53PM -0400, Josh Boyer wrote:
>Hi Ben,
>
>Two more quick patches from me for -next.  Stefrano's is the Katmai usage of
>the reset type change that just went in.  The 460SX PCI-e patch has been sitting
>for a while and seems to have been skipped over.

I've updated my next branch with two more patches.  Yours for the 440SPe UART
clock fix, and the new platform addition of Icon 440SPe from Stefan.  Updated
diffstat below.

Thanks,
josh

The following changes since commit 1ed31d6db90d51010545921e59d369d2f92b7ac2:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin/master' into next

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Benjamin Herrenschmidt (1):
      powerpc/44x: Fix UART clocks on 440SPe

Stefan Roese (2):
      powerpc/44x: Add reset-type to katmai.dts
      powerpc/44x: Add basic ICON PPC440SPe board support

Tirumala Marri (1):
      powerpc/44x: Adding PCI-E support for PowerPC 460SX based SOC.

 arch/powerpc/boot/4xx.c                    |   12 +-
 arch/powerpc/boot/dts/icon.dts             |  447 ++++++++++
 arch/powerpc/boot/dts/katmai.dts           |    1 +
 arch/powerpc/boot/dts/redwood.dts          |  122 +++
 arch/powerpc/configs/44x/icon_defconfig    | 1316 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig         |   11 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |    3 +-
 arch/powerpc/sysdev/ppc4xx_pci.c           |  119 +++
 arch/powerpc/sysdev/ppc4xx_pci.h           |   58 ++
 9 files changed, 2082 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/icon.dts
 create mode 100644 arch/powerpc/configs/44x/icon_defconfig

Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 4F3ACB70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 13:23:33 +1000 (EST)
Date: Tue, 27 Jul 2010 11:55:06 +0900
From: Simon Horman <horms@verge.net.au>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf
	on ppc32
Message-ID: <20100727025506.GA1944@verge.net.au>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279687384-9770-1-git-send-email-msm@freescale.com>
Cc: muvarov@gmail.com, linuxppc-dev@lists.ozlabs.org, sebastian@breakpoint.cc,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Cced linuxppc-dev]

On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:
> This patch series adds full support for booting with a flat device tree
> with either uImage or elf file formats. Kexec and Kdump should work, and
> you should also be able to use ramdisks or reuse your current ramdisk as well
> 
> This patch series was tested on an mpc85xx system with a kernel version
> 2.6.35-rc3
> 
> v1: Initial version
> 
> v2: Added support for fs2dt (file system to device tree)
> 
> v3: Fix some misc. git problems I had and other code cleanups

Hi Matthew,

I'm a little concerned that these changes are non trivial and haven't had
much review. But I am prepared to put them into my tree once 2.0.2 is
released - perhaps that way they will get some test coverage. Does
that work for you?

> 
> Matthew McClintock (7):
>   Restore kexec uImage-ppc to working state
>   Fix case where phys_addr_t != unsigned long when reading proc entries
>   Update uImage to support crash kernel and misc fixes
>   Update Elf-ppc to support crash kernel and misc fixes
>   Add support for ramdisk on ppc32 for uImage-ppc and Elf-ppc
>   Add support for reworking flat device tree support
>   Add documentation/howto for mpc85xx systems
> 
>  doc/mpc85xx.txt                       |  190 +++++++++++++++++++++
>  kexec/arch/ppc/Makefile               |    1 +
>  kexec/arch/ppc/fixup_dtb.c            |  298 ++++++++++++++++++++++++++++++++-
>  kexec/arch/ppc/fixup_dtb.h            |    6 +-
>  kexec/arch/ppc/include/arch/options.h |    3 +
>  kexec/arch/ppc/kexec-elf-ppc.c        |  186 +++++++++------------
>  kexec/arch/ppc/kexec-ppc.c            |  262 +++++++++++++++++------------
>  kexec/arch/ppc/kexec-ppc.h            |    3 +
>  kexec/arch/ppc/kexec-uImage-ppc.c     |  136 ++++++++++++---
>  kexec/arch/ppc/ops.h                  |    1 -
>  purgatory/arch/ppc/purgatory-ppc.c    |    5 +
>  11 files changed, 852 insertions(+), 239 deletions(-)
>  create mode 100644 doc/mpc85xx.txt
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA029B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 15:21:09 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc: Split ICSWX ACOP and PID processing
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1312842408-21482-2-git-send-email-jimix@pobox.com>
Date: Tue, 9 Aug 2011 00:20:54 -0500
Message-Id: <F9E15A89-5CC7-4204-807B-D4A52CB51208@kernel.crashing.org>
References: <1312842408-21482-1-git-send-email-jimix@pobox.com>
	<1312842408-21482-2-git-send-email-jimix@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 8, 2011, at 5:26 PM, Jimi Xenidis wrote:

> Some processors, like embedded, that already have a PID register that
> is managed by the system.  This patch separates the ACOP and PID
> processing into separate files so that the ACOP code can be shared.
>=20
> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> ---
> arch/powerpc/mm/Makefile               |    4 +-
> arch/powerpc/mm/icswx.c                |  163 =
++++++++++++++++++++++++++
> arch/powerpc/mm/icswx.h                |   34 ++++++
> arch/powerpc/mm/icswx_pid.c            |   87 ++++++++++++++
> arch/powerpc/mm/mmu_context_hash64.c   |  195 =
--------------------------------
> arch/powerpc/platforms/Kconfig.cputype |   10 ++-
> 6 files changed, 296 insertions(+), 197 deletions(-)
> create mode 100644 arch/powerpc/mm/icswx.c
> create mode 100644 arch/powerpc/mm/icswx.h
> create mode 100644 arch/powerpc/mm/icswx_pid.c
>=20
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index bdca46e..ba51190 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -21,7 +21,9 @@ obj-$(CONFIG_PPC_STD_MMU_32)	+=3D =
ppc_mmu_32.o
> obj-$(CONFIG_PPC_STD_MMU)	+=3D hash_low_$(CONFIG_WORD_SIZE).o \
> 				   tlb_hash$(CONFIG_WORD_SIZE).o \
> 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
> -obj-$(CONFIG_40x)		+=3D 40x_mmu.o
> +obj-$(CONFIG_PPC_ICSWX)		+=3D icswx.o
> +obj-$(CONFIG_PPC_ICSWX_PID)	+=3D icswx_pid.o
> +obj-$(CONFIG_40x)		+=3D 40x_mmu.o?

? seems like a typo

> obj-$(CONFIG_44x)		+=3D 44x_mmu.o
> obj-$(CONFIG_PPC_FSL_BOOK3E)	+=3D fsl_booke_mmu.o
> obj-$(CONFIG_NEED_MULTIPLE_NODES) +=3D numa.o

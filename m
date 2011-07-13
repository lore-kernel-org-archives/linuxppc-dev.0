Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB877B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 15:29:33 +1000 (EST)
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
Date: Wed, 13 Jul 2011 00:28:36 -0500
Message-Id: <BE0C6BFF-E55A-4860-A05C-CA5313012FCC@kernel.crashing.org>
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2011, at 1:44 AM, Suzuki K. Poulose wrote:

> Changes from V1: Uses a tmp mapping in the other address space to =
setup
> 		 the 1:1 mapping (suggested by Sebastian Andrzej =
Siewior).
>=20
> Note: Should we do the same for kernel entry code for PPC44x ?
>=20
> This patch adds kexec support for PPC440 based chipsets.This work is =
based
> on the KEXEC patches for FSL BookE.
>=20
> The FSL BookE patch and the code flow could be found at the link =
below:
>=20
> 	http://patchwork.ozlabs.org/patch/49359/
>=20
> Steps:
>=20
> 1) Invalidate all the TLB entries except the one this code is run from
> 2) Create a tmp mapping for our code in the other address space and =
jump to it
> 3) Invalidate the entry we used
> 4) Create a 1:1 mapping for 0-2GiB in blocks of 256M
> 5) Jump to the new 1:1 mapping and invalidate the tmp mapping
>=20
> I have tested this patches on Ebony, Sequoia boards and Virtex on =
QEMU.
> It would be great if somebody could test this on the other boards.
>=20
> Signed-off-by: 	Suzuki Poulose <suzuki@in.ibm.com>
> Cc:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>=20
> arch/powerpc/Kconfig             |    2=20
> arch/powerpc/include/asm/kexec.h |    2=20
> arch/powerpc/kernel/misc_32.S    |  170 =
++++++++++++++++++++++++++++++++++++++
> 3 files changed, 172 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 423145a6..d04fae0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -349,7 +349,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>=20
> config KEXEC
> 	bool "kexec system call (EXPERIMENTAL)"
> -	depends on (PPC_BOOK3S || FSL_BOOKE) && EXPERIMENTAL
> +	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !47x)) && =
EXPERIMENTAL

Is there something special about 47x that its not supported?

> 	help
> 	  kexec is a system call that implements the ability to shutdown =
your
> 	  current kernel, and to start another kernel.  It is like a =
reboot

- k=

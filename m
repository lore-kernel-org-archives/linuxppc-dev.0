Return-Path: <tony.luck@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id 0BC71DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 05:31:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Wed, 30 Jan 2008 10:31:12 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
In-Reply-To: <20080130180623.GA24881@elte.hu>
References: <200801301414.m0UEEgCC006371@hera.kernel.org>
	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com> <20080130161036.GA12293@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>
	<20080130180623.GA24881@elte.hu>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Could you check the patch below? With this applied to latest -git, =
ia64=20
> buils fine for me in a cross-compiling environment. (but i dont know=20
> whether it boots ...)

Uni-processor build still fails with this patch (config is =
arch/ia64/configs/tiger_defconfig
with CONFIG_SMP switched from =3Dy to =3Dn).

arch/ia64/kernel/built-in.o(.text+0x5012): In function =
`show_interrupts':
: relocation truncated to fit: IMM22 per_cpu__kstat
arch/ia64/kernel/built-in.o(.text+0x53e1): In function =
`__bind_irq_vector':
: relocation truncated to fit: IMM22 per_cpu__vector_irq
arch/ia64/kernel/built-in.o(.text+0x5612): In function =
`__clear_irq_vector':
: relocation truncated to fit: IMM22 per_cpu__vector_irq
arch/ia64/kernel/built-in.o(.text+0x5a81): In function =
`__setup_vector_irq':
: relocation truncated to fit: IMM22 per_cpu__vector_irq
arch/ia64/kernel/built-in.o(.text+0x6231): In function =
`ia64_handle_irq':
: relocation truncated to fit: IMM22 per_cpu____irq_regs
arch/ia64/kernel/built-in.o(.text+0x6272): In function =
`ia64_handle_irq':
: relocation truncated to fit: IMM22 per_cpu__vector_irq
arch/ia64/kernel/built-in.o(.text+0x7b81): In function `cpu_idle_wait':
: relocation truncated to fit: IMM22 .text
arch/ia64/kernel/built-in.o(.text+0x7e21): In function `cpu_idle':
: relocation truncated to fit: IMM22 .text
arch/ia64/kernel/built-in.o(.text+0x7fd1): In function =
`ia64_save_extra':
: relocation truncated to fit: IMM22 per_cpu__pfm_syst_info
arch/ia64/kernel/built-in.o(.text+0x8071): In function =
`ia64_load_extra':
: relocation truncated to fit: IMM22 per_cpu__pfm_syst_info
arch/ia64/kernel/built-in.o(.text+0x95c0): In function =
`pfm_write_ibr_dbr':
: additional relocation overflows omitted from the output
ld: final link failed: Nonrepresentable section on output
make: *** [.tmp_vmlinux1] Error 1

SMP build (config zx1_defconfig) builds ok and boots ok too.

-Tony

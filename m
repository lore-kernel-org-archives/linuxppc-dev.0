Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4975C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:48:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01358214F1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01358214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wfkr6fNmzDqVH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 22:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wfhR3dgfzF3bB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 22:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42wfhQ1Dg8z9s1c;
 Thu, 15 Nov 2018 22:46:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, npiggin@gmail.com, rashmicy@gmail.com
Subject: Re: [PATCH] powerpc/mm: dump block address translation on book3s/32
In-Reply-To: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr>
References: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr>
Date: Thu, 15 Nov 2018 22:46:13 +1100
Message-ID: <878t1uva0q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch adds a debugfs file to dump block address translation:
>
> ~# cat /sys/kernel/debug/block_address_translation

My instinct is it should be in /sys/kernel/debug/powerpc. But I guess
the other page table dump files are not.

> Instruction Block Address Translations:
> 0:         -
> 1:         -
> 2: 0xc0000000-0xcfffffff 0x00000000 Kernel EXEC coherent
> 3: 0xd0000000-0xdfffffff 0x10000000 Kernel EXEC coherent
> 4:         -
> 5:         -
> 6:         -
> 7:         -
>
> Data Block Address Translations:
> 0:         -
> 1:         -
> 2: 0xc0000000-0xcfffffff 0x00000000 Kernel RW coherent
> 3: 0xd0000000-0xdfffffff 0x10000000 Kernel RW coherent
> 4:         -
> 5:         -
> 6:         -
> 7:         -
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  Tested on mpc8321 aka 603
>  Please review/test the 601 part
>
>  arch/powerpc/mm/Makefile    |   2 +-
>  arch/powerpc/mm/dump_bats.c | 176 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 177 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/mm/dump_bats.c
>
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index ca96e7be4d0e..2adad10b5856 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
>  obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
>  obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
>  obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
> -obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
> +obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o

BOOK3S_32 covers quite a lot of CPUs.

But below the only check is that you're on 601 or 603.

So is the 603 code going to work on all other BOOK3S_32 CPUs?

cheers

> diff --git a/arch/powerpc/mm/dump_bats.c b/arch/powerpc/mm/dump_bats.c
> new file mode 100644
> index 000000000000..824a94ee9051
> --- /dev/null
> +++ b/arch/powerpc/mm/dump_bats.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018, Christophe Leroy CS S.I.
> + * <christophe.leroy@c-s.fr>
> + *
> + * This dumps the content of BATS
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/hugetlb.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/seq_file.h>
> +#include <asm/fixmap.h>
> +#include <asm/pgtable.h>
> +#include <linux/const.h>
> +#include <asm/page.h>
> +#include <asm/pgalloc.h>
> +
> +#include <asm/book3s/32/mmu-hash.h>
> +
> +static char *pp_601(int k, int pp)
> +{
> +	if (pp == 0)
> +		return k ? "NA" : "RWX";
> +	if (pp == 1)
> +		return k ? "ROX" : "RWX";
> +	if (pp == 2)
> +		return k ? "RWX" : "RWX";
> +	return k ? "ROX" : "ROX";
> +}
> +
> +static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
> +{
> +	u32 blpi = upper & 0xfffe0000;
> +	u32 k = (upper >> 2) & 3;
> +	u32 pp = upper & 3;
> +	u32 pbn = lower & 0xfffe0000;
> +	u32 bsm = lower & 0x3ff;
> +	u32 size = (bsm + 1) << 17;
> +
> +	seq_printf(m, "%d: ", idx);
> +	if (!(lower & 0x40)) {
> +		seq_puts(m, "        -\n");
> +		return;
> +	}
> +
> +	seq_printf(m, "0x%08x-0x%08x ", blpi, blpi + size - 1);
> +	seq_printf(m, "0x%08x ", pbn);
> +
> +	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
> +
> +	if (lower & _PAGE_WRITETHRU)
> +		seq_puts(m, "write through ");
> +	if (lower & _PAGE_NO_CACHE)
> +		seq_puts(m, "no cache ");
> +	if (lower & _PAGE_COHERENT)
> +		seq_puts(m, "coherent ");
> +	seq_puts(m, "\n");
> +}
> +
> +#define BAT_SHOW_601(_m, _n, _l, _u) bat_show_601(_m, _n, mfspr(_l), mfspr(_u))
> +
> +static int bats_show_601(struct seq_file *m, void *v)
> +{
> +	seq_puts(m, "Block Address Translation:\n");
> +
> +	BAT_SHOW_601(m, 0, SPRN_IBAT0L, SPRN_IBAT0U);
> +	BAT_SHOW_601(m, 1, SPRN_IBAT1L, SPRN_IBAT1U);
> +	BAT_SHOW_601(m, 2, SPRN_IBAT2L, SPRN_IBAT2U);
> +	BAT_SHOW_601(m, 3, SPRN_IBAT3L, SPRN_IBAT3U);
> +
> +	return 0;
> +}
> +
> +static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool is_d)
> +{
> +	u32 bepi = upper & 0xfffe0000;
> +	u32 bl = (upper >> 2) & 0x7ff;
> +	u32 k = upper & 3;
> +	u32 brpn = lower & 0xfffe0000;
> +	u32 size = (bl + 1) << 17;
> +
> +	seq_printf(m, "%d: ", idx);
> +	if (k == 0) {
> +		seq_puts(m, "        -\n");
> +		return;
> +	}
> +
> +	seq_printf(m, "0x%08x-0x%08x ", bepi, bepi + size - 1);
> +	seq_printf(m, "0x%08x ", brpn);
> +
> +	if (k == 1)
> +		seq_puts(m, "User ");
> +	else if (k == 2)
> +		seq_puts(m, "Kernel ");
> +	else
> +		seq_puts(m, "Kernel/User ");
> +
> +	if (lower & BPP_RX)
> +		seq_puts(m, is_d ? "RO " : "EXEC ");
> +	else if (lower & BPP_RW)
> +		seq_puts(m, is_d ? "RW " : "EXEC ");
> +	else
> +		seq_puts(m, is_d ? "NA " : "NX   ");
> +
> +	if (lower & _PAGE_WRITETHRU)
> +		seq_puts(m, "write through ");
> +	if (lower & _PAGE_NO_CACHE)
> +		seq_puts(m, "no cache ");
> +	if (lower & _PAGE_COHERENT)
> +		seq_puts(m, "coherent ");
> +	if (lower & _PAGE_GUARDED)
> +		seq_puts(m, "guarded ");
> +	seq_puts(m, "\n");
> +}
> +
> +#define BAT_SHOW_603(_m, _n, _l, _u, _d) bat_show_603(_m, _n, mfspr(_l), mfspr(_u), _d)
> +
> +static int bats_show_603(struct seq_file *m, void *v)
> +{
> +	seq_puts(m, "Instruction Block Address Translation:\n");
> +
> +	BAT_SHOW_603(m, 0, SPRN_IBAT0L, SPRN_IBAT0U, false);
> +	BAT_SHOW_603(m, 1, SPRN_IBAT1L, SPRN_IBAT1U, false);
> +	BAT_SHOW_603(m, 2, SPRN_IBAT2L, SPRN_IBAT2U, false);
> +	BAT_SHOW_603(m, 3, SPRN_IBAT3L, SPRN_IBAT3U, false);
> +	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
> +		BAT_SHOW_603(m, 4, SPRN_IBAT4L, SPRN_IBAT4U, false);
> +		BAT_SHOW_603(m, 5, SPRN_IBAT5L, SPRN_IBAT5U, false);
> +		BAT_SHOW_603(m, 6, SPRN_IBAT6L, SPRN_IBAT6U, false);
> +		BAT_SHOW_603(m, 7, SPRN_IBAT7L, SPRN_IBAT7U, false);
> +	}
> +
> +	seq_puts(m, "\nData Block Address Translation:\n");
> +
> +	BAT_SHOW_603(m, 0, SPRN_DBAT0L, SPRN_DBAT0U, true);
> +	BAT_SHOW_603(m, 1, SPRN_DBAT1L, SPRN_DBAT1U, true);
> +	BAT_SHOW_603(m, 2, SPRN_DBAT2L, SPRN_DBAT2U, true);
> +	BAT_SHOW_603(m, 3, SPRN_DBAT3L, SPRN_DBAT3U, true);
> +	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
> +		BAT_SHOW_603(m, 4, SPRN_DBAT4L, SPRN_DBAT4U, true);
> +		BAT_SHOW_603(m, 5, SPRN_DBAT5L, SPRN_DBAT5U, true);
> +		BAT_SHOW_603(m, 6, SPRN_DBAT6L, SPRN_DBAT6U, true);
> +		BAT_SHOW_603(m, 7, SPRN_DBAT7L, SPRN_DBAT7U, true);
> +	}
> +
> +	return 0;
> +}
> +
> +static int bats_open(struct inode *inode, struct file *file)
> +{
> +	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
> +		return single_open(file, bats_show_601, NULL);
> +
> +	return single_open(file, bats_show_603, NULL);
> +}
> +
> +static const struct file_operations bats_fops = {
> +	.open		= bats_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int bats_init(void)
> +{
> +	struct dentry *debugfs_file;
> +
> +	debugfs_file = debugfs_create_file("block_address_translation", 0400,
> +					   NULL, NULL, &bats_fops);
> +	return debugfs_file ? 0 : -ENOMEM;
> +}
> +device_initcall(bats_init);
> -- 
> 2.13.3

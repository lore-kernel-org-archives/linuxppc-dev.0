Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1B6942BF16
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 02:45:38 +1100 (EST)
Date: Sun, 9 Jan 2005 16:13:53 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Message-ID: <20050109151353.GA9508@suse.de>
References: <200501082324.j08NOIva030415@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200501082324.j08NOIva030415@hera.kernel.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Jan 08, Linux Kernel Mailing List wrote:

> ChangeSet 1.2347, 2005/01/08 14:02:27-08:00, hpa@zytor.com
> 
> 	[PATCH] raid6: altivec support
> 	
> 	This patch adds Altivec support for RAID-6, if appropriately configured on
> 	the ppc or ppc64 architectures.  Note that it changes the compile flags for
> 	ppc64 in order to handle -maltivec correctly; this change was vetted on the
> 	ppc64 mailing list and OK'd by paulus.

This fails to compile on ppc, enable_kernel_altivec() is an exported but
undeclared function. cpu_features is also missing.

drivers/md/raid6altivec1.c: In function `raid6_altivec1_gen_syndrome':
drivers/md/raid6altivec1.c:99: warning: implicit declaration of function `enable_kernel_altivec'
drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union
drivers/md/raid6altivec2.c: In function `raid6_altivec2_gen_syndrome':
drivers/md/raid6altivec2.c:110: warning: implicit declaration of function `enable_kernel_altivec'

There are a few more exported symbols without declaration:
__ashldi3
__ashrdi3
__lshrdi3
enable_kernel_spe
fec_register_ph
fec_unregister_ph
idma_pci9_read
idma_pci9_read_le
local_irq_disable_end
local_irq_enable_end
local_irq_restore_end
local_save_flags_ptr_end
ocp_bus_type
ppc4xx_set_dma_addr


I'm not sure if the EXPORT_SYMBOL should be dropped for them, they have
no users in the current kernel.

--- ../linux-2.6.10-bk12/include/asm-ppc/system.h	2004-12-24 22:34:32.000000000 +0100
+++ ./include/asm-ppc/system.h	2005-01-09 15:53:32.338569809 +0100
@@ -76,6 +76,7 @@ extern void giveup_fpu(struct task_struc
 extern void enable_kernel_fp(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
+extern void enable_kernel_altivec(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 extern int fix_alignment(struct pt_regs *);

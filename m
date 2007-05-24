Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC33DDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 21:45:42 +1000 (EST)
In-Reply-To: <4655577F.3020801@freescale.com>
References: <4655577F.3020801@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E953418-3B5B-4051-9ABB-4C3B1CE1567F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_lib: export symbols to fix compile error when QE
	drivers compile as modules
Date: Thu, 24 May 2007 06:44:01 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 24, 2007, at 4:14 AM, Li Yang wrote:

> Export symbols of qe_lib to be used by QE drivers.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/ucc.c      |    7 +++++++
> arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
> arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 ++++++++++--
> 3 files changed, 25 insertions(+), 2 deletions(-)

A number of the EXPORT_SYMBOL() are not used by any in kernel drivers  
and thus should not be added.  See comments below.  Also, should  
these be EXPORT_SYMBOL_GPL().

> diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/ 
> qe_lib/ucc.c
> index ac12a44..e8635aa 100644
> --- a/arch/powerpc/sysdev/qe_lib/ucc.c
> +++ b/arch/powerpc/sysdev/qe_lib/ucc.c
> @@ -18,6 +18,7 @@
> #include <linux/errno.h>
> #include <linux/slab.h>
> #include <linux/stddef.h>
> +#include <linux/module.h>
> #include <asm/irq.h>
> #include <asm/io.h>
> @@ -40,6 +41,7 @@ int ucc_set_qe_mux_mii_mng(int ucc_num)
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_set_qe_mux_mii_mng);
> int ucc_set_type(int ucc_num, struct ucc_common *regs,
> 		 enum ucc_speed_type speed)
> @@ -66,6 +68,7 @@ int ucc_set_type(int ucc_num, struct ucc_common  
> *regs,
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_set_type);

remove.

> int ucc_init_guemr(struct ucc_common *regs)
> {
> @@ -81,6 +84,7 @@ int ucc_init_guemr(struct ucc_common *regs)
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_init_guemr);

remove.

> static void get_cmxucr_reg(int ucc_num, volatile u32 ** p_cmxucr,  
> u8 * reg_num,
> 			   u8 * shift)
> @@ -122,6 +126,7 @@ static void get_cmxucr_reg(int ucc_num,  
> volatile u32 ** p_cmxucr, u8 * reg_num,
> 		break;
> 	}
> }
> +EXPORT_SYMBOL(get_cmxucr_reg);

remove, you shouldn't be exporting something marked static.

> int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask)
> {
> @@ -142,6 +147,7 @@ int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int  
> set, u32 mask)
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_mux_set_grant_tsa_bkpt);

remove

> int ucc_set_qe_mux_rxtx(int ucc_num, enum qe_clock clock, enum  
> comm_dir mode)
> {
> @@ -251,3 +257,4 @@ int ucc_set_qe_mux_rxtx(int ucc_num, enum  
> qe_clock clock, enum comm_dir mode)
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_set_qe_mux_rxtx);

remove.

> diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/ 
> sysdev/qe_lib/ucc_fast.c
> index 9143236..3df202e 100644
> --- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
> +++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
> @@ -19,6 +19,7 @@
> #include <linux/stddef.h>
> #include <linux/interrupt.h>
> #include <linux/err.h>
> +#include <linux/module.h>
> #include <asm/io.h>
> #include <asm/immap_qe.h>
> @@ -70,6 +71,7 @@ void ucc_fast_dump_regs(struct ucc_fast_private *  
> uccf)
> 	printk(KERN_INFO "guemr : addr - 0x%08x, val - 0x%02x",
> 		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
> }
> +EXPORT_SYMBOL(ucc_fast_dump_regs);
> u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
> {
> @@ -85,11 +87,13 @@ u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
> 	default: return QE_CR_SUBBLOCK_INVALID;
> 	}
> }
> +EXPORT_SYMBOL(ucc_fast_get_qe_cr_subblock);
> void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf)
> {
> 	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
> }
> +EXPORT_SYMBOL(ucc_fast_transmit_on_demand);
> void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir  
> mode)
> {
> @@ -110,6 +114,7 @@ void ucc_fast_enable(struct ucc_fast_private *  
> uccf, enum comm_dir mode)
> 	}
> 	out_be32(&uf_regs->gumr, gumr);
> }
> +EXPORT_SYMBOL(ucc_fast_enable);
> void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir  
> mode)
> {
> @@ -130,6 +135,7 @@ void ucc_fast_disable(struct ucc_fast_private *  
> uccf, enum comm_dir mode)
> 	}
> 	out_be32(&uf_regs->gumr, gumr);
> }
> +EXPORT_SYMBOL(ucc_fast_disable);
> int ucc_fast_init(struct ucc_fast_info * uf_info, struct  
> ucc_fast_private ** uccf_ret)
> {
> @@ -341,6 +347,7 @@ int ucc_fast_init(struct ucc_fast_info *  
> uf_info, struct ucc_fast_private ** ucc
> 	*uccf_ret = uccf;
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_fast_init);
> void ucc_fast_free(struct ucc_fast_private * uccf)
> {
> @@ -355,3 +362,4 @@ void ucc_fast_free(struct ucc_fast_private * uccf)
> 	kfree(uccf);
> }
> +EXPORT_SYMBOL(ucc_fast_free);
> diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/ 
> sysdev/qe_lib/ucc_slow.c
> index 1f65c26..5618275 100644
> --- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
> +++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
> @@ -19,6 +19,7 @@
> #include <linux/stddef.h>
> #include <linux/interrupt.h>
> #include <linux/err.h>
> +#include <linux/module.h>
> #include <asm/io.h>
> #include <asm/immap_qe.h>
> @@ -41,11 +42,13 @@ u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
> 	default: return QE_CR_SUBBLOCK_INVALID;
> 	}
> }
> +EXPORT_SYMBOL(ucc_slow_get_qe_cr_subblock);

remove.

> void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs)
> {
> 	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
> }
> +EXPORT_SYMBOL(ucc_slow_poll_transmitter_now);

remove.

> void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs)
> {
> @@ -56,6 +59,7 @@ void ucc_slow_graceful_stop_tx(struct  
> ucc_slow_private * uccs)
> 	qe_issue_cmd(QE_GRACEFUL_STOP_TX, id,
> 			 QE_CR_PROTOCOL_UNSPECIFIED, 0);
> }
> +EXPORT_SYMBOL(ucc_slow_graceful_stop_tx);

remove.

> void ucc_slow_stop_tx(struct ucc_slow_private * uccs)
> {
> @@ -65,6 +69,7 @@ void ucc_slow_stop_tx(struct ucc_slow_private *  
> uccs)
> 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
> 	qe_issue_cmd(QE_STOP_TX, id, QE_CR_PROTOCOL_UNSPECIFIED, 0);
> }
> +EXPORT_SYMBOL(ucc_slow_stop_tx);

remove.

> void ucc_slow_restart_tx(struct ucc_slow_private * uccs)
> {
> @@ -74,6 +79,7 @@ void ucc_slow_restart_tx(struct ucc_slow_private  
> * uccs)
> 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
> 	qe_issue_cmd(QE_RESTART_TX, id, QE_CR_PROTOCOL_UNSPECIFIED, 0);
> }
> +EXPORT_SYMBOL(ucc_slow_restart_tx);

remove.

> void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir  
> mode)
> {
> @@ -94,6 +100,7 @@ void ucc_slow_enable(struct ucc_slow_private *  
> uccs, enum comm_dir mode)
> 	}
> 	out_be32(&us_regs->gumr_l, gumr_l);
> }
> +EXPORT_SYMBOL(ucc_slow_enable);

remove.

> void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir  
> mode)
> {
> @@ -114,6 +121,7 @@ void ucc_slow_disable(struct ucc_slow_private *  
> uccs, enum comm_dir mode)
> 	}
> 	out_be32(&us_regs->gumr_l, gumr_l);
> }
> +EXPORT_SYMBOL(ucc_slow_disable);

remove.

> int ucc_slow_init(struct ucc_slow_info * us_info, struct  
> ucc_slow_private ** uccs_ret)
> {
> @@ -349,6 +357,7 @@ int ucc_slow_init(struct ucc_slow_info *  
> us_info, struct ucc_slow_private ** ucc
> 	*uccs_ret = uccs;
> 	return 0;
> }
> +EXPORT_SYMBOL(ucc_slow_init);

remove.

> void ucc_slow_free(struct ucc_slow_private * uccs)
> {
> @@ -368,5 +377,4 @@ void ucc_slow_free(struct ucc_slow_private * uccs)
> 	kfree(uccs);
> }
> -
> -
> +EXPORT_SYMBOL(ucc_slow_free);

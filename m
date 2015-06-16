Return-Path: <ppc@mindchasers.com>
Received: from resqmta-ch2-11v.sys.comcast.net
 (resqmta-ch2-11v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:43])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443381A0396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 13:51:22 +1000 (AEST)
Message-ID: <557F9B3A.2000108@mindchasers.com>
Date: Mon, 15 Jun 2015 23:42:50 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: madalin.bucur@freescale.com, linuxppc-dev@lists.ozlabs.org
CC: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
Subject: Re: [PATCH 08/12] fsl/fman: Add Frame Manager support
References: <1433949712-5648-1-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-2-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-3-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-4-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1433949712-5648-4-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 11:21 AM, Madalin Bucur wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
>
> Add Frame Manger Driver support.
> This patch adds The FMan configuration, initialization and
> runtime control routines.
>
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>   drivers/net/ethernet/freescale/fman/Kconfig        |   37 +
>   drivers/net/ethernet/freescale/fman/Makefile       |    2 +-
>   drivers/net/ethernet/freescale/fman/fm.c           | 1478 ++++++++++++++++++++
>   drivers/net/ethernet/freescale/fman/fm.h           |  404 ++++++
>   drivers/net/ethernet/freescale/fman/fm_common.h    |  367 +++++
>   drivers/net/ethernet/freescale/fman/fm_drv.c       |  827 +++++++++++
>   drivers/net/ethernet/freescale/fman/fm_drv.h       |  123 ++
>   drivers/net/ethernet/freescale/fman/inc/enet_ext.h |  199 +++
>   drivers/net/ethernet/freescale/fman/inc/fm_ext.h   |  453 ++++++
>   .../net/ethernet/freescale/fman/inc/fsl_fman_drv.h |   94 ++
>   drivers/net/ethernet/freescale/fman/inc/net_ext.h  |  534 +++++++
>   drivers/net/ethernet/freescale/fman/inc/service.h  |   90 ++
>   12 files changed, 4607 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/freescale/fman/fm.c
>   create mode 100644 drivers/net/ethernet/freescale/fman/fm.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/fm_common.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/fm_drv.c
>   create mode 100644 drivers/net/ethernet/freescale/fman/fm_drv.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/inc/enet_ext.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/inc/fm_ext.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/inc/fsl_fman_drv.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/inc/net_ext.h
>   create mode 100644 drivers/net/ethernet/freescale/fman/inc/service.h
>

-- cut ---

> +
> +#endif /* __FM_H */
> diff --git a/drivers/net/ethernet/freescale/fman/fm_common.h b/drivers/net/ethernet/freescale/fman/fm_common.h
> new file mode 100644
> index 0000000..125c057
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/fm_common.h
> @@ -0,0 +1,367 @@
> +/*
> + * Copyright 2008-2015 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/* File          fm_common.h
> + * Description   FM internal structures and definitions.
> + */
> +#ifndef __FM_COMMON_H
> +#define __FM_COMMON_H
> +
> +#include "service.h"
> +#include "fm_ext.h"
> +
> +/* Uniqe defines */


Unique instead of Uniqe?

> +#define FM_QMI_NO_ECC_EXCEPTIONS		/* P1 */
> +#define FM_CSI_CFED_LIMIT			/* P1 */
> +#define FM_PEDANTIC_DMA				/* P1 */
> +#define FM_QMI_NO_DEQ_OPTIONS_SUPPORT		/* P1 */
> +#define FM_HAS_TOTAL_DMAS			/* P1-P5 */
> +#define FM_DEQ_PIPELINE_PARAMS_FOR_OP		/* P1, T/B */
> +#define FM_NO_DISPATCH_RAM_ECC			/* P2-P5 */
> +#define FM_NO_WATCHDOG				/* P4 */
> +#define FM_NO_TNUM_AGING			/* P2-P5 */
> +#define FM_NO_BACKUP_POOLS			/* P2-P5 */
> +#define FM_NO_OP_OBSERVED_POOLS		/* P2-P5, T/B */
> +#define FM_NO_ADVANCED_RATE_LIMITER		/* P2-P5 */
> +#define FM_OP_OPEN_DMA_MIN_LIMIT		/* T/B */
> +#define FM_NO_RESTRICT_ON_ACCESS_RSRC		/* T/B */
> +#define FM_FRAME_END_PARAMS_FOR_OP		/* T/B */
> +#define FM_QMI_NO_SINGLE_ECC_EXCEPTION		/* T/B */
> +
> +/* FMan Errata */


Will there be documentation to let the user know how to turn off and on 
these errata (code fixes) ?  From reviewing the source for some of the 
errata fixes, I gather it's not always automatic.  I saw that booleans 
are sometimes used (e.g, bcb_workaround) along with HW block IP version 
information to either apply the errata or not.

Also, some of the comments and errata names below refer to information 
that is probably strictly internal to Freescale, so how can I be sure 
whether to apply these errata or not and their purpose?   My concern is 
that some of these errata may be applied to my SoC by default when they 
shouldn't be, and I may not know if it's a potential problem.  I saw 
this sort of thing in the SDK kernel when FMAN V3H errata fixes were 
applied to FMAN V3L and wrong values were set due to V3L having lesser 
capabilities than V3H.

It would be great if you could use errata names (#defines) that can be 
looked up by your customers.  I understand that this may require an NDA 
and a HW errata sheet.


> +#define FM_RX_PREAM_4_ERRATA_DTSEC_A001			/* Dtsec */
> +#define FM_GTS_AFTER_DROPPED_FRAME_ERRATA_DTSEC_A004839	/* Dtsec */
> +#define FM_TX_FIFO_CORRUPTION_ERRATA_10GMAC_A007		/* Tgec */
> +#define FM_ECC_HALT_NO_SYNC_ERRATA_10GMAC_A008			/* P2-P5 */
> +#define FM_GRS_ERRATA_DTSEC_A002				/* P4080 */
> +#define FM_BAD_TX_TS_IN_B_2_B_ERRATA_DTSEC_A003		/* P4080 */
> +#define FM_GTS_ERRATA_DTSEC_A004				/* P4080 */
> +#define FM_GTS_AFTER_MAC_ABORTED_FRAME_ERRATA_DTSEC_A0012	/* P4080 */
> +#define FM_GTS_UNDERRUN_ERRATA_DTSEC_A0014			/* P2-P5 */
> +#define FM_TX_LOCKUP_ERRATA_DTSEC6				/* P4080 */
> +#define FM_UCODE_NOT_RESET_ERRATA_BUGZILLA6173			/* P2-P5 */

I assume it's an internal Bugzilla entry?


> +#define FM_10G_REM_N_LCL_FLT_EX_10GMAC_ERRATA_SW005		/* P4080 */
> +#define FM_TX_ECC_FRMS_ERRATA_10GMAC_A004			/* P2-P5 */
> +#define FM_LEN_CHECK_ERRATA_FMAN_SW002				/* P2-P5, T/B */
> +#define FM_WRONG_RESET_VALUES_ERRATA_FMAN_A005127		/* T/B */


Does 'T' mean both FMAN V3H and V3L?  I didn't find A005127 listed as an 
errata for V3L.


> +#define FM_RX_FIFO_CORRUPT_ERRATA_10GMAC_A006320		/* mEMAC */
> +#define FM_HEAVY_TRAFFIC_SEQUENCER_HANG_ERRATA_FMAN_A006981   /* T4/B4 rev1 */
> +#define FM_AID_MODE_NO_TNUM_SW005
> +/* refer to pdm TKT068794 - only support of port_id on aid - T/B */


Can I actually refer to pdm TKT068794?


> +#define FM_ERROR_VSP_NO_MATCH_SW006
> +/* refer to pdm TKT174304 - no match between errorQ and VSP - T/B */

TKT174304?


> +
> +#define CLS_PLAN_NUM_PER_GRP                        8
> +
> +/* list_object
> + * Macro to get the struct (object) for this entry.
> + * type   - The type of the struct (object) this list
> + * is embedded in.
> + * member - The name of the struct list_head object
> + * within the struct.
> + * Return        The structure pointer for this entry.
> + */
> +#define member_offset(type, member) (PTR_TO_UINT(&((type *)0)->member))
> +#define list_object(p_list, type, member) \
> +((type *)((char *)(p_list) - member_offset(type, member)))
> +
> +/* Enum for inter-module interrupts registration */
> +enum fm_event_modules {
> +	FM_MOD_PRS = 0,		/* Parser event */
> +	FM_MOD_MAC,		/* MAC event */
> +	FM_MOD_TMR,		/* Timer event */
> +	FM_MOD_FMAN_CTRL,	/* FMAN Controller  Timer event */
> +	FM_MOD_DUMMY_LAST
> +};
> +
> +/* Enum for interrupts types */
> +enum fm_intr_type {
> +	FM_INTR_TYPE_ERR,
> +	FM_INTR_TYPE_NORMAL
> +};
> +
> +/* Enum for inter-module interrupts registration */
> +enum fm_inter_module_event {
> +	FM_EV_PRS = 0,		/* Parser event */
> +	FM_EV_ERR_PRS,		/* Parser error event */
> +	FM_EV_ERR_MAC8,		/* MAC 8 error event */
> +	FM_EV_ERR_MAC9,		/* MAC 9 error event */
> +	FM_EV_ERR_MAC0,		/* MAC 0 error event */
> +	FM_EV_ERR_MAC1,		/* MAC 1 error event */
> +	FM_EV_ERR_MAC2,		/* MAC 2 error event */
> +	FM_EV_ERR_MAC3,		/* MAC 3 error event */
> +	FM_EV_ERR_MAC4,		/* MAC 4 error event */
> +	FM_EV_ERR_MAC5,		/* MAC 5 error event */
> +	FM_EV_ERR_MAC6,		/* MAC 6 error event */
> +	FM_EV_ERR_MAC7,		/* MAC 7 error event */
> +	FM_EV_TMR,		/* Timer event */
> +	FM_EV_MAC8,		/* MAC 8 event (Magic packet detection)*/
> +	FM_EV_MAC9,		/* MAC 9 event (Magic packet detection)*/
> +	FM_EV_MAC0,		/* MAC 0 event (Magic packet detection)*/
> +	FM_EV_MAC1,		/* MAC 1 event (Magic packet detection)*/
> +	FM_EV_MAC2,		/* MAC 2 (Magic packet detection)*/
> +	FM_EV_MAC3,		/* MAC 3 (Magic packet detection)*/
> +	FM_EV_MAC4,		/* MAC 4 (Magic packet detection)*/
> +	FM_EV_MAC5,		/* MAC 5 (Magic packet detection)*/
> +	FM_EV_MAC6,		/* MAC 6 (Magic packet detection)*/
> +	FM_EV_MAC7,		/* MAC 7 (Magic packet detection)*/
> +	FM_EV_FMAN_CTRL_0,	/* Fman controller event 0 */
> +	FM_EV_FMAN_CTRL_1,	/* Fman controller event 1 */
> +	FM_EV_FMAN_CTRL_2,	/* Fman controller event 2 */
> +	FM_EV_FMAN_CTRL_3,	/* Fman controller event 3 */
> +	FM_EV_DUMMY_LAST
> +};
> +
> +/* FM IP BLOCK versions */
> +#define FM_IP_BLOCK_P1			4
> +#define FM_IP_BLOCK_P2_P3_P5		3
> +#define FM_IP_BLOCK_P4			2
> +#define FM_IP_BLOCK_B_T			6
> +
> +/*for UNDER_CONSTRUCTION_FM_RMU_USE_SEC its defined in fm_ext.h*/
> +typedef uint32_t fm_fman_ctrl_t;
> +
> +#define FPM_PORT_FM_CTL1                0x00000001
> +#define FPM_PORT_FM_CTL2                0x00000002
> +
> +static inline bool TRY_LOCK(spinlock_t *spinlock, volatile bool *p_flag)
> +{
> +	unsigned long int_flags;
> +
> +	if (spinlock)
> +		spin_lock_irqsave(spinlock, int_flags);
> +	else
> +		local_irq_save(int_flags);
> +
> +	if (*p_flag) {
> +		if (spinlock)
> +			spin_unlock_irqrestore(spinlock, int_flags);
> +		else
> +			local_irq_restore(int_flags);
> +		return false;
> +	}
> +	*p_flag = true;
> +
> +	if (spinlock)
> +		spin_unlock_irqrestore(spinlock, int_flags);
> +	else
> +		local_irq_restore(int_flags);
> +
> +	return true;
> +}
> +
> +#define RELEASE_LOCK(_flag) (_flag = false)
> +
> +/* Defines used for manipulation CC and BMI */
> +#define INTERNAL_CONTEXT_OFFSET                 0x80000000
> +#define OFFSET_OF_PR                            0x40000000
> +#define NUM_OF_TASKS                            0x10000000
> +#define OFFSET_OF_DATA                          0x08000000
> +#define HW_PORT_ID                              0x04000000
> +#define FM_REV                                  0x02000000
> +#define GET_NIA_FPNE                            0x01000000
> +#define GET_NIA_PNDN                            0x00800000
> +#define NUM_OF_EXTRA_TASKS                      0x00400000
> +#define DISCARD_MASK                            0x00200000
> +
> +#define UPDATE_NIA_PNEN                         0x80000000
> +#define UPDATE_PSO                              0x40000000
> +#define UPDATE_NIA_PNDN                         0x20000000
> +#define UPDATE_FMFP_PRC_WITH_ONE_RISC_ONLY      0x10000000
> +#define UPDATE_NIA_FENE                         0x04000000
> +#define UPDATE_NIA_CMNE                         0x02000000
> +#define UPDATE_NIA_FPNE                         0x01000000
> +
> +/* Defines used for manipulation CC and CC */
> +#define UPDATE_NIA_ENQ_WITHOUT_DMA              0x80000000
> +
> +#define MODULE_NAME_SIZE        30
> +#define DUMMY_PORT_ID           0
> +
> +#define FM_LIODN_OFFSET_MASK    0x3FF
> +
> +/* Description        CTRL Parameters Page defines */
> +#define FM_CTL_PARAMS_PAGE_OP_FIX_EN            0x80000000
> +#define FM_CTL_PARAMS_PAGE_ALWAYS_ON            0x00000100
> +
> +#define FM_CTL_PARAMS_PAGE_ERROR_VSP_MASK       0x0000003f
> +
> +#define BMI_MAX_FIFO_SIZE                   (FM_MURAM_SIZE)
> +#define BMI_FIFO_UNITS                      0x100
> +
> +struct fm_intr_src_t {
> +	void (*f_isr)(void *h_src_arg);
> +	void *h_src_handle;
> +};
> +
> +#define ILLEGAL_HDR_NUM                     0xFF
> +#define NO_HDR_NUM                          FM_PCD_PRS_NUM_OF_HDRS
> +
> +#define IS_PRIVATE_HEADER(hdr)	(((hdr) == HEADER_TYPE_USER_DEFINED_SHIM1) || \
> +				 ((hdr) == HEADER_TYPE_USER_DEFINED_SHIM2))
> +
> +#define GET_PRS_HDR_NUM(num, hdr) do {\
> +switch (hdr) { \
> +case (HEADER_TYPE_ETH):\
> +	num = 0;  break;   \
> +case (HEADER_TYPE_LLC_SNAP):\
> +	num = 1;  break;   \
> +case (HEADER_TYPE_VLAN):\
> +	num = 2;  break;   \
> +case (HEADER_TYPE_PPPOE):\
> +	num = 3;  break;   \
> +case (HEADER_TYPE_PPP):\
> +	num = 3;  break;   \
> +case (HEADER_TYPE_MPLS):\
> +	num = 4;  break;   \
> +case (HEADER_TYPE_IPV4):\
> +	num = 5;  break;   \
> +case (HEADER_TYPE_IPV6):\
> +	num = 6;  break;   \
> +case (HEADER_TYPE_GRE):\
> +	num = 7;  break;   \
> +case (HEADER_TYPE_MINENCAP):\
> +	num = 8;  break;   \
> +case (HEADER_TYPE_USER_DEFINED_L3):\
> +	num = 9;  break;   \
> +case (HEADER_TYPE_TCP):\
> +	num = 10; break;   \
> +case (HEADER_TYPE_UDP):\
> +	num = 11; break;   \
> +case (HEADER_TYPE_IPSEC_AH): \
> +case (HEADER_TYPE_IPSEC_ESP):\
> +	num = 12; break;   \
> +case (HEADER_TYPE_SCTP):\
> +	num = 13; break;   \
> +case (HEADER_TYPE_DCCP):\
> +	num = 14; break;   \
> +case (HEADER_TYPE_USER_DEFINED_L4):\
> +	num = 15; break;   \
> +case (HEADER_TYPE_USER_DEFINED_SHIM1):                  \
> +case (HEADER_TYPE_USER_DEFINED_SHIM2):                  \
> +	num = NO_HDR_NUM; break;                            \
> +default:                                                \
> +	pr_err("Unsupported header for parser\n");\
> +	num = ILLEGAL_HDR_NUM; break;                       \
> +} \
> +} while (0)
> +
> +/* Function      fm_register_intr
> + * Description   Used to register
> + * an inter-module event handler to be processed by FM
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Param[in]     mod             The module that causes the event
> + * Param[in]     mod_id           Module id - if more than 1 instance of this
> + *				mode exists,0 otherwise.
> + * Param[in]     intr_type        Interrupt type (error/normal) selection.
> + * Param[in]     f_isr           The interrupt service routine.
> + * Param[in]     h_src_arg           Argument to be passed to f_isr.
> + * Return        None.
> + */
> +void fm_register_intr(struct fm_t *p_fm,
> +		      enum fm_event_modules mod,
> +		      uint8_t mod_id,
> +		      enum fm_intr_type intr_type,
> +		      void (*f_isr)(void *h_src_arg), void *h_src_arg);
> +
> +/* Function      fm_unregister_intr
> + * Description   Used to un-register an
> + * inter-module event handler that was processed by FM
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Param[in]     mod             The module that causes the event
> + * Param[in]     mod_id           Module id - if more than 1 instance of this
> + *				mode exists,0 otherwise.
> + * Param[in]     intr_type        Interrupt type (error/normal) selection.
> + * Return        None.
> + */
> +void fm_unregister_intr(struct fm_t *p_fm,
> +			enum fm_event_modules mod,
> +			uint8_t mod_id, enum fm_intr_type intr_type);
> +
> +/* Description   enum for defining MAC types */
> +enum fm_mac_type {
> +	FM_MAC_10G = 0,	    /* 10G MAC */
> +	FM_MAC_1G	    /* 1G MAC */
> +};
> +
> +/* Function      fm_get_muram_pointer
> + * Description   Get the pointer of the MURAM from the FM module
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Return        MURAM module pointer.
> + */
> +struct muram_info *fm_get_muram_pointer(struct fm_t *p_fm);
> +
> +/* Function      fm_get_physical_muram_base
> + * Description   Get the physical base address of the MURAM from the FM module
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Param[in]     fm_phys_addr      Physical MURAM base
> + * Return        Physical base address.
> + */
> +void fm_get_physical_muram_base(struct fm_t *p_fm,
> +				struct fm_phys_addr_t *fm_phys_addr);
> +
> +/* Function      fm_get_clock_freq
> + * Description   Used by MAC driver to get the FM clock frequency
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Return        clock-freq on success; 0 otherwise.
> + * Cautions      Allowed only following fm_init().
> + */
> +uint16_t fm_get_clock_freq(struct fm_t *p_fm);
> +
> +/*Function      fm_get_id
> + * Description   Used by PCD driver to read rhe FM id
> + * Param[in]     h_fm            A handle to an FM Module.
> + * Return        0 on success; Error code otherwise.
> + * Cautions      Allowed only following fm_init().
> + */
> +uint8_t fm_get_id(struct fm_t *p_fm);
> +
> +int fm_set_num_of_open_dmas(struct fm_t *p_fm,
> +			    uint8_t port_id,
> +			    uint8_t *p_num_of_open_dmas,
> +			    uint8_t *p_num_of_extra_open_dmas,
> +			    bool initial_config);
> +int fm_set_num_of_tasks(struct fm_t *p_fm,
> +			uint8_t port_id,
> +			uint8_t *p_num_of_tasks,
> +			uint8_t *p_num_of_extra_tasks,
> +			bool initial_config);
> +int fm_set_size_of_fifo(struct fm_t *p_fm,
> +			uint8_t port_id,
> +			uint32_t *p_size_of_fifo,
> +			uint32_t *p_extra_size_of_fifo,
> +			bool initial_config);
> +
> +uint32_t fm_get_bmi_max_fifo_size(struct fm_t *p_fm);
> +struct num_of_ports_info_t *fm_get_num_of_ports(struct fm_t *p_fm);
> +

-- cut ---

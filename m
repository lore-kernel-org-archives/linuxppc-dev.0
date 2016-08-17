Return-Path: <bharata.rao@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDgwf0fk6zDsWx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 17:34:42 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id o1so8313904qkd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 00:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8e1bef10-1514-d309-a994-ca1dd4ea49b2@linux.vnet.ibm.com>
References: <8e1bef10-1514-d309-a994-ca1dd4ea49b2@linux.vnet.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Wed, 17 Aug 2016 13:04:39 +0530
Message-ID: <CAGZKiBqJ2Ry5twv8pMXXKoyxCzFqWsS=6Gq6-nP=fcp9FgvP_Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/8] powerpc/firmware: Add definitions for new firmware
 features.
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 2, 2016 at 6:12 AM, Michael Bringmann
<mwb@linux.vnet.ibm.com> wrote:
> Firmware Features: Define new bit flags representing the presence of
> new device tree properties "ibm,drc-info", and "ibm,dynamic-memory-v2".
> These flags are used to tell the front end processor when the Linux
> kernel supports the new properties, and by the front end processor to
> tell the Linux kernel that the new properties are present in the devie
> tree.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index b062924..a9d66d5 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -51,6 +51,8 @@
>  #define FW_FEATURE_BEST_ENERGY ASM_CONST(0x0000000080000000)
>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>  #define FW_FEATURE_PRRN                ASM_CONST(0x0000000200000000)
> +#define FW_FEATURE_DYN_MEM_V2  ASM_CONST(0x0000000400000000)
> +#define FW_FEATURE_DRC_INFO    ASM_CONST(0x0000000800000000)
>
>  #ifndef __ASSEMBLY__
>
> @@ -66,7 +68,8 @@ enum {
>                 FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>                 FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>                 FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> -               FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> +               FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> +               FW_FEATURE_DYN_MEM_V2 | FW_FEATURE_DRC_INFO,
>         FW_FEATURE_PSERIES_ALWAYS = 0,
>         FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>         FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..b9a1534 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -155,6 +203,8 @@ struct of_drconf_cell {
>  #define OV5_PFO_HW_842         0x0E40  /* PFO Compression Accelerator */
>  #define OV5_PFO_HW_ENCR                0x0E20  /* PFO Encryption Accelerator */
>  #define OV5_SUB_PROCESSORS     0x0F01  /* 1,2,or 4 Sub-Processors supported */
> +#define OV5_DYN_MEM_V2         0x1680  /* Redef Prop Structures: dyn-mem-v2 */
> +#define OV5_DRC_INFO           0x1640  /* Redef Prop Structures: drc-info   */

Shouldn't these two features be set in ibm_architecture_vec[] so that
guest firmware knows when to generate these two new device tree
properties ?

Regards,
Bharata.

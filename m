Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQpLC6q7LzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 16:59:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, brking@linux.vnet.ibm.com,
 clsoto@linux.vnet.ibm.com
Subject: Re: [PATCH v4] powerpc/powernv: Enable PCI peer-to-peer
In-Reply-To: <20170804095514.11224-1-fbarrat@linux.vnet.ibm.com>
References: <20170804095514.11224-1-fbarrat@linux.vnet.ibm.com>
Date: Mon, 07 Aug 2017 16:59:30 +1000
Message-ID: <87k22fq2wd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 7df005965634..2f52182a4c63 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -193,7 +193,13 @@
>  #define OPAL_IMC_COUNTERS_INIT			149
>  #define OPAL_IMC_COUNTERS_START			150
>  #define OPAL_IMC_COUNTERS_STOP			151
> -#define OPAL_LAST				151
> +#define OPAL_GET_POWERCAP                       152
> +#define OPAL_SET_POWERCAP                       153
> +#define OPAL_GET_POWER_SHIFT_RATIO              154
> +#define OPAL_SET_POWER_SHIFT_RATIO              155
> +#define OPAL_SENSOR_GROUP_CLEAR                 156

Those are not your OPAL calls, so they shouldn't be in this patch.

I'll drop them.

> +#define OPAL_PCI_SET_P2P                        157
> +#define OPAL_LAST                               157

Whitespace is messed up there, I can fix it.

> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index de9681034353..59a548909d0b 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -26,6 +26,8 @@ extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>  				   struct opal_msg *msg);
> +extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
> +			uint64_t desc);

I know the OPAL API uses unit64_t, but in the kernel we use u64. I can
fix it up.


cheers

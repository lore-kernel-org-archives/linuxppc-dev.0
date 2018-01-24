Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR6dF29kmzDrCg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 12:14:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
In-Reply-To: <20180105164552.36371-4-bryantly@linux.vnet.ibm.com>
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
 <20180105164552.36371-4-bryantly@linux.vnet.ibm.com>
Date: Wed, 24 Jan 2018 12:14:08 +1100
Message-ID: <87shawukgv.fsf@concordia.ellerman.id.au>
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

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:

> To correctly use EEH code one has to make
> sure that the EEH_PE_VF is set for dynamic created
> VFs. Therefore this patch allocates an eeh_pe of
> eeh type EEH_PE_VF and associates PE with parent.
>
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pci-bridge.h        |  5 ++++-
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 9f66ddebb799..16d70740a76f 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -211,7 +211,10 @@ struct pci_dn {
>  	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
>  	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>  #define IODA_INVALID_M64        (-1)
> -	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
> +	union {
> +		int     (*m64_map)[PCI_SRIOV_NUM_BARS]; /*Only used in powernv */
> +		int     last_allow_rc;	/* Only used in pSeries */
> +	};
>  #endif /* CONFIG_PCI_IOV */
>  	int	mps;			/* Maximum Payload Size */
>  	struct list_head child_list;

I don't see the point of using a union to save 4 bytes.

And if you look at the current layout of the struct there's actually a 4
byte hole after mps, so it doesn't actually save any space at all.

I can remove it before applying, unless there's some compelling reason
for it I'm not seeing.

cheers

Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJPjS3l4rzDvc6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:08:12 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so8691587pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 16:08:12 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm/coproc: Handle bad address on coproc slb fault
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com
References: <20161115150606.14090-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <59946d74-9903-6df5-8a79-84b8b337a8d9@gmail.com>
Date: Wed, 16 Nov 2016 11:08:05 +1100
MIME-Version: 1.0
In-Reply-To: <20161115150606.14090-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 02:06, Aneesh Kumar K.V wrote:
> VSID 0 is bad address. Don't create slb entries on coproc fault for
> bad address
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> NOTE: note tested
        ^^^ ?
> 
>  arch/powerpc/mm/copro_fault.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index 362954f98029..aaa7ec6788b9 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -134,6 +134,9 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>  		pr_debug("%s: invalid region access at %016llx\n", __func__, ea);
>  		return 1;
>  	}
> +	/* Bad address */
> +	if (!vsid)
> +		return 1;


Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.

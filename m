Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414pnb6vhNzF4VB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 22:18:27 +1000 (AEST)
Subject: Re: [PATCH 5/5] powerpc/pkeys: make protection key 0 less special
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au
Cc: Ulrich.Weigand@de.ibm.com, mhocko@kernel.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, luto@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
 <1528164594-23823-6-git-send-email-linuxram@us.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c70afc10-9ad4-c5ec-6773-7f0ef455dced@redhat.com>
Date: Tue, 12 Jun 2018 14:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <1528164594-23823-6-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2018 04:09 AM, Ram Pai wrote:
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..d349e22 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -13,7 +13,10 @@
>   
>   DECLARE_STATIC_KEY_TRUE(pkey_disabled);
>   extern int pkeys_total; /* total pkeys as per device tree */
> -extern u32 initial_allocation_mask; /* bits set for reserved keys */
> +extern u32 initial_allocation_mask; /*  bits set for the initially allocated keys */
> +extern u32 reserved_allocation_mask; /* bits set for reserved keys */
> +
> +#define PKEY_0	0
>   
>   /*
>    * Define these here temporarily so we're not dependent on patching linux/mm.h.

This part no longer applies cleanly.

Thanks,
Florian

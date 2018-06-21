Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B3dH69kRzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 11:14:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L1EPlT149198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 21:14:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jr15b1mx6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 21:14:25 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 21 Jun 2018 02:14:23 +0100
Date: Wed, 20 Jun 2018 18:14:14 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 fweimer@redhat.com, msuchanek@suse.de
Subject: Re: [PATCH] powerpc/pkeys: preallocate execute_only key only if the
 key is available.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1529472862-26506-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1529472862-26506-1-git-send-email-linuxram@us.ibm.com>
Message-Id: <20180621011414.GI5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:34:22PM -0700, Ram Pai wrote:
> Key 2 is preallocated and reserved for execute-only key. In rare
> cases if key-2 is unavailable, mprotect(PROT_EXEC) will behave
> incorrectly. NOTE: mprotect(PROT_EXEC) uses execute-only key.
> 
> Ensure key 2 is available for preallocation before reserving it for
> execute_only purpose.
> 
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/pkeys.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index cec990c..2013ef0 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -19,6 +19,7 @@
>  u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
>  u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
>  u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
> +u32  execute_only_key = 2;

this cannot be unsigned, since it can get set to -1 if key 2 is not available.  :(
Please ignore this patch.  Will resend a fixed version.

> 
>  #define AMR_BITS_PER_PKEY 2
>  #define AMR_RD_BIT 0x1UL
> @@ -26,7 +27,6 @@
>  #define IAMR_EX_BIT 0x1UL
>  #define PKEY_REG_BITS (sizeof(u64)*8)
>  #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
> -#define EXECUTE_ONLY_KEY 2
> 
>  static void scan_pkey_feature(void)
>  {
> @@ -122,8 +122,12 @@ int pkey_initialize(void)
>  #else
>  	os_reserved = 0;
>  #endif
> +
> +	if ((pkeys_total - os_reserved) <= execute_only_key)
> +		execute_only_key = -1;
> +


.snip..

RP

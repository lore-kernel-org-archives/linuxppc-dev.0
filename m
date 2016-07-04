Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjZZ60tTXzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 14:59:42 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ts6so14935637pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jul 2016 21:59:42 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Add a parameter to disable 1TB segs
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1467593044-10600-1-git-send-email-oohall@gmail.com>
Cc: mikey@neuling.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <39027e13-4fc0-9e84-0004-5401a40fd955@gmail.com>
Date: Mon, 4 Jul 2016 14:59:35 +1000
MIME-Version: 1.0
In-Reply-To: <1467593044-10600-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/07/16 10:44, Oliver O'Halloran wrote:
> This patch adds the kernel command line parameter "no_tb_segs" which
> forces the kernel to use 256MB rather than 1TB segments. Forcing the use
> of 256MB segments makes it considerably easier to test code that depends
> on an SLB miss occurring.
> 
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 5b22ba0b58bc..6da1a9d18e15 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -321,6 +321,15 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  	return ret;
>  }
>  
> +static bool no_tb_segs = false;
> +
> +static int __init parse_no_tb_segs(char *p)
> +{
> +	no_tb_segs = true;
> +	return 0;
> +}
> +early_param("no_tb_segs", parse_no_tb_segs);


Please update Documentation/kernel-paramaters.txt as well and document the use case and the
fact that this for debugging. 

> +
>  static int __init htab_dt_scan_seg_sizes(unsigned long node,
>  					 const char *uname, int depth,
>  					 void *data)
> @@ -339,6 +348,12 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
>  	for (; size >= 4; size -= 4, ++prop) {
>  		if (be32_to_cpu(prop[0]) == 40) {
>  			DBG("1T segment support detected\n");
> +
> +			if (no_tb_segs) {
> +				DBG("Forcing 256MB segments\n");
> +				break;
> +			}
> +
>  			cur_cpu_spec->mmu_features |= MMU_FTR_1T_SEGMENT;
>  			return 1;
>  		}
> 

Otherwise

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir

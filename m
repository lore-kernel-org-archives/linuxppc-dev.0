Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMPF351G8zDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:57:43 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1DBski0025070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 06:57:41 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28j5xv8cm2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 06:57:41 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 06:57:40 -0500
Subject: Re: [PATCH] powerpc/mm/slice: Update slice mask printing to use
 bitmap printing.
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Balbir Singh <bsingharora@gmail.com>
References: <1486984220-12213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 17:27:28 +0530
MIME-Version: 1.0
In-Reply-To: <1486984220-12213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <eeeea2ca-1760-eec3-dec2-edaeb5a01772@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 13 February 2017 04:40 PM, Aneesh Kumar K.V wrote:
> We now get output like below which is much better.
>
> [    0.935306]  good_mask low_slice: 4-5,9,11-13
> [    0.935360]  good_mask high_slice: 0-511
> [    0.935385]  mask low_slice: 3-6,8,10-12
> [    0.935397]  mask high_slice:
>
> Compared to
>
> [    0.953414]  good_mask:1111111111111111 - 1111111111111.........
>
> I also fixed an error with slice_dbg printing.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/mm/slice.c | 30 +++++++-----------------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index b3f45e413a60..0575897fdbe3 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -44,29 +44,13 @@ int _slice_debug = 1;
>
>   static void slice_print_mask(const char *label, struct slice_mask mask)
>   {
> -	char	*p, buf[SLICE_NUM_LOW + 3 + SLICE_NUM_HIGH + 1];
> -	int	i;
> -
>   	if (!_slice_debug)
>   		return;
> -	p = buf;
> -	for (i = 0; i < SLICE_NUM_LOW; i++)
> -		*(p++) = (mask.low_slices & (1 << i)) ? '1' : '0';
> -	*(p++) = ' ';
> -	*(p++) = '-';
> -	*(p++) = ' ';
> -	for (i = 0; i < SLICE_NUM_HIGH; i++) {
> -		if (test_bit(i, mask.high_slices))
> -			*(p++) = '1';
> -		else
> -			*(p++) = '0';
> -	}
> -	*(p++) = 0;
> -
> -	printk(KERN_DEBUG "%s:%s\n", label, buf);
> +	pr_devel("%s low_slice: %*pbl\n", label, (int)SLICE_NUM_LOW, &mask.low_slices);


This doesn't work as expected because low_slices is of type u16. I am 
fixing that to be u64.


> +	pr_devel("%s high_slice: %*pbl\n", label, (int)SLICE_NUM_HIGH, mask.high_slices);
>   }
>
> -#define slice_dbg(fmt...) do { if (_slice_debug) pr_debug(fmt); } while(0)
> +#define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
>
>   #else
>
> @@ -233,8 +217,8 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>   	}
>
>   	slice_dbg(" lsps=%lx, hsps=%lx\n",
> -		  mm->context.low_slices_psize,
> -		  mm->context.high_slices_psize);
> +		  (unsigned long)mm->context.low_slices_psize,
> +		  (unsigned long)mm->context.high_slices_psize);
>
>   	spin_unlock_irqrestore(&slice_convert_lock, flags);
>
> @@ -678,8 +662,8 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
>
>
>   	slice_dbg(" lsps=%lx, hsps=%lx\n",
> -		  mm->context.low_slices_psize,
> -		  mm->context.high_slices_psize);
> +		  (unsigned long)mm->context.low_slices_psize,
> +		  (unsigned long)mm->context.high_slices_psize);
>
>    bail:
>   	spin_unlock_irqrestore(&slice_convert_lock, flags);

-aneesh

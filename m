Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GMDx2MgYzF3MD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 02:12:00 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KG1sfN089930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:11:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mmdq4utft-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:11:58 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 20 Sep 2018 17:11:56 +0100
Date: Thu, 20 Sep 2018 09:11:47 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pkeys: Fix reading of ibm, processor-storage-keys
 property
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180920043858.28773-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20180920043858.28773-1-bauerman@linux.ibm.com>
Message-Id: <20180920161147.GE5809@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2018 at 01:38:58AM -0300, Thiago Jung Bauermann wrote:
> scan_pkey_feature() uses of_property_read_u32_array() to read the
> ibm,processor-storage-keys property and calls be32_to_cpu() on the
> value it gets. The problem is that of_property_read_u32_array() already
> returns the value converted to the CPU byte order.
> 
> The value of pkeys_total ends up more or less sane because there's a min()
> call in pkey_initialize() which reduces pkeys_total to 32. So in practice
> the kernel ignores the fact that the hypervisor reserved one key for
> itself (the device tree advertises 31 keys in my test VM).
> 
> This is wrong, but the effect in practice is that when a process tries to
> allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
> would indicate that there aren't any keys available

Thanks for the fix.

Reviewed-by: Ram Pai <linuxram@us.ibm.com>

> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/mm/pkeys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 333b1f80c435..b271b283c785 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -45,7 +45,7 @@ static void scan_pkey_feature(void)
>  	 * Since any pkey can be used for data or execute, we will just treat
>  	 * all keys as equal and track them as one entity.
>  	 */
> -	pkeys_total = be32_to_cpu(vals[0]);
> +	pkeys_total = vals[0];
>  	pkeys_devtree_defined = true;
>  }

-- 
Ram Pai

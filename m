Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DABB1A054E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 20:00:08 +1000 (EST)
Message-ID: <541AAD26.1040607@ozlabs.org>
Date: Thu, 18 Sep 2014 18:00:06 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH 01/15] powerpc/cell: Move spu_handle_mm_fault() out of
 cell platform
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1411028820-29933-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=windows-1252
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, imunsie@au.ibm.com,
 anton@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey & Ian,

> Currently spu_handle_mm_fault() is in the cell platform.
> 
> This code is generically useful for other non-cell co-processors on powerpc.
> 
> This patch moves this function out of the cell platform into arch/powerpc/mm so
> that others may use it.

Makes sense.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

> @@ -58,12 +56,12 @@ int spu_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
>  			goto out_unlock;
>  	}
>  
> -	is_write = dsisr & MFC_DSISR_ACCESS_PUT;
> +	is_write = dsisr & DSISR_ISSTORE;
>  	if (is_write) {
>  		if (!(vma->vm_flags & VM_WRITE))
>  			goto out_unlock;
>  	} else {
> -		if (dsisr & MFC_DSISR_ACCESS_DENIED)
> +		if (dsisr & DSISR_PROTFAULT)
>  			goto out_unlock;
>  		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
>  			goto out_unlock;

Consistent DSISR encodings? woot! :)

Cheers,


Jeremy

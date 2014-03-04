Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15F562C01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 02:45:24 +1100 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 4 Mar 2014 15:45:20 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14B5E219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 15:45:13 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s24Fj4Ua63176736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 15:45:04 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s24FjFYO019650
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 08:45:16 -0700
Message-ID: <5315F50B.5020505@linux.vnet.ibm.com>
Date: Tue, 04 Mar 2014 16:45:15 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org
Subject: Re: [PATCH] powerpc: Align p_dyn, p_rela and p_st symbols
References: <20140304083124.0c7c29a2@kryten>
In-Reply-To: <20140304083124.0c7c29a2@kryten>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/2014 22:31, Anton Blanchard wrote:
> 
> The 64bit relocation code places a few symbols in the text segment.
> These symbols are only 4 byte aligned where they need to be 8 byte
> aligned. Add an explicit alignment.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org

Fix the issue I was seeing when booting a LE kernel in a KVM guest on my
P7 box.

Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

> ---
> 
> diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
> index 1482327..d88736f 100644
> --- a/arch/powerpc/kernel/reloc_64.S
> +++ b/arch/powerpc/kernel/reloc_64.S
> @@ -81,6 +81,7 @@ _GLOBAL(relocate)
>  
>  6:	blr
>  
> +.balign 8
>  p_dyn:	.llong	__dynamic_start - 0b
>  p_rela:	.llong	__rela_dyn_start - 0b
>  p_st:	.llong	_stext - 0b
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

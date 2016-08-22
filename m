Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHnVS6CvWzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:56:16 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id vy10so7694659pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 01:56:16 -0700 (PDT)
Date: Mon, 22 Aug 2016 18:56:06 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/5] powerpc/64/kexec: NULL check "clear_all" in
 kexec_sequence
Message-ID: <20160822085606.GC24002@350D>
Reply-To: bsingharora@gmail.com
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471596759-3396-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2016 at 02:22:35PM +0530, Aneesh Kumar K.V wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> With Radix, it can be NULL even on !BOOKE these days so replace
> the ifdef with a NULL check which is cleaner anyway.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/misc_64.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index cb195157b318..7902f4b12d3f 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -659,7 +659,9 @@ _GLOBAL(kexec_sequence)
>  	li	r6,1
>  	stw	r6,kexec_flag-1b(5)
>  
> -#ifndef CONFIG_PPC_BOOK3E
> +	cmpdi	r27,0
> +	beq	1f
> +

Having a comment inline would help as well. I presume we are not going
to tear down the page tables for radix

Acked-by: Balbir Singh <bsingharora@gmail.com>
 
Balbir Singh

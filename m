Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wppW43ZTczDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 15:16:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc64/hw_breakpoints: Handle data breakpoints in
 radix mode
In-Reply-To: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 15:16:16 +1000
Message-ID: <87d1a4wlzz.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index ae418b85c17c..17ee701b8336 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1442,7 +1440,9 @@ do_hash_page:
>  
>  /* Here we have a page fault that hash_page can't handle. */
>  handle_page_fault:
> -11:	ld	r4,_DAR(r1)
> +	andis.  r0,r4,DSISR_DABRMATCH@h
> +	bne-    handle_dabr_fault

This broke hash. Please test hash! :)

I added:

@@ -1438,11 +1436,16 @@ do_hash_page:
 
        /* Error */
        blt-    13f
+
+       /* Reload DSISR into r4 for the DABR check below */
+       ld      r4,_DSISR(r1)
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:


cheers

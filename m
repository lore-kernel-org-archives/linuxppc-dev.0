Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQnjJ4Q3DzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 13:29:40 +1000 (AEST)
Message-ID: <1465529379.26682.7.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/nohash: Fix build break with 4K pages
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 10 Jun 2016 13:29:39 +1000
In-Reply-To: <1465523584.22191.127.camel@buserror.net>
References: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
 <1465523584.22191.127.camel@buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-09 at 20:53 -0500, Scott Wood wrote:
> On Wed, 2016-06-08 at 23:21 +1000, Michael Ellerman wrote:
> > Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
> > allocating fragments" renamed page_table_free() to pte_fragment_free().
> > One occurrence was mistyped as pte_fragment_fre().
> > 
> > This only breaks the nohash 4K page build, which is not the default or
> > enabled in any defconfig.
> 
> s/4K/64K/

Ugh, yep sorry, the ifdef confused me:

  #ifndef CONFIG_PPC_64K_PAGES
  ...
  #else /* if CONFIG_PPC_64K_PAGES */
  ...
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
  	pte_fragment_fre((unsigned long *)pte, 1);
  }
  ...
  #endif /* CONFIG_PPC_64K_PAGES */


Will update before committing.

cheers

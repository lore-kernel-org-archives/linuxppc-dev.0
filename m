Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4842DDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:21:12 +1100 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	lASLTCVA011812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:29:12 -0600
Date: Wed, 28 Nov 2007 13:28:16 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: kniht@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc: add hugepagesz boot-time parameter
Message-Id: <20071128132816.542fa4df.randy.dunlap@oracle.com>
In-Reply-To: <474CF68E.1040709@us.ibm.com>
References: <474CF68E.1040709@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 27 Nov 2007 23:03:10 -0600 Jon Tollefson wrote:

> This patch adds the hugepagesz boot-time parameter for ppc64 that lets 
> you pick the size for your huge pages.  The choices available are 64K 
> and 16M.  It defaults to 16M (previously the only choice) if nothing or 
> an invalid choice is specified.  Tested 64K huge pages with the 
> libhugetlbfs 1.2 release with its 'make func' and 'make stress' test 
> invocations.
> 
> This patch requires the patch posted by Mel Gorman that adds 
> HUGETLB_PAGE_SIZE_VARIABLE; "[PATCH] Fix boot problem with iSeries 
> lacking hugepage support" on 2007-11-15.
> 
> Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
> ---
> 
>  Documentation/kernel-parameters.txt |    1 
>  arch/powerpc/mm/hash_utils_64.c     |   11 +--------
>  arch/powerpc/mm/hugetlbpage.c       |   41 ++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/mmu-hash64.h    |    1 
>  mm/hugetlb.c                        |    1 
>  5 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 33121d6..2fc1fb8 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -685,6 +685,7 @@ and is between 256 and 4096 characters. It is defined in the file
>  			See Documentation/isdn/README.HiSax.
>  
>  	hugepages=	[HW,X86-32,IA-64] Maximal number of HugeTLB pages.
> +	hugepagesz=	[HW,IA-64,PPC] The size of the HugeTLB pages.

Any chance of spelling it as "hugepagesize" so that it's a little
less cryptic and more difficult to typo as "hugepages"?
(i.e., less confusion between them)


>  
>  	i8042.direct	[HW] Put keyboard port into non-translated mode
>  	i8042.dumbkbd	[HW] Pretend that controller can only read data from

Thanks.
---
~Randy

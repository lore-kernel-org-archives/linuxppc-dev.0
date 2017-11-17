Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydVZN1qfDzDqvS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 18:47:23 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAH7jRIW109752
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 02:47:21 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9s3161f8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 02:47:20 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Fri, 17 Nov 2017 07:47:19 -0000
Date: Fri, 17 Nov 2017 08:47:11 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, arbab@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mhocko@suse.com,
 linux-mm@kvack.org, linux-s390@vger.kernel.org, mgorman@techsingularity.net
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117014601.31606-1-pasha.tatashin@oracle.com>
Message-Id: <20171117074711.GA3308@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 08:46:01PM -0500, Pavel Tatashin wrote:
> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> as all the page initialization code is in common code.
> 
> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> does not really use hotplug memory functionality. So, we can remove this
> requirement as well.
> 
> This patch allows to use deferred struct page initialization on all
> platforms with memblock allocator.
> 
> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/powerpc/Kconfig | 1 -
>  arch/s390/Kconfig    | 1 -
>  arch/x86/Kconfig     | 1 -
>  mm/Kconfig           | 7 +------
>  4 files changed, 1 insertion(+), 9 deletions(-)

For s390 the s390 bit:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

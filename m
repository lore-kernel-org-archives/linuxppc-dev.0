Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82F121A090E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 21:36:08 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4DF471402B9
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 21:36:08 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 20:36:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C267E3578056
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 21:36:04 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9GAZhUu11468906
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 21:35:52 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9GAZVpP017004
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 21:35:31 +1100
Message-ID: <5620D2E2.7090401@linux.vnet.ibm.com>
Date: Fri, 16 Oct 2015 16:05:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] selfttest/powerpc: Add memory page migration tests
References: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/15/2015 09:16 PM, Anshuman Khandual wrote:
> This adds two tests for memory page migration. One for normal page
> migration which works for both 4K or 64K base page size kernel and
> the other one is for 16MB huge page migration which will work both
> 4K or 64K base page sized 16MB huge pages as and when we support
> huge page migration.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> - Works for normal page migration on both 64K and 4K base pages
> - Works for 16MB huge page migration (64K) on Aneesh's V2 PTE changes
> 
> +
> +int test_migration(unsigned long length)
> +{
> +	unsigned long failed;
> +	void *addr;
> +	int ret;
> +
> +	addr = mmap(MMAP_ADDR, length, MMAP_PROT, MMAP_FLAGS, -1, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap() failed");
> +		exit(-1);
> +	}

Will add a mlock() call here as well. Some times soft offline
fails while trying to move a huge chunk of memory on a system
because of swapping. With a mlock() in there the problem gets
resolved.

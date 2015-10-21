Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEF421A033A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 20:32:09 +1100 (AEDT)
Message-ID: <1445419928.3870.4.camel@ellerman.id.au>
Subject: Re: [PATCH] selfttest/powerpc: Add memory page migration tests
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Wed, 21 Oct 2015 20:32:08 +1100
In-Reply-To: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
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

On Thu, 2015-10-15 at 21:16 +0530, Anshuman Khandual wrote:

> This adds two tests for memory page migration. One for normal page
> migration which works for both 4K or 64K base page size kernel and
> the other one is for 16MB huge page migration which will work both
> 4K or 64K base page sized 16MB huge pages as and when we support
> huge page migration.

> diff --git a/tools/testing/selftests/powerpc/mm/run_mmtests b/tools/testing/selftests/powerpc/mm/run_mmtests
> new file mode 100755
> index 0000000..c537f4e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/run_mmtests
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +mnt=./huge
> +mkdir $mnt
> +mount -t hugetlbfs none $mnt
> +
> +echo 256 > /proc/sys/vm/nr_hugepages
> +echo "HugeTLB vs THP"
> +./hugetlb_vs_thp_test
> +
> +echo "Subpage Protection"
> +./subpage_prot
> +
> +echo "Test normal page migration"
> +./page-migration
> +
> +echo "Test huge page migration"
> +./hugepage-migration
> +
> +#cleanup
> +umount $mnt
> +rm -rf $mnt

I'm not a fan of this script at all.

It looks like you borrowed the logic from selftests/vm/run_vmtests, but
stripped out all the error handling.

Please write it so that it attempts to do the hugepage setup, but if it fails,
prints a warning and then tries to run the tests anyway. That way if a regular
user runs the test, but hugepages are already setup, some of the tests can
still run.

It also needs to print if any of the tests fail, and the whole test needs to
return an error if any test fails.

cheers

Return-Path: <gerald.schaefer@de.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66E081A0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 05:22:33 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Thu, 11 Feb 2016 18:22:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1E5481B08072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:22:41 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1BIMQsZ19464442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:22:27 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1BIMP9x021312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 11:22:26 -0700
Date: Thu, 11 Feb 2016 19:22:23 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, Martin Schwidefsky
 <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also on
 PowerPC and ARM)
Message-ID: <20160211192223.4b517057@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
review of the THP rework patches, which cannot be bisected, revealed
commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
(and also similar commits for other archs).

This commit removes the THP splitting bit and also the architecture
implementation of pmdp_splitting_flush(), which took care of the IPI for
fast_gup serialization. The commit message says

    pmdp_splitting_flush() is not needed too: on splitting PMD we will do
    pmdp_clear_flush() + set_pte_at().  pmdp_clear_flush() will do IPI as
    needed for fast_gup

The assumption that a TLB flush will also produce an IPI is wrong on s390,
and maybe also on other architectures, and I thought that this was actually
the main reason for having an arch-specific pmdp_splitting_flush().

At least PowerPC and ARM also had an individual implementation of
pmdp_splitting_flush() that used kick_all_cpus_sync() instead of a TLB
flush to send the IPI, and those were also removed. Putting the arch
maintainers and mailing lists on cc to verify.

On s390 this will break the IPI serialization against fast_gup, which
would certainly explain the random kernel crashes, please revert or fix
the pmdp_splitting_flush() removal.

Regards,
Gerald

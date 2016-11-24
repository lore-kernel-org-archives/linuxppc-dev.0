Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPSKw0PVTzDw5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:23:48 +1100 (AEDT)
Date: Wed, 23 Nov 2016 23:23:30 -0600
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20161124052330.GA17212@home.buserror.net>
References: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
Subject: Re: [v3,2/3] powerpc: get hugetlbpage handling more generic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2016 at 10:11:54AM +0200, Christophe Leroy wrote:
> Today there are two implementations of hugetlbpages which are managed
> by exclusive #ifdefs:
> * FSL_BOOKE: several directory entries points to the same single hugepage
> * BOOK3S: one upper level directory entry points to a table of hugepages
> 
> In preparation of implementation of hugepage support on the 8xx, we
> need a mix of the two above solutions, because the 8xx needs both cases
> depending on the size of pages:
> * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
> that 2 PGD entries will be necessary to cover an 8M hugepage while a
> single PGD entry will cover 8x 512k hugepages.
> * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
> that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
> hugepages will be covers by one PGD entry.
> 
> This patch:
> * removes #ifdefs in favor of if/else based on the range sizes
> * merges the two huge_pte_alloc() functions as they are pretty similar
> * merges the two hugetlbpage_init() functions as they are pretty similar
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

With this patch on e6500, running the hugetlb testsuite results in the
system hanging in a storm of OOM killer invocations (I'll try to debug
more deeply later).  This patch also changes the default hugepage size on
FSL book3e from 4M to 16M.

-Scott

Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tX8bQ0JHlzDvkP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 13:58:42 +1100 (AEDT)
Message-ID: <1480906702.32531.7.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Dec 2016 20:58:22 -0600
In-Reply-To: <aa9a2f8a-a480-0cc9-adf6-4017c771fb46@c-s.fr>
References: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
 <20161124052330.GA17212@home.buserror.net>
 <aa9a2f8a-a480-0cc9-adf6-4017c771fb46@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v3,2/3] powerpc: get hugetlbpage handling more generic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-25 at 09:14 +0100, Christophe LEROY wrote:
> 
> Le 24/11/2016 à 06:23, Scott Wood a écrit :
> > 
> > On Wed, Sep 21, 2016 at 10:11:54AM +0200, Christophe Leroy wrote:
> > > 
> > > Today there are two implementations of hugetlbpages which are managed
> > > by exclusive #ifdefs:
> > > * FSL_BOOKE: several directory entries points to the same single
> > > hugepage
> > > * BOOK3S: one upper level directory entry points to a table of hugepages
> > > 
> > > In preparation of implementation of hugepage support on the 8xx, we
> > > need a mix of the two above solutions, because the 8xx needs both cases
> > > depending on the size of pages:
> > > * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
> > > that 2 PGD entries will be necessary to cover an 8M hugepage while a
> > > single PGD entry will cover 8x 512k hugepages.
> > > * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
> > > that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
> > > hugepages will be covers by one PGD entry.
> > > 
> > > This patch:
> > > * removes #ifdefs in favor of if/else based on the range sizes
> > > * merges the two huge_pte_alloc() functions as they are pretty similar
> > > * merges the two hugetlbpage_init() functions as they are pretty similar
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > With this patch on e6500, running the hugetlb testsuite results in the
> > system hanging in a storm of OOM killer invocations (I'll try to debug
> > more deeply later).  This patch also changes the default hugepage size on
> > FSL book3e from 4M to 16M.
> > 
> Regarding the default hugepage size, it is a result of the merge of the 
> two hugetlbpage_init().
> Should I add an ifdef to get 4M on FSL book3e by default ?
> What's the reason for selecting different hugepage sizes depending on 
> the CPU ? 

I'm not sure what the original reason was, but a change in defaults could
disturb existing users.

> I thought default size was selected based on what was existing.

...by code that doesn't expect 4M to ever exist.  Both 4M and 16M (and a bunch
of other sizes) are available on FSL book3e.

What is the reason for preferring 16M over 1M, but preferring 1M over 2M?
 Seems arbitrary.

If we want to preserve the exsiting behavior without an ifdef, we could put a
check for 4M before the other sizes, with a comment explaining why we're
making the selection look even more arbitrary.  Or we could try to figure out
what size actually makes a better default.

> What testsuite do you run exactly ?

The one that comes with libhugetlbfs (not a particularly recent version, but
not sure exactly how old).

-Scott

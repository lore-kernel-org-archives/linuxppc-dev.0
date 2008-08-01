Return-Path: <Joerg.Roedel@amd.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 44D21DDFB7
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 17:03:41 +1000 (EST)
Date: Fri, 1 Aug 2008 09:03:28 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] Revert "Merge branch 'x86/iommu' of
	git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
	into for-linus"
Message-ID: <20080801070328.GA26894@amd.com>
References: <20080801094323.9601d87b.sfr@canb.auug.org.au>
	<20080801085106E.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20080801085106E.fujita.tomonori@lab.ntt.co.jp>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
	jbarnes@virtuousgeek.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 08:51:23AM +0900, FUJITA Tomonori wrote:
> On Fri, 1 Aug 2008 09:43:23 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > This reverts commit 29111f579f4f3f2a07385f931854ab0527ae7ea5.
> > 
> > This undoes the hasty addition of a global version of iommu_num_pages()
> > that broke both the powerpc and sparc builds.  This function can be
> > revisited later.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/x86/kernel/amd_iommu.c   |   13 ++++++++-----
> >  arch/x86/kernel/pci-gart_64.c |   11 +++++++----
> >  include/linux/iommu-helper.h  |    1 -
> >  lib/iommu-helper.c            |    8 --------
> >  4 files changed, 15 insertions(+), 18 deletions(-)
> > 
> > This patch comes from
> > git revert -m 1 29111f579f4f3f2a07385f931854ab0527ae7ea5
> > 
> > I have test built powerpc ppc64_defconfig and sparc64 defconfig.  The only
> > references to iommu_num_pages() after this is applied are in the powerpc
> > and sparc code.
> > 
> > Linus, please apply.  This is impacting on both powerpc and sparc
> > development and even the author of the patches said that those patches
> > were not urgent.
> 
> Ingo has a patch to fix this problem in the x86 tree:
> 
> http://marc.info/?l=linux-kernel&m=121754062325903&w=2

FUJITA,

can you send your fix directly to Linus again please? Andrew mentioned
that the x86 maintainers are on vacation. That may be the reason that
your fix is not yet upstream.

Joerg

-- 
           |           AMD Saxony Limited Liability Company & Co. KG
 Operating |         Wilschdorfer Landstr. 101, 01109 Dresden, Germany
 System    |                  Register Court Dresden: HRA 4896
 Research  |              General Partner authorized to represent:
 Center    |             AMD Saxony LLC (Wilmington, Delaware, US)
           | General Manager of AMD Saxony LLC: Dr. Hans-R. Deppe, Thomas McCoy

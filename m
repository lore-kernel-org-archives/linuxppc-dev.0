Return-Path: <jglisse@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHYlm10qwzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:08:19 +1100 (AEDT)
Date: Wed, 18 Oct 2017 23:08:12 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Optimize mmu_notifier->invalidate_range callback
Message-ID: <20171019030812.GB5246@redhat.com>
References: <20171017031003.7481-1-jglisse@redhat.com>
 <20171019134319.1b856091@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171019134319.1b856091@MiWiFi-R3-srv>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 01:43:19PM +1100, Balbir Singh wrote:
> On Mon, 16 Oct 2017 23:10:01 -0400
> jglisse@redhat.com wrote:
> 
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > (Andrew you already have v1 in your queue of patch 1, patch 2 is new,
> >  i think you can drop it patch 1 v1 for v2, v2 is bit more conservative
> >  and i fixed typos)
> > 
> > All this only affect user of invalidate_range callback (at this time
> > CAPI arch/powerpc/platforms/powernv/npu-dma.c, IOMMU ATS/PASID in
> > drivers/iommu/amd_iommu_v2.c|intel-svm.c)
> > 
> > This patchset remove useless double call to mmu_notifier->invalidate_range
> > callback wherever it is safe to do so. The first patch just remove useless
> > call
> 
> As in an extra call? Where does that come from?

Before this patch you had the following pattern:
  mmu_notifier_invalidate_range_start();
  take_page_table_lock()
  ...
  update_page_table()
  mmu_notifier_invalidate_range()
  ...
  drop_page_table_lock()
  mmu_notifier_invalidate_range_end();

It happens that mmu_notifier_invalidate_range_end() also make an
unconditional call to mmu_notifier_invalidate_range() so in the
above scenario you had 2 calls to mmu_notifier_invalidate_range()

Obviously one of the 2 call is useless. In some case you can drop
the first call (under the page table lock) this is what patch 1
does.

In other cases you can drop the second call that happen inside
mmu_notifier_invalidate_range_end() that is what patch 2 does.

Hence why i am referring to useless double call. I have added
more documentation to explain all this in the code and also under
Documentation/vm/mmu_notifier.txt


> 
> > and add documentation explaining why it is safe to do so. The second
> > patch go further by introducing mmu_notifier_invalidate_range_only_end()
> > which skip callback to invalidate_range this can be done when clearing a
> > pte, pmd or pud with notification which call invalidate_range right after
> > clearing under the page table lock.
> >
> 
> Balbir Singh.
> 

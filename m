Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 292E22C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 07:43:41 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 2 Oct 2012 17:43:37 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q92LhYNn145022
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2012 17:43:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q92LhYqd010505
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2012 18:43:34 -0300
Date: Tue, 2 Oct 2012 14:43:27 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [REGRESSION] nfsd crashing with 3.6.0-rc7 on PowerPC
Message-ID: <20121002214327.GA29218@linux.vnet.ibm.com>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
 <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
 <DC545CD9-8745-47DD-B13B-3385C0EB5B27@suse.de>
 <20120928151043.GA19102@fieldses.org>
 <2A52FC96-148C-4F7A-9950-E152E0C6698D@suse.de>
 <1349139509.3847.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349139509.3847.2.camel@pasglop>
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 LKML List <linux-kernel@vger.kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, anton@samba.org,
 skinsbursky@parallels.com, bfields@redhat.com,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 02.10.2012 [10:58:29 +1000], Benjamin Herrenschmidt wrote:
> On Mon, 2012-10-01 at 16:03 +0200, Alexander Graf wrote:
> > Phew. Here we go :). It looks to be more of a PPC specific problem
> > than it appeared as at first:
> 
> Ok, so I suspect the problem is the pushing down of the locks which
> breaks with iommu backends that have a separate flush callback. In
> that case, the flush moves out of the allocator lock.
> 
> Now we do call flush before we return, still, but it becomes racy
> I suspect, but somebody needs to give it a closer look. I'm hoping
> Anton or Nish will later today.

Started looking into this. If your suspicion were accurate, wouldn't the
bisection have stopped at 0e4bc95d87394364f408627067238453830bdbf3
("powerpc/iommu: Reduce spinlock coverage in iommu_alloc and
iommu_free")?

Alex, the error is reproducible, right? Does it go away by reverting
that commit against mainline? Just trying to narrow down my focus.

Thanks,
Nish

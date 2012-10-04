Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 228AB2C0368
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 20:55:02 +1000 (EST)
Subject: Re: [PATCH] powerpc/iommu: Fix multiple issues with IOMMU pools code
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20121004145710.2cf95dcd@kryten>
Date: Thu, 4 Oct 2012 12:54:45 +0200
Message-Id: <96119AB6-3DCC-460E-BD40-98DC3BB8D4B4@suse.de>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
 <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
 <DC545CD9-8745-47DD-B13B-3385C0EB5B27@suse.de>
 <20120928151043.GA19102@fieldses.org>
 <2A52FC96-148C-4F7A-9950-E152E0C6698D@suse.de>
 <1349139509.3847.2.camel@pasglop> <20121002214327.GA29218@linux.vnet.ibm.com>
 <9257E705-4EF9-4347-945C-B4A7582C427F@suse.de>
 <20121002221736.GB29218@linux.vnet.ibm.com>
 <E141CA01-F58C-47B1-8ED5-A314D1DEC968@suse.de>
 <20121004145710.2cf95dcd@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML List <linux-kernel@vger.kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, skinsbursky@parallels.com,
 bfields@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On 04.10.2012, at 06:57, Anton Blanchard wrote:

> 
> Hi Alex,
> 
> Looks to be a preempt issue with the iommu pools code. I did find a
> couple more bugs along the way too.
> 
> Anton
> --
> 
> There are a number of issues in the recent IOMMU pools code:
> 
> - On a preempt kernel we might switch CPUs in the middle of building
>  a scatter gather list. When this happens the handle hint passed in
>  no longer falls within the local CPU's pool. Check for this and
>  fall back to the pool hint.
> 
> - We were missing a spin_unlock/spin_lock in one spot where we
>  switch pools.
> 
> - We need to provide locking around dart_tlb_invalidate_all and
>  dart_tlb_invalidate_one now that the global lock is gone.
> 
> Reported-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> There is still an issue with the lazy u3 flushing, but I wanted
> to get this out for testing.

Yup. It fixes the nfs problem on my U4 based machine.

Tested-by: Alexander Graf <agraf@suse.de>

Alex

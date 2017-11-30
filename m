Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynZhl5rKvzDrpy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 22:20:55 +1100 (AEDT)
Subject: Re: BSOD with [PATCH 00/13] mmu_notifier kill invalidate_page callback
To: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Dan Williams <dan.j.williams@intel.com>, Sudeep Dutt
 <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Dimitri Sivanich <sivanich@sgi.com>, Jack Steiner <steiner@sgi.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20170829235447.10050-1-jglisse@redhat.com>
 <20171130093320.66cxaoj45g2ttzoh@nora.maurer-it.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39823aee-4918-f87c-8342-89eff622ee43@redhat.com>
Date: Thu, 30 Nov 2017 12:20:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171130093320.66cxaoj45g2ttzoh@nora.maurer-it.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/11/2017 10:33, Fabian Grünbichler wrote:
> 
> It was reverted in 785373b4c38719f4af6775845df6be1dfaea120f after which
> the symptoms disappeared until this series was merged, which contains
> 
> 369ea8242c0fb5239b4ddf0dc568f694bd244de4 mm/rmap: update to new mmu_notifier semantic v2
> 
> We haven't bisected the individual commits of the series yet, but the
> commit immediately preceding its merge exhibits no problems, while
> everything after does. It is not known whether the bug is actually in
> the series itself, or whether increasing the likelihood of triggering it
> is just a side-effect. There is a similar report[2] concerning an
> upgrade from 4.12.12 to 4.12.13, which does not contain this series in
> any form AFAICT but might be worth another look as well.

I know of one issue in this series (invalidate_page was removed from KVM
without reimplementing it as invalidate_range).  I'll try to prioritize
the fix, but I don't think I can do it before Monday.

Thanks,

Paolo

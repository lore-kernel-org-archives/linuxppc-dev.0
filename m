Return-Path: <kirill@shutemov.name>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F1571A1A3C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 01:45:38 +1000 (AEST)
Received: by wibxm9 with SMTP id xm9so108934612wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 08:45:33 -0700 (PDT)
Date: Wed, 22 Jul 2015 18:45:29 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Chris Metcalf <cmetcalf@ezchip.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V4 5/6] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-ID: <20150722154529.GA9107@node.dhcp.inet.fi>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
 <20150722112558.GC8630@node.dhcp.inet.fi>
 <20150722143220.GB3203@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722143220.GB3203@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 22, 2015 at 10:32:20AM -0400, Eric B Munson wrote:
> On Wed, 22 Jul 2015, Kirill A. Shutemov wrote:
> 
> > On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> > > The cost of faulting in all memory to be locked can be very high when
> > > working with large mappings.  If only portions of the mapping will be
> > > used this can incur a high penalty for locking.
> > > 
> > > Now that we have the new VMA flag for the locked but not present state,
> > > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
> > 
> > What is advantage over mmap() + mlock(MLOCK_ONFAULT)?
> 
> There isn't one, it was added to maintain parity with the
> mlock(MLOCK_LOCK) -> mmap(MAP_LOCKED) set.  I think not having will lead
> to confusion because we have MAP_LOCKED so why don't we support
> LOCKONFAULT from mmap as well.

I don't think it's ia good idea to spend bits in flags unless we have a
reason for that.

BTW, you have typo on sparc: s/0x8000/0x80000/.


-- 
 Kirill A. Shutemov

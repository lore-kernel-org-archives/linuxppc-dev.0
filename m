Return-Path: <kirill@shutemov.name>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3D6A1A1A7A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 21:26:07 +1000 (AEST)
Received: by wicgb10 with SMTP id gb10so93614194wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 04:26:01 -0700 (PDT)
Date: Wed, 22 Jul 2015 14:25:58 +0300
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
Message-ID: <20150722112558.GC8630@node.dhcp.inet.fi>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437508781-28655-6-git-send-email-emunson@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
> 
> Now that we have the new VMA flag for the locked but not present state,
> expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.

What is advantage over mmap() + mlock(MLOCK_ONFAULT)?

-- 
 Kirill A. Shutemov

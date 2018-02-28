Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrsxB2lLyzF1KC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 21:58:18 +1100 (AEDT)
Received: by mail-wm0-x22a.google.com with SMTP id t6so4183916wmt.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 02:58:18 -0800 (PST)
Date: Wed, 28 Feb 2018 13:58:04 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/vm: Update max va test to check for high
 address return.
Message-ID: <20180228105804.2uhjcfxu6zebkixh@node.shutemov.name>
References: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 09:28:30AM +0530, Aneesh Kumar K.V wrote:
> mmap(-1,..) is expected to search from max supported VA top down. It should find
> an address above ADDR_SWITCH_HINT. Explicitly check for this.

Hm. I don't think this correct. -1 means the application supports any
address, not restricted to 47-bit address space. It doesn't mean the
application *require* the address to be above 47-bit.

At least on x86, -1 just shift upper boundary of address range where we
can look for unmapped area.

-- 
 Kirill A. Shutemov

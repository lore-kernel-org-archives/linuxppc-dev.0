Return-Path: <kirill@shutemov.name>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9A4B1A1A66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 16:43:07 +1000 (AEST)
Received: by wicmv11 with SMTP id mv11so125728873wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:43:03 -0700 (PDT)
Date: Mon, 27 Jul 2015 09:43:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5 2/7] mm: mlock: Add new mlock system call
Message-ID: <20150727064300.GB11657@node.dhcp.inet.fi>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-3-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437773325-8623-3-git-send-email-emunson@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 24, 2015 at 05:28:40PM -0400, Eric B Munson wrote:
> With the refactored mlock code, introduce a new system call for mlock.
> The new call will allow the user to specify what lock states are being
> added.  mlock2 is trivial at the moment, but a follow on patch will add
> a new mlock state making it useful.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: linux-cris-kernel@axis.com
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-am33-list@redhat.com
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
> Changes from V4:
> * Drop all architectures except x86[_64] from this patch, MIPS is added
>   later in the series.  All others will be left to their maintainers.
> 
> Changes from V3:
> * Do a (hopefully) complete job of adding the new system calls
>  arch/alpha/include/uapi/asm/mman.h     | 2 ++
>  arch/mips/include/uapi/asm/mman.h      | 5 +++++
>  arch/parisc/include/uapi/asm/mman.h    | 2 ++
>  arch/powerpc/include/uapi/asm/mman.h   | 2 ++
>  arch/sparc/include/uapi/asm/mman.h     | 2 ++
>  arch/tile/include/uapi/asm/mman.h      | 5 +++++
>  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  arch/xtensa/include/uapi/asm/mman.h    | 5 +++++

Define MLOCK_LOCKED in include/uapi/asm-generic/mman-common.h.
This way you can drop changes in powerpc, sparc and tile.

Otherwise looks good.

-- 
 Kirill A. Shutemov

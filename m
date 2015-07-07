Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 263321A113D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 07:16:16 +1000 (AEST)
Date: Tue, 7 Jul 2015 14:16:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Michal Hocko <mhocko@suse.cz>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Allow user to request memory to be locked on
 page fault
Message-Id: <20150707141613.f945c98279dcb71c9743d5f2@linux-foundation.org>
In-Reply-To: <1436288623-13007-1-git-send-email-emunson@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  7 Jul 2015 13:03:38 -0400 Eric B Munson <emunson@akamai.com> wrote:

> mlock() allows a user to control page out of program memory, but this
> comes at the cost of faulting in the entire mapping when it is
> allocated.  For large mappings where the entire area is not necessary
> this is not ideal.  Instead of forcing all locked pages to be present
> when they are allocated, this set creates a middle ground.  Pages are
> marked to be placed on the unevictable LRU (locked) when they are first
> used, but they are not faulted in by the mlock call.
> 
> This series introduces a new mlock() system call that takes a flags
> argument along with the start address and size.  This flags argument
> gives the caller the ability to request memory be locked in the
> traditional way, or to be locked after the page is faulted in.  New
> calls are added for munlock() and munlockall() which give the called a
> way to specify which flags are supposed to be cleared.  A new MCL flag
> is added to mirror the lock on fault behavior from mlock() in
> mlockall().  Finally, a flag for mmap() is added that allows a user to
> specify that the covered are should not be paged out, but only after the
> memory has been used the first time.

Thanks for sticking with this.  Adding new syscalls is a bit of a
hassle but I do think we end up with a better interface - the existing
mlock/munlock/mlockall interfaces just aren't appropriate for these
things.

I don't know whether these syscalls should be documented via new
manpages, or if we should instead add them to the existing
mlock/munlock/mlockall manpages.  Michael, could you please advise?

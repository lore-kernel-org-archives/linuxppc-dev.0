Return-Path: <jack@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syw523nyQzDt1s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 23:54:30 +1100 (AEDT)
Date: Tue, 18 Oct 2016 14:54:25 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Rik van Riel <riel@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 04/10] mm: replace get_user_pages_locked() write/force
 parameters with gup_flags
Message-ID: <20161018125425.GD29967@quack2.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-5-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013002020.3062-5-lstoakes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 13-10-16 01:20:14, Lorenzo Stoakes wrote:
> This patch removes the write and force parameters from get_user_pages_locked()
> and replaces them with a gup_flags parameter to make the use of FOLL_FORCE
> explicit in callers as use of this flag can result in surprising behaviour (and
> hence bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm.h |  2 +-
>  mm/frame_vector.c  |  8 +++++++-
>  mm/gup.c           | 12 +++---------
>  mm/nommu.c         |  5 ++++-
>  4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6adc4bc..27ab538 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1282,7 +1282,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  			    int write, int force, struct page **pages,
>  			    struct vm_area_struct **vmas);
>  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -		    int write, int force, struct page **pages, int *locked);
> +		    unsigned int gup_flags, struct page **pages, int *locked);

Hum, the prototype is inconsistent with e.g. __get_user_pages_unlocked()
where gup_flags come after **pages argument. Actually it makes more sense
to have it before **pages so that input arguments come first and output
arguments second but I don't care that much. But it definitely should be
consistent...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szR0h53HrzDt4P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 20:07:32 +1100 (AEDT)
Received: by mail-wm0-f68.google.com with SMTP id f193so2967152wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:07:32 -0700 (PDT)
Date: Wed, 19 Oct 2016 11:07:28 +0200
From: Michal Hocko <mhocko@kernel.org>
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
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
Message-ID: <20161019090727.GE7517@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
 <20161019085815.GA22239@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019085815.GA22239@lucifer>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 19-10-16 09:58:15, Lorenzo Stoakes wrote:
> On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> > I am wondering whether we can go further. E.g. it is not really clear to
> > me whether we need an explicit FOLL_REMOTE when we can in fact check
> > mm != current->mm and imply that. Maybe there are some contexts which
> > wouldn't work, I haven't checked.
> 
> This flag is set even when /proc/self/mem is used. I've not looked deeply into
> this flag but perhaps accessing your own memory this way can be considered
> 'remote' since you're not accessing it directly. On the other hand, perhaps this
> is just mistaken in this case?

My understanding of the flag is quite limited as well. All I know it is
related to protection keys and it is needed to bypass protection check.
See arch_vma_access_permitted. See also 1b2ee1266ea6 ("mm/core: Do not
enforce PKEY permissions on remote mm access").

-- 
Michal Hocko
SUSE Labs

Return-Path: <dave.hansen@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szf1W48m4zDt36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 04:23:58 +1100 (AEDT)
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
To: Michal Hocko <mhocko@kernel.org>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz> <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz> <5807A427.7010200@linux.intel.com>
 <20161019170127.GN24393@dhcp22.suse.cz>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 Hugh Dickins <hughd@google.com>, Rik van Riel <riel@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 adi-buildroot-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
 linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@linux-mips.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <5807AC2B.4090208@linux.intel.com>
Date: Wed, 19 Oct 2016 10:23:55 -0700
MIME-Version: 1.0
In-Reply-To: <20161019170127.GN24393@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2016 10:01 AM, Michal Hocko wrote:
> The question I had earlier was whether this has to be an explicit FOLL
> flag used by g-u-p users or we can just use it internally when mm !=
> current->mm

The reason I chose not to do that was that deferred work gets run under
a basically random 'current'.  If we just use 'mm != current->mm', then
the deferred work will sometimes have pkeys enforced and sometimes not,
basically randomly.

We want to be consistent with whether they are enforced or not, so we
explicitly indicate that by calling the remote variant vs. plain.

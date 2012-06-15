Return-Path: <hannes@cmpxchg.org>
Received: from zene.cmpxchg.org (zene.cmpxchg.org
 [IPv6:2a01:238:4224:fa00:ca1f:9ef3:caee:a2bd])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0B73B70D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 02:17:21 +1000 (EST)
Date: Fri, 15 Jun 2012 16:58:09 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Wanpeng Li <liwp.linux@gmail.com>
Subject: Re: [PATCH 6/7][TRIVIAL][resend] mm: cleanup page reclaim comment
 error
Message-ID: <20120615145809.GA27816@cmpxchg.org>
References: <1339766387-7740-1-git-send-email-liwp.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339766387-7740-1-git-send-email-liwp.linux@gmail.com>
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
 David Rientjes <rientjes@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Bjorn Helgaas <bhelgaas@google.com>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Michal Hocko <mhocko@suse.cz>, trivial@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Minchan Kim <minchan@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Jason Wessel <jason.wessel@windriver.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 15, 2012 at 09:19:45PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <liwp@linux.vnet.ibm.com>
> 
> Since there are five lists in LRU cache, the array nr in get_scan_count
> should be:
> 
> nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
> nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
> 
> Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>
> Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Rik van Riel <riel@redhat.com>
> 
> ---
>  mm/vmscan.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eeb3bc9..ed823df 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1567,7 +1567,8 @@ static int vmscan_swappiness(struct scan_control *sc)
>   * by looking at the fraction of the pages scanned we did rotate back
>   * onto the active list instead of evict.
>   *
> - * nr[0] = anon pages to scan; nr[1] = file pages to scan
> + * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
> + * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
>   */

Does including this in the comment have any merit in the first place?
We never access nr[0] or nr[1] etc. anywhere with magic numbers.  It's
a local function with one callsite, the passed array is declared and
accessed exclusively by what is defined in enum lru_list, where is the
point in repeating the enum items?.  I'd rather the next change to
this comment would be its removal.

Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fDT71gZlzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:16:09 +1000 (AEST)
Date: Mon, 30 Jul 2018 11:16:05 +0200
From: Michal Hocko <mhocko@kernel.org>
To: John Allen <jallen@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com,
 mgorman@suse.de, nfont@linux.vnet.ibm.com
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180730091605.GF24267@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 27-07-18 12:32:59, John Allen wrote:
> On Wed, Jul 25, 2018 at 10:03:36PM +0200, Michal Hocko wrote:
> > On Wed 25-07-18 13:11:15, John Allen wrote:
> > [...]
> > > Does a failure in do_migrate_range indicate that the range is unmigratable
> > > and the loop in __offline_pages should terminate and goto failed_removal? Or
> > > should we allow a certain number of retrys before we
> > > give up on migrating the range?
> > 
> > Unfortunatelly not. Migration code doesn't tell a difference between
> > ephemeral and permanent failures. We are relying on
> > start_isolate_page_range to tell us this. So the question is, what kind
> > of page is not migratable and for what reason.
> > 
> > Are you able to add some debugging to give us more information. The
> > current debugging code in the hotplug/migration sucks...
> 
> After reproducing the problem a couple times, it seems that it can occur for
> different types of pages. Running page-types on the offending page over two
> separate instances produced the following:
> 
> # tools/vm/page-types -a 307968-308224
>             flags	page-count       MB  symbolic-flags			long-symbolic-flags
> 0x0000000000000400	         1        0  __________B________________________________	buddy
> 	     total	         1        0

Huh! How come a buddy page has non zero reference count.
> 
> And the following on a separate run:
> 
> # tools/vm/page-types -a 313088-313344
>             flags	page-count       MB  symbolic-flags			long-symbolic-flags
> 0x000000000000006c	         1        0  __RU_lA____________________________________	referenced,uptodate,lru,active
>             total	         1        0

Hmm, what is the expected page count in this case? Seeing 1 doesn't look
particularly wrong.
-- 
Michal Hocko
SUSE Labs

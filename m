Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bR4Z2xYJzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 06:03:40 +1000 (AEST)
Date: Wed, 25 Jul 2018 22:03:36 +0200
From: Michal Hocko <mhocko@kernel.org>
To: John Allen <jallen@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 25-07-18 13:11:15, John Allen wrote:
[...]
> Does a failure in do_migrate_range indicate that the range is unmigratable
> and the loop in __offline_pages should terminate and goto failed_removal? Or
> should we allow a certain number of retrys before we
> give up on migrating the range?

Unfortunatelly not. Migration code doesn't tell a difference between
ephemeral and permanent failures. We are relying on
start_isolate_page_range to tell us this. So the question is, what kind
of page is not migratable and for what reason.

Are you able to add some debugging to give us more information. The
current debugging code in the hotplug/migration sucks...
-- 
Michal Hocko
SUSE Labs

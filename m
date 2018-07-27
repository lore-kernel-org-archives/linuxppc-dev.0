Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cbdt6GqgzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 03:33:06 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RHQAnX101001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 13:33:04 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg7sn8765-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 13:33:04 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Fri, 27 Jul 2018 11:33:03 -0600
Date: Fri, 27 Jul 2018 12:32:59 -0500
From: John Allen <jallen@linux.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com,
 mgorman@suse.de, nfont@linux.vnet.ibm.com
Subject: Re: Infinite looping observed in __offline_pages
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
Message-Id: <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2018 at 10:03:36PM +0200, Michal Hocko wrote:
>On Wed 25-07-18 13:11:15, John Allen wrote:
>[...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
>Unfortunatelly not. Migration code doesn't tell a difference between
>ephemeral and permanent failures. We are relying on
>start_isolate_page_range to tell us this. So the question is, what kind
>of page is not migratable and for what reason.
>
>Are you able to add some debugging to give us more information. The
>current debugging code in the hotplug/migration sucks...

After reproducing the problem a couple times, it seems that it can occur 
for different types of pages. Running page-types on the offending page 
over two separate instances produced the following:

# tools/vm/page-types -a 307968-308224
             flags	page-count       MB  symbolic-flags			long-symbolic-flags
0x0000000000000400	         1        0  __________B________________________________	buddy
	     total	         1        0

And the following on a separate run:

# tools/vm/page-types -a 313088-313344
             flags	page-count       MB  symbolic-flags			long-symbolic-flags
0x000000000000006c	         1        0  __RU_lA____________________________________	referenced,uptodate,lru,active
             total	         1        0

The source of the failure in migrate_pages actually doesn't seem to be 
that we're hitting the case of the permanent failure, but instead the 
-EAGAIN case. I traced the EAGAIN return back to 
migrate_page_move_mapping which I've seen return EAGAIN in two places:

mm/migrate.c:453
	if (!mapping) {
		/* Anonymous page without mapping */
		if (page_count(page) != expected_count)
                        return -EAGAIN;

mm/migrate.c:476
	if (page_count(page) != expected_count ||
                radix_tree_deref_slot_protected(pslot,
                                        &mapping->i_pages.xa_lock) != page) {
                xa_unlock_irq(&mapping->i_pages);
                return -EAGAIN;
	}

So it seems in each case, the actual reference count for the page is not 
what it is expected to be.

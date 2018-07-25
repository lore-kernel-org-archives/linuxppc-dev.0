Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bNZz3fVhzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 04:11:23 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PI4O7F114542
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 14:11:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2keu8fr2fm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 14:11:20 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Wed, 25 Jul 2018 12:11:20 -0600
Date: Wed, 25 Jul 2018 13:11:15 -0500
From: John Allen <jallen@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: jallen@linux.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
 n-horiguchi@ah.jp.nec.com, mgorman@suse.de, mhocko@suse.cz
Subject: Infinite looping observed in __offline_pages
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Under heavy stress and constant memory hot add/remove, I have observed 
the following loop to occasionally loop infinitely:

mm/memory_hotplug.c:__offline_pages

repeat:
        /* start memory hot removal */
        ret = -EINTR;
        if (signal_pending(current))
                goto failed_removal;

        cond_resched();
        lru_add_drain_all();
        drain_all_pages(zone);

        pfn = scan_movable_pages(start_pfn, end_pfn);
        if (pfn) { /* We have movable pages */
                ret = do_migrate_range(pfn, end_pfn);
                goto repeat;
        }

What appears to be happening in this case is that do_migrate_range 
returns a failure code which is being ignored. The failure is stemming 
from migrate_pages returning "1" which I'm guessing is the result of us 
hitting the following case:

mm/migrate.c: migrate_pages

	default:
		/*
		 * Permanent failure (-EBUSY, -ENOSYS, etc.):
		 * unlike -EAGAIN case, the failed page is
		 * removed from migration page list and not
		 * retried in the next outer loop.
		 */
		nr_failed++;
		break;
	}

Does a failure in do_migrate_range indicate that the range is 
unmigratable and the loop in __offline_pages should terminate and goto 
failed_removal? Or should we allow a certain number of retrys before we
give up on migrating the range?

This issue was observed on a ppc64le lpar on a 4.18-rc6 kernel.

-John

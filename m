Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E33C22C032C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 20:07:04 +1100 (EST)
Date: Tue, 18 Feb 2014 10:06:58 +0100
From: Michal Hocko <mhocko@suse.cz>
To: Anton Blanchard <anton@samba.org>
Subject: ppc: RECLAIM_DISTANCE 10?
Message-ID: <20140218090658.GA28130@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I have just noticed that ppc has RECLAIM_DISTANCE reduced to 10 set by
56608209d34b (powerpc/numa: Set a smaller value for RECLAIM_DISTANCE to
enable zone reclaim). The commit message suggests that the zone reclaim
is desirable for all NUMA configurations.

History has shown that the zone reclaim is more often harmful than
helpful and leads to performance problems. The default RECLAIM_DISTANCE
for generic case has been increased from 20 to 30 around 3.0
(32e45ff43eaf mm: increase RECLAIM_DISTANCE to 30).

I strongly suspect that the patch is incorrect and it should be
reverted. Before I will send a revert I would like to understand what
led to the patch in the first place. I do not see why would PPC use only
LOCAL_DISTANCE and REMOTE_DISTANCE distances and in fact machines I have
seen use different values.

Anton, could you comment please?
-- 
Michal Hocko
SUSE Labs

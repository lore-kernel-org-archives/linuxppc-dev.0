Return-Path: <david@fromorbit.com>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3scqxB54JMzDsdx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 12:45:01 +1000 (AEST)
Date: Mon, 19 Sep 2016 12:44:16 +1000
From: Dave Chinner <david@fromorbit.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.8: Reported regressions as of Sunday, 2016-09-18
Message-ID: <20160919024416.GX22388@dastard>
References: <724a8e1c-0141-d663-cda3-8fc0310989ea@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <724a8e1c-0141-d663-cda3-8fc0310989ea@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 18, 2016 at 03:20:53PM +0200, Thorsten Leemhuis wrote:
> Hi! Here is my fourth regression report for Linux 4.8. It lists 14
> regressions I'm aware of. 5 of them are new; 1 mentioned in last 
> weeks report got fixed.
> 
> As always: Are you aware of any other regressions? Then please let me
> know (simply CC regressions@leemhuis.info). And pls tell me if there
> is anything in the report that shouldn't be there.
> 
> Ciao, Thorsten
> 
> == Current regressions ==
> 
> Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
> Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
> Stat: 2016-09-09 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c34
> Note: stalled; root cause somewhere in the main gpio merge for 4.8, but problematic commit still unknown
> 
> Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
> Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
> Stat: 2016-09-09 https://marc.info/?t=147341519500003&r=1&w=2
> Note: looks like post-4.8 material at this point: Mel working on it in his spare time, but "The progression of this series has been unsatisfactory."

Actually, what Mel was working on (mapping lock contention) was not
related to the reported XFS regression. The regression was an XFS
sub-page write issue introduced by the new iomap infrastructure,
and nobody has been able to reproduce it exactly
outside of the reaim benchmark. We've reproduced other, similar
issues, and the fixes for those are queued for the 4.9 window.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

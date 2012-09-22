Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C868E2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 08:41:11 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 22 Sep 2012 16:41:07 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5827B19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 16:41:04 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8MMf3VD224040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 16:41:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8MMf3P6006635
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 16:41:03 -0600
Date: Sat, 22 Sep 2012 15:41:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: POWER7: Question on speculative rollback
Message-ID: <20120922224147.GA4946@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Is there a way to reliably check if a speculative roll back has occured in
the CPU ?

Normally we consider that an overflow has occured if the number of events
in a PMC reaches the overflow mark (0x80000000).

With speculative rollback, we assume that the overflow has occured if the
number of events is short of the overflow mark by 256 or less. pmc_overflow()
and check_compute_delta() use this assumption.

The problem with this assumption is that it is not always valid which is
why perf_event_interrupt() uses two different checks for overflow.

In the first pass it uses '(int)val < 0' and in the second pass the
pmc_overflow() helper.

The reason for falling back to 'val < 0' check is that the sampling period
could be very low and the number of events could truly be less than 256
even if no speculative roll back had occured.

But the problem with the 'val < 0' check is that if speculative rollback did
occur, we would not detect the rollback. We simply go ahead and reset the
counters and THROW AWAY all the events that occured until that point.

Over time and possibly with larger sampling periods, the number of events
thrown away can lead to very inaccurate results.

So, is there a better way to detect if a speculative rollback has occured
when we get a perf_event_interrupt() ?

Sukadev

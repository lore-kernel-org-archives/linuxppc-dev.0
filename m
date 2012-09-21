Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCAC22C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 10:37:28 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 20 Sep 2012 20:37:25 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8L0bNQq166104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 20:37:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8L0bM1E023599
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 21:37:23 -0300
Date: Thu, 20 Sep 2012 17:38:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Use pmc_overflow() to detect rolled back events
Message-ID: <20120921003805.GA4507@us.ibm.com>
References: <20120808010719.GA32730@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120808010719.GA32730@us.ibm.com>
Cc: Maynard Johnson <mpjohn@us.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| 
| >From 21e9d1775f0c6f37a39e5d682ff74693fa9a4004 Mon Sep 17 00:00:00 2001
| From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| Date: Tue, 7 Aug 2012 17:53:24 -0700
| Subject: [PATCH] Use pmc_overflow to detect rolled back events.
| 
| For certain speculative events on Power7, 'perf stat' reports far higher
| event count than 'perf record' for the same event.
| 
| As described in following commit, a performance monitor exception is raised
| even when the the performance events are rolled back.
| 
|         commit 0837e3242c73566fc1c0196b4ec61779c25ffc93
|         Author: Anton Blanchard <anton@samba.org>
|         Date:   Wed Mar 9 14:38:42 2011 +1100
| 
| perf_event_interrupt() records an event only when an overflow occurs. But
| this check for overflow is a simple 'if (val < 0)'.
| 
| Because the events are rolled back, this check for overflow fails and the
| event is not recorded. perf_event_interrupt() later uses pmc_overflow() to
| detect the overflow and resets the counters and the events are lost completely.
| 
| To properly detect the overflow of rolled back events, use pmc_overflow()
| even when recording events.

Ben,

Sorry for the noise, but please revert this patch (following commit):

	commit 813312110bede27bffd082c25cd31730bd567beb
	Author: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
	Date:   Tue Aug 7 15:07:19 2012 +0000

While it does fix the problem described above and works for the limit-pmc
events, it seems to break on Power7 for other events and when the sample
period is low.

I am still investigating the problem and will follow up with a separate
mail.

Sukadev

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69F242C02AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 12:29:57 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 20:29:55 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9EADA19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 20:29:18 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K2TRna153090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 20:29:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K2TP3c010117
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 20:29:27 -0600
Date: Wed, 19 Jun 2013 19:28:37 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] perf tools: fix a typo of a Power7 event name
Message-ID: <20130620022837.GA20609@us.ibm.com>
References: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1371691282.21846.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371691282.21846.1.camel@concordia>
Cc: icycoder@gmail.com, linux-kernel@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, acme@redhat.com, paulus@samba.org,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Wed, 2013-06-19 at 17:15 +0800, Runzhen Wang wrote:
| > In the Power7 PMU guide:
| > https://www.power.org/documentation/commonly-used-metrics-for-performance-analysis/
| > PM_BRU_MPRED is referred to as PM_BR_MPRED.
| > 
| > This patch fix the typo by changing the name of the event in kernel and
| > documentation accordingly.
| > 
| > Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>
| > ---
| >  .../testing/sysfs-bus-event_source-devices-events  |    2 +-
| >  arch/powerpc/perf/power7-pmu.c                     |   12 ++++++------
| >  2 files changed, 7 insertions(+), 7 deletions(-)
| > 
| > diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
| > index 8b25ffb..3c1cc24 100644
| > --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
| > +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
| > @@ -29,7 +29,7 @@ Description:	Generic performance monitoring events
| >  
| >  What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
| >  		/sys/devices/cpu/events/PM_BRU_FIN
| > -		/sys/devices/cpu/events/PM_BRU_MPRED
| > +		/sys/devices/cpu/events/PM_BR_MPRED
| 
| So you're changing the ABI.
| 
| I think that's probably OK, but you at least need to mention _why_ you
| think it's OK.

Some of the reasons I think its ok to change:

- It is relatively new interface, specific to the Power7 platform.

- No tools that we know of actually use this interface at this point (none
  are listed near the interface).

- Users of this interface (eg oprofile users migrating to perf) would be
  more used to the "PM_BR_MPRED" rather than "PM_BRU_MPRED".

- These are in the ABI/testing at this point rather than ABI/stable, so
  hoping we have some wiggle room.

But of course this is not a "grave error" or "security hole" which are
the justifications listed in the Documentation/ABI/README.  If these
are not good enough reasons, we can leave the misnomer around and
create another file in sysfs with the correct name PM_BR_MPRED.

Sukadev

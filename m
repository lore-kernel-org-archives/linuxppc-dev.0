Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4516D1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 14:51:18 +1100 (AEDT)
Message-ID: <1427341876.16501.2.camel@ellerman.id.au>
Subject: Re: [RFC, powerpc] perf/hv-24x7 set the attr group to NULL if
 events failed to be initialized
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 14:51:16 +1100
In-Reply-To: <20150325184153.GA6579@us.ibm.com>
References: <1423993377.2932.23.camel@TP420>
 <20150325095120.8F48F1400EA@ozlabs.org> <20150325184153.GA6579@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-25 at 11:41 -0700, Sukadev Bhattiprolu wrote:
> Michael Ellerman [mpe@ellerman.id.au] wrote:
> | On Sun, 2015-15-02 at 09:42:57 UTC, Li Zhong wrote:
> | > This patch moves the three events groups to the end of the attr groups,
> | > and if create_events_from_catalog() fails to set their attributes, we
> | > set them to NULL in attr_groups.
> | 
> | But why are we continuing at all if create_events_from_catalog() fails?
> | 
> | Shouldn't that just be a fatal error and we bail?
> 
> Well, even if create_events_from_catalog() fails, we can continue to use
> the 24x7 events, rather clumsily, as long as the catalog is readable.  i.e.
> parse /sys/bus/event_source/devices/hv_24x7/interface/catalog to find event
> offset and run:
> 
> 	perf stat -C 0 -e hv_24x7/domain=2,offset=8,core=0/ workload


Yeah I guess, but is that really useful? And is it a case we want to support?

It seems to me if create_events_from_catalog() fails then we either have:
  - a kernel bug
  - some sort of hypervisor misconfiguration
  - ENOMEM (in which case the system's probably dead anyway)

So in all cases trying to continue on seems fairly pointless to me.

cheers

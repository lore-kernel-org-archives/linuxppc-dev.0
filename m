Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66171A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 05:42:54 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 12:42:52 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 68A5F3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:42:50 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2PIgo2e27197504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 11:42:50 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2PIgnTY015355
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:42:50 -0600
Date: Wed, 25 Mar 2015 11:41:53 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC, powerpc] perf/hv-24x7 set the attr group to NULL if events
 failed to be initialized
Message-ID: <20150325184153.GA6579@us.ibm.com>
References: <1423993377.2932.23.camel@TP420>
 <20150325095120.8F48F1400EA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150325095120.8F48F1400EA@ozlabs.org>
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

Michael Ellerman [mpe@ellerman.id.au] wrote:
| On Sun, 2015-15-02 at 09:42:57 UTC, Li Zhong wrote:
| > This patch moves the three events groups to the end of the attr groups,
| > and if create_events_from_catalog() fails to set their attributes, we
| > set them to NULL in attr_groups.
| 
| But why are we continuing at all if create_events_from_catalog() fails?
| 
| Shouldn't that just be a fatal error and we bail?

Well, even if create_events_from_catalog() fails, we can continue to use
the 24x7 events, rather clumsily, as long as the catalog is readable.  i.e.
parse /sys/bus/event_source/devices/hv_24x7/interface/catalog to find event
offset and run:

	perf stat -C 0 -e hv_24x7/domain=2,offset=8,core=0/ workload
Suka

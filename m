Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6447A2C0089
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2013 12:47:46 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 4 Jan 2013 20:47:42 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5AC61C9003E
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2013 20:47:40 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r051leLI290384
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2013 20:47:40 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r051lcSd022282
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2013 23:47:39 -0200
Date: Fri, 4 Jan 2013 17:47:41 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/5] perf: Make EVENT_ATTR and EVENT_PTR global
Message-ID: <20130105014741.GA4438@us.ibm.com>
References: <20121219072802.GA30790@us.ibm.com>
 <20130102145850.GE931@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130102145850.GE931@krava.brq.redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Tue, Dec 18, 2012 at 11:28:02PM -0800, Sukadev Bhattiprolu wrote:
| > 
| > Rename EVENT_ATTR() and EVENT_PTR() PMU_EVENT_ATTR() and PMU_EVENT_PTR().
| > Make them global so they are available to all architectures.
| > 
| > Further to allow architectures flexibility, have PMU_EVENT_PTR() pass in the
| > variable name as a parameter.
| > 
| hi,
| the change looks ok apart from some nits below.
| 
| There' another version of the x86 event attributes change
| I mentioned earlier:
| 
| http://marc.info/?l=linux-kernel&m=135601815224373&w=2
| 
| I'm not sure which one will make it in first, but you
| guys need to sync ;-) CC-ing Andi and Stephane.

One change that would help powerpc (and other architectures) is to move
the 'struct perf_pmu_events_attr' to say, include/linux/perf_event.h.

Each architecture can define EVENT_VAR(), EVENT_PTR() etc as needed.

| 
| thanks,
| jirka
| 

<snip>

| > +struct perf_pmu_events_attr {
| > +	struct device_attribute attr;
| > +	u64 id;
| > +};
| > +
| > +#define PMU_EVENT_PTR(_var)	&_var.attr.attr
| 
| this one seems superfluous as well, could be replaced by '&'

I guess that would encode the assumption that both the 'attr' fields are 
the first in their respective structures. If so, an explicit comment beside
the fields would be useful.

Sukadev

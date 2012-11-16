Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFB5B2C0093
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2012 06:34:25 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 12:34:22 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BDCBD3E4003E
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2012 12:34:16 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAGJYGfR187636
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2012 12:34:17 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAGJYF5R028309
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2012 12:34:15 -0700
Date: Fri, 16 Nov 2012 11:35:37 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/4] perf/POWER7: Make event translations available in
 sysfs
Message-ID: <20121116193537.GA11800@us.ibm.com>
References: <20121107191818.GA16211@us.ibm.com>
 <20121107191927.GC16211@us.ibm.com>
 <20121114102534.GA2220@krava.brq.redhat.com>
 <20121114182045.GA2240@us.ibm.com>
 <20121116125154.GB1121@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121116125154.GB1121@krava.brq.redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
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
| > 
| > Can we remove the assumption that the event id is a generic event that
| > has PERF_COUNT_HW_ prefix and also let the architectures pass in a "show"
| > function ? This would allow architectures to display any arch specific
| > events that don't yet have a generic counterpart.
| > 
| > IOW, can we do something like this (untested) and make PERF_EVENT_ATTR global:
| 
| hm, then you probably can use following:
| 
| http://www.spinics.net/lists/kernel/msg1434233.html

For now, power events can simply be u64 - so am hoping to have something
like this and replace the raw codes:

#define PM_CYC			0x1e
#define PM_GCT_NOSLOT_CYC	0x100f8

EVENT_ATTR_STR() is interesting, but would require new/extra macros like

#define PM_CYC_STR		"0x1e"
#define PM_GCT_NOSLOT_CYC_STR	"0x100f8"

I went down the path we discussed earlier - to have x86 and Power share
the EVENT_ATTR() macros. This is making the x86 code less concise

	EVENT_ATTR(cpu-cycles,	CPU_CYCLES)

becomes

	EVENT_ATTR(cpu-cycles,	PERF_COUNT_HW_CPU_CYCLES, events_sysfs_show)

with each EVENT_ATTR() explcitly adding events_sysfs_show or needing another
wrapper around the wrappers.

Still tweaking it, but would it be flexible to make 'struct pmu_events_attr'
common and let architectures define the EVENT_ATTR() as needed ? Would
duplicate some code but hopefully not a lot.

Sukadev

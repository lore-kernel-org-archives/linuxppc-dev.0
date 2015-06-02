Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06A5C1A0F4F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 05:20:43 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 13:20:41 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8A13519D8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 13:11:42 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52JK73126214438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 12:20:07 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52JKeki001001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 13:20:40 -0600
Date: Tue, 2 Jun 2015 12:20:02 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 09/14] perf, tools: Group alias perf list by section
Message-ID: <20150602192002.GB3978@us.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-10-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Please drop this patch. It was incorrectly included in the set.
Also, see the updated Patch 12/14.

Current set of patches are in the json-v13.1 branch:

	https://github.com/sukadev/linux/tree/json-v13.1

Sukadev

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| From: Andi Kleen <ak@linux.intel.com>
| 
| The first first element in an hardware event name defines the general
| area, usually the part of the micro architecture it is refering to.
| Group the perf list output by these sections by adding section headers.
| 
| Signed-off-by: Andi Kleen <ak@linux.intel.com>
| Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| ---
|  tools/perf/util/pmu.c |   17 +++++++++++++++++
|  1 file changed, 17 insertions(+)
| 
| diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
| index 417333b..8d91fa7 100644
| --- a/tools/perf/util/pmu.c
| +++ b/tools/perf/util/pmu.c
| @@ -1039,6 +1039,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
|  	struct pair *aliases;
|  	int numdesc = 0;
|  	int columns = pager_get_columns();
| +	const char *last_section;
| +	int last_section_len;
| 
|  	pmu = NULL;
|  	len = 0;
| @@ -1086,6 +1088,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
|  		}
|  	}
|  	len = j;
| +	last_section = NULL;
| +	last_section_len = 0;
|  	qsort(aliases, len, sizeof(struct pair), cmp_pair);
|  	for (j = 0; j < len; j++) {
|  		if (name_only) {
| @@ -1093,8 +1097,21 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
|  			continue;
|  		}
|  		if (aliases[j].desc && !quiet_flag) {
| +			char *dot;
| +			char *name = aliases[j].name;
| +
|  			if (numdesc++ == 0)
|  				printf("\n");
| +			dot = strchr(name, '.');
| +			if (dot &&
| +				(!last_section ||
| +				 strncmp(last_section, name, last_section_len))) {
| +				last_section_len = dot - name;
| +				printf("%s%.*s:\n",
| +						last_section ? "\n" : "",
| +						last_section_len, name);
| +				last_section = name;
| +			}
|  			printf("  %-50s\n", aliases[j].name);
|  			printf("%*s", 8, "[");
|  			wordwrap(aliases[j].desc, 8, columns, 0);
| -- 
| 1.7.9.5
| 
| --
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/

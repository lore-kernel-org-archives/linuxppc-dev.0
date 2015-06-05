Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463411A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 04:18:14 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 12:18:11 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 373A01FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 12:08:34 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t55IGn9u29294806
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 11:16:49 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t55IHN5R031704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 12:17:24 -0600
Date: Fri, 5 Jun 2015 11:16:45 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 15/19] perf, tools: Support long descriptions with
 perf list
Message-ID: <20150605181645.GA25927@us.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433485647-9314-16-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150605102138.GB29934@krava.redhat.com>
 <20150605161926.GU1187@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150605161926.GU1187@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andi Kleen [ak@linux.intel.com] wrote:
| On Fri, Jun 05, 2015 at 12:21:38PM +0200, Jiri Olsa wrote:
| > On Thu, Jun 04, 2015 at 11:27:23PM -0700, Sukadev Bhattiprolu wrote:
| > 
| > SNIP
| > 
| > > ---
| > >  tools/perf/builtin-list.c |   11 ++++++++---
| > >  1 file changed, 8 insertions(+), 3 deletions(-)
| > > 
| > > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
| > > index 3f058f7..d0f7a18 100644
| > > --- a/tools/perf/builtin-list.c
| > > +++ b/tools/perf/builtin-list.c
| > > @@ -22,10 +22,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
| > >  {
| > >  	int i;
| > >  	bool raw_dump = false;
| > > +	bool long_desc_flag = false;
| > >  	struct option list_options[] = {
| > >  		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
| > >  		OPT_BOOLEAN('d', "desc", &desc_flag,
| > >  			    "Print extra event descriptions. --no-desc to not print."),
| > > +		OPT_BOOLEAN('d', "long-desc", &long_desc_flag,
| > > +			    "Print longer event descriptions."),
| > 
| > hum, it should be 'v' , right?

Good catch. Fixed.
| 
| Yes that's right.
| 
| Also BTW need to add the new option to the usage line a few lines below.

How about we do this for consistency with 'perf stat'(and shows the
long options exactly once with 'perf list -h')?

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index d0f7a18..f800927 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -27,12 +27,12 @@ int cmd_list(int argc, const char **argv, const char *prefi
                OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
                OPT_BOOLEAN('d', "desc", &desc_flag,
                            "Print extra event descriptions. --no-desc to not p
-               OPT_BOOLEAN('d', "long-desc", &long_desc_flag,
+               OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
                            "Print longer event descriptions."),
                OPT_END()
        };
        const char * const list_usage[] = {
-               "perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]"
+               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|event_glob]"
                NULL
        };
| 
| -Andi
| 
| -- 
| ak@linux.intel.com -- Speaking for myself only

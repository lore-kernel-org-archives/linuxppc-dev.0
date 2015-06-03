Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9999A1A0200
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:32:25 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:32:17 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 11/14] perf, tools: Support long descriptions with
 perf list -v
Message-ID: <20150603103217.GJ1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-12-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-12-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:11AM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Previously we were dropping the useful longer descriptions that some
> events have in the event list completely. This patch makes them appear with
> perf list.
> 
> Old perf list:
> 
> baclears:
>   baclears.all
>        [Counts the number of baclears]
> 
> vs new:
> 
> perf list -v:
> ...
> baclears:
>   baclears.all
>        [The BACLEARS event counts the number of times the front end is resteered, mainly when
>         the Branch Prediction Unit cannot provide a correct prediction and this is corrected
>         by the Branch Address Calculator at the front end. The BACLEARS.ANY event counts the
>         number of baclears for any type of branch]
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-list.c          |    9 ++++++---
>  tools/perf/pmu-events/jevents.c    |   29 ++++++++++++++++++++---------
>  tools/perf/pmu-events/jevents.h    |    2 +-
>  tools/perf/pmu-events/pmu-events.h |    1 +
>  tools/perf/util/parse-events.c     |    4 ++--
>  tools/perf/util/parse-events.h     |    2 +-
>  tools/perf/util/pmu.c              |   17 ++++++++++++-----
>  tools/perf/util/pmu.h              |    4 +++-
>  8 files changed, 46 insertions(+), 22 deletions(-)

I think this change should be split into:
  - jevents update of parsing out PublicDescription tag
  - alias support for long_desc
  - perf list update

jirka

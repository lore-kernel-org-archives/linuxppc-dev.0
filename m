Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19E351A1262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:42:28 +1000 (AEST)
Date: Thu, 28 May 2015 14:42:21 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] perf, tools: Handle header line in mapfile
Message-ID: <20150528124221.GK12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432761809-4344-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 02:23:23PM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Support a header line in the mapfile.csv, to match the existing
> mapfiles
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/pmu-events/jevents.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 03f7b65..43651cc 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -452,6 +452,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  
>  		if (line[0] == '#' || line[0] == '\n')
>  			continue;
> +		if (!strncmp(line, "Family", 6))
> +			continue;

I think we should fix mapfiles to put the 'Family' starting
line as a comment.. the way powerpc mapfile is done

jirka

>  
>  		if (line[strlen(line)-1] != '\n') {
>  			/* TODO Deal with lines longer than 16K */
> -- 
> 1.7.9.5
> 

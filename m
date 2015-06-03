Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7235F1A084B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:32:48 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:32:41 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 13/14] perf, tools: Handle header line in mapfile
Message-ID: <20150603103241.GL1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-14-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-14-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:13AM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Support a header line in the mapfile.csv, to match the existing
> mapfiles

'Suport' means 'skip' in here

jirka

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Changelog[v2]
> 	All architectures may not use the "Family" to identify. So,
> 	assume first line is header.
> ---
>  tools/perf/pmu-events/jevents.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 14707fb..8d365f2 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -461,7 +461,12 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  
>  	print_mapping_table_prefix(outfp);
>  
> -	line_num = 0;
> +	/* Skip first line (header) */
> +	p = fgets(line, n, mapfp);
> +	if (!p)
> +		goto out;
> +
> +	line_num = 1;
>  	while (1) {
>  		char *cpuid, *version, *type, *fname;
>  
> @@ -505,8 +510,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  		fprintf(outfp, "},\n");
>  	}
>  
> +out:
>  	print_mapping_table_suffix(outfp);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 

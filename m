Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp0NH0ST3zDrFm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:36:46 +1100 (AEDT)
Date: Mon, 3 Oct 2016 21:36:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 14/19] perf, tools, jevents: Handle header line in
 mapfile
Message-ID: <20161004003633.GD7143@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-15-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473978296-20712-15-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Sep 15, 2016 at 03:24:51PM -0700, Sukadev Bhattiprolu escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> To work with existing mapfiles, assume that the first line in
> 'mapfile.csv' is a header line and skip over it.

Moved this more to the front of this patchkit so that when testing it,
reproducing the tests performed earlier, one don't have to remove the
header.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---
> 
> Changelog[v2]
> 	All architectures may not use the "Family" to identify. So,
> 	assume first line is header.
> ---
>  tools/perf/pmu-events/jevents.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index f550cad..9cdfbaa 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -492,7 +492,12 @@ static int process_mapfile(FILE *outfp, char *fpath)
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
> @@ -536,8 +541,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
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
> 1.8.3.1

Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D5471A0D9E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:33:00 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:32:53 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/14] perf, tools, jevents: Program to convert JSON
 file to C style file
Message-ID: <20150603103253.GM1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433265135-20426-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:02AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> +
> +static int process_mapfile(FILE *outfp, char *fpath)
> +{
> +	int n = 16384;
> +	FILE *mapfp;
> +	char *save;
> +	char *line, *p;
> +	int line_num;
> +	char *tblname;
> +
> +	pr_info("%s: Processing mapfile %s\n", prog, fpath);

SNIP

> +
> +		cpuid = strtok_r(p, ",", &save);
> +		version = strtok_r(NULL, ",", &save);
> +		fname = strtok_r(NULL, ",", &save);
> +		type = strtok_r(NULL, ",", &save);
> +
> +		tblname = file_name_to_table_name(fname);
> +		fprintf(outfp, "{\n");
> +		fprintf(outfp, "\t.cpuid = \"%s\",\n", cpuid);
> +		fprintf(outfp, "\t.version = \"%s\",\n", version);
> +		fprintf(outfp, "\t.type = \"%s\",\n", type);

got build failure for make DEBUG=1:

  CC       pmu-events/jevents.o
pmu-events/jevents.c: In function ‘process_mapfile’:
pmu-events/jevents.c:498:10: error: ‘save’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   fprintf(outfp, "\t.type = \"%s\",\n", type);
          ^

jirka

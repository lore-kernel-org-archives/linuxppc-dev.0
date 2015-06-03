Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6201B1A0806
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:31:26 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:31:19 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/14] perf, tools, jevents: Program to convert JSON
 file to C style file
Message-ID: <20150603103119.GF1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

> + * If we fail to locate/process JSON and map files, create a NULL mapping
> + * table. This would at least allow perf to build even if we can't find/use
> + * the aliases.
> + */
> +static void create_empty_mapping(const char *output_file)
> +{
> +	FILE *outfp;
> +
> +	pr_info("%s: Creating empty pmu_events_map[] table\n", prog);
> +
> +	/* Unlink file to clear any partial writes to it */
> +	unlink(output_file);
> +
> +	outfp = fopen(output_file, "a");

you could open with "w+" and save the unlink call

SNIP

> +int main(int argc, char *argv[])
> +{
> +	int rc;
> +	int flags;
> +	int maxfds;
> +	char dirname[PATH_MAX];
> +
> +	const char *arch;
> +	const char *output_file;
> +	const char *start_dirname;
> +
> +	prog = basename(argv[0]);
> +	if (argc < 4) {
> +		pr_err("Usage: %s <arch> <starting_dir> <output_file>\n", prog);
> +		return 1;
> +	}
> +
> +	arch = argv[1];
> +	start_dirname = argv[2];
> +	output_file = argv[3];
> +
> +	if (argc > 4)
> +		verbose = atoi(argv[4]);
> +
> +	unlink(output_file);
> +	eventsfp = fopen(output_file, "a");

ditto

SNIP

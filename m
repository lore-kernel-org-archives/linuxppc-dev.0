Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7677E1A018F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:30:52 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:30:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/14] perf, tools, jevents: Program to convert JSON
 file to C style file
Message-ID: <20150603103045.GC1828@krava.redhat.com>
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

> +
> +static char *file_name_to_table_name(char *fname)
> +{
> +	unsigned int i, j;
> +	int c;
> +	int n = 1024;		/* use max variable length? */

I think this should be at least PATH_MAX, or you might
actually use asprintf and have all below done within
one line or so

jirka

> +	char *tblname;
> +	char *p;
> +
> +	tblname = malloc(n);
> +	if (!tblname)
> +		return NULL;
> +
> +	p = basename(fname);
> +
> +	memset(tblname, 0, n);
> +
> +	/* Ensure table name starts with an alphabetic char */
> +	strcpy(tblname, "pme_");
> +
> +	n = strlen(fname) + strlen(tblname);
> +	n = min(1024, n);
> +
> +	for (i = 0, j = strlen(tblname); i < strlen(fname); i++, j++) {
> +		c = p[i];
> +		if (isalnum(c) || c == '_')
> +			tblname[j] = c;
> +		else if (c == '-')
> +			tblname[j] = '_';
> +		else if (c == '.') {
> +			tblname[j] = '\0';
> +			break;
> +		} else {
> +			pr_err("%s: Invalid character '%c' in file name %s\n",
> +					prog, c, p);
> +			free(tblname);
> +			return NULL;
> +		}
> +	}
> +
> +	return tblname;
> +}

SNIP

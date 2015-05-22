Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E3DC1A0BF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 00:56:36 +1000 (AEST)
Date: Fri, 22 May 2015 16:56:28 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522145628.GB16473@krava.redhat.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 05:02:08PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> +int main(int argc, char *argv[])
> +{
> +	int rc;
> +	int flags;

SNIP

> +
> +	rc = uname(&uts);
> +	if (rc < 0) {
> +		printf("%s: uname() failed: %s\n", argv[0], strerror(errno));
> +		goto empty_map;
> +	}
> +
> +	/* TODO: Add other flavors of machine type here */
> +	if (!strcmp(uts.machine, "ppc64"))
> +		arch = "powerpc";
> +	else if (!strcmp(uts.machine, "i686"))
> +		arch = "x86";
> +	else if (!strcmp(uts.machine, "x86_64"))
> +		arch = "x86";
> +	else {
> +		printf("%s: Unknown architecture %s\n", argv[0], uts.machine);
> +		goto empty_map;
> +	}

hum, wouldnt it be easier to pass the arch directly from the Makefile,
we should have it ready in the $(ARCH) variable..

jirka

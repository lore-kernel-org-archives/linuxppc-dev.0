Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CECA81A0BF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 03:26:13 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 22 May 2015 13:26:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DF7DCC90046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 13:17:16 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4MHQ8k259834492
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 17:26:09 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4MHQ8hx002255
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 13:26:08 -0400
Date: Fri, 22 May 2015 10:25:40 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522172540.GA23163@us.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150522145628.GB16473@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522145628.GB16473@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Tue, May 19, 2015 at 05:02:08PM -0700, Sukadev Bhattiprolu wrote:
| 
| SNIP
| 
| > +int main(int argc, char *argv[])
| > +{
| > +	int rc;
| > +	int flags;
| 
| SNIP
| 
| > +
| > +	rc = uname(&uts);
| > +	if (rc < 0) {
| > +		printf("%s: uname() failed: %s\n", argv[0], strerror(errno));
| > +		goto empty_map;
| > +	}
| > +
| > +	/* TODO: Add other flavors of machine type here */
| > +	if (!strcmp(uts.machine, "ppc64"))
| > +		arch = "powerpc";
| > +	else if (!strcmp(uts.machine, "i686"))
| > +		arch = "x86";
| > +	else if (!strcmp(uts.machine, "x86_64"))
| > +		arch = "x86";
| > +	else {
| > +		printf("%s: Unknown architecture %s\n", argv[0], uts.machine);
| > +		goto empty_map;
| > +	}
| 
| hum, wouldnt it be easier to pass the arch directly from the Makefile,
| we should have it ready in the $(ARCH) variable..

Yes, I will do that and make all three args (arch, start_dir, output_file)
mandatory (jevents won't be run from command line often, it doesn't need
default args).

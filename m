Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 59FA71A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 09:58:33 +1000 (AEST)
Date: Wed, 20 May 2015 16:58:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: Use pmu_events_map table to create event aliases
Message-ID: <20150520235826.GB7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/*
> + * Return TRUE if the CPU identified by @vfm, @version, and @type
> + * matches the current CPU.  vfm refers to [Vendor, Family, Model],
> + *
> + * Return FALSE otherwise.
> + *
> + * For Powerpc, we only compare @version to the processor PVR.
> + */
> +bool arch_pmu_events_match_cpu(const char *vfm __maybe_unused,
> +				const char *version,
> +				const char *type __maybe_unused)
> +{
> +	char *cpustr;
> +	bool rc;
> +
> +	cpustr = get_cpu_str();
> +	rc = !strcmp(version, cpustr);


Surely against vfm not version
I think your mapfile is wrong if that works?

That's the Intel format:

.vfm = "GenuineIntel-6-3E",
        .version = "V16",
        .type = "core",
        .table = pme_IvyTown_core


-Andi

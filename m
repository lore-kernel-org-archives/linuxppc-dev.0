Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7A501A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 10:20:05 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 20 May 2015 18:20:03 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 932D41FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 18:11:12 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L0HrDR33095696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 17:17:54 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L0K129007284
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 18:20:01 -0600
Date: Wed, 20 May 2015 17:19:35 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: Use pmu_events_map table to create event aliases
Message-ID: <20150521001935.GD11568@us.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150520235826.GB7484@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150520235826.GB7484@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andi Kleen [ak@linux.intel.com] wrote:
| > +/*
| > + * Return TRUE if the CPU identified by @vfm, @version, and @type
| > + * matches the current CPU.  vfm refers to [Vendor, Family, Model],
| > + *
| > + * Return FALSE otherwise.
| > + *
| > + * For Powerpc, we only compare @version to the processor PVR.
| > + */
| > +bool arch_pmu_events_match_cpu(const char *vfm __maybe_unused,
| > +				const char *version,
| > +				const char *type __maybe_unused)
| > +{
| > +	char *cpustr;
| > +	bool rc;
| > +
| > +	cpustr = get_cpu_str();
| > +	rc = !strcmp(version, cpustr);
| 
| 
| Surely against vfm not version
| I think your mapfile is wrong if that works?

Like I say in the comment, and elsewhere, each archictecture
could use a subset of [vfm, version, type] to match the CPU.

On Power, we use the PVR, which is a string like "004d0100",
to uniquely identify the CPU.

Obviously, that does not fit into the VFM field. We could either
add a new PVR field to the mapfile:

	[vfm, version, type, pvr]

or, as the patch currently does, let architectures intepret the
"version" field as they see fit?

IOW, leave it to architectures to keep arch_pmu_events_match_cpu()
consistent with _their_ mapfile?

| 
| That's the Intel format:
| 
| .vfm = "GenuineIntel-6-3E",
|         .version = "V16",
|         .type = "core",
|         .table = pme_IvyTown_core
| 
| 
| -Andi

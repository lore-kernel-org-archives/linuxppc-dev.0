Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id C7F881A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:56:55 +1000 (AEST)
Date: Wed, 20 May 2015 19:56:53 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: Use pmu_events_map table to create event aliases
Message-ID: <20150521025653.GC7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150520235826.GB7484@tassilo.jf.intel.com>
 <20150521001935.GD11568@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150521001935.GD11568@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Obviously, that does not fit into the VFM field. We could either
> add a new PVR field to the mapfile:
> 
> 	[vfm, version, type, pvr]
> 
> or, as the patch currently does, let architectures intepret the
> "version" field as they see fit?
> 
> IOW, leave it to architectures to keep arch_pmu_events_match_cpu()
> consistent with _their_ mapfile?

version is the version number of the event file. This way 
you can't signify the version number if you ever change something.

If you need something else in vfm to identify the CPU 
can't you just add it there? I wouldn't really call it vfm, it's
really a "abstract cpu identifier per architecture". So if you
need pvr just add it there.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only

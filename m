Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE1CE1A11B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 21:52:31 +1000 (AEST)
Date: Thu, 28 May 2015 13:52:23 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150528115223.GD12392@krava.redhat.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
 <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 11:59:04PM +0900, Namhyung Kim wrote:
> Hi Andi,
> 
> On Wed, May 27, 2015 at 11:40 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >> So we build tables of all models in the architecture, and choose
> >> matching one when compiling perf, right?  Can't we do that when
> >> building the tables?  IOW, why don't we check the VFM and discard
> >> non-matching tables?  Those non-matching tables are also needed?
> >
> > We build it for all cpus in an architecture, not all architectures.
> > So e.g. for an x86 binary power is not included, and vice versa.
> 
> OK.
> 
> > It always includes all CPUs for a given architecture, so it's possible
> > to use the perf binary on other systems than just the one it was
> > build on.
> 
> So it selects one at run-time not build-time, good.  But I worry about
> the size of the intel tables.  How large are they?  Maybe we can make
> it dynamic-loadable if needed..

just compiled Sukadev's new version with Andi's events list
and stripped binary size is:

[jolsa@krava perf]$ ls -l perf
-rwxrwxr-x 1 jolsa jolsa 2772640 May 28 13:49 perf


while perf on Arnaldo's perf/core is:

[jolsa@krava perf]$ ls -l perf
-rwxrwxr-x 1 jolsa jolsa 2334816 May 28 13:49 perf


seems not that bad

jirka

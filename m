Return-Path: <vincent.weaver@maine.edu>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77B022C0355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 03:47:37 +1000 (EST)
Received: by mail-vc0-f176.google.com with SMTP id ha12so7020140vcb.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 10:47:34 -0700 (PDT)
Date: Thu, 11 Jul 2013 13:53:11 -0400 (EDT)
From: Vince Weaver <vincent.weaver@maine.edu>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <20130711105843.GG32197@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1307111340090.32218@vincent-weaver-1.um.maine.edu>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709081434.GI25631@dyad.programming.kicks-ass.net>
 <alpine.DEB.2.10.1307091059270.675@vincent-weaver-1.um.maine.edu>
 <20130711105843.GG32197@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "acme@redhat.com" <acme@redhat.com>,
 Vince Weaver <vincent.weaver@maine.edu>, Peter Zijlstra <peterz@infradead.org>,
 Vince Weaver <vince@deater.net>, Stephane Eranian <eranian@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "xiaoguangrong@linux.vnet.ibm.com" <xiaoguangrong@linux.vnet.ibm.com>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 "sukadev@linux.vnet.ibm.com" <sukadev@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mingo@kernel.org" <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 Jul 2013, Will Deacon wrote:
> On Tue, Jul 09, 2013 at 04:05:30PM +0100, Vince Weaver wrote:

> > libpfm4 uses the
> >    CPU part	: 0xc09
> > line in /proc/cpuinfo on ARM, and that's enough for the processors PAPI 
> 
> The CPU part you cite is actually A9-specific, so you probably want to
> probe each CPU specifically. Take a look at the cpuinfo parsing in OProfile
> (used by operf).

I meant we use the CPU part line to probe things.  I just cut and pasted
from a Cortex A9 I had handy as an example.

> > And speaking of ARM, I should be railing at them for breaking the ABI too, 
> > with their (understandable yet still ABI breaking) decision to remove 
> > BogoMIPS from /proc/cpuinfo.  That change will impact PAPI as well as 
> > various other programs I maintain that have the misfortune of parsing that 
> > file.
> 
> Really? Why are you checking for that line at all?

Old programs.

PAPI dates back to the day when processor frequency was meaningful (and 
stable).  In cases where MHz wasn't reported in cpuinfo (mostly MIPS and 
ARM) it tries to estimate it based on BogoMIPS.  Not the sanest thing to 
do, but it worked well enough at the time.  We recently fixed things so it 
should do something reasonable if BogoMIPS is missing, but if users wrote 
their code poorly they can get divide by zero errors if BogoMIPS suddenly 
goes missing from /proc/cpuinfo (and yes we have had a low but non-zero 
number of users report bugs of this type).

Other programs I have (like linux_logo and ll) are 15+ years old and 
simply print the BogoMIPS value for historical reasons.  So they won't 
break if the value goes away but it's still sad to see it go.

Vince

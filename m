Return-Path: <vince@deater.net>
Received: from fbr03.mfg.siteprotect.com (fbr03.mfg.siteprotect.com
 [64.26.60.138]) by ozlabs.org (Postfix) with ESMTP id 51CC92C031B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:55:29 +1000 (EST)
Received: from smtpauth03.mfg.siteprotect.com
 (smtpauth03-mf.mfg.chicago.hostway [192.168.33.73])
 by fbr03.mfg.siteprotect.com (Postfix) with ESMTP id C61F98809CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 11:46:09 -0500 (CDT)
Date: Tue, 25 Jun 2013 12:46:42 -0400 (EDT)
From: Vince Weaver <vince@deater.net>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: acme@redhat.com, vincent.weaver@maine.edu,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, xiaoguangrong@linux.vnet.ibm.com,
 paulus@samba.org, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Jun 2013, Runzhen Wang wrote:

> This patch makes all the POWER7 events available in sysfs.
> 
> ...
>
> $ size arch/powerpc/perf/power7-pmu.o
>    text	   data	    bss	    dec	    hex	filename
>    3073	   2720	      0	   5793	   16a1	arch/powerpc/perf/power7-pmu.o
> 
> and after the patch is applied, it is:
> 
> $ size arch/powerpc/perf/power7-pmu.o
>    text	   data	    bss	    dec	    hex	filename
>   15950	  31112	      0	  47062	   b7d6	arch/powerpc/perf/power7-pmu.o

So if I'm reading this right, there's 45k of overhead for just one cpu 
type?

What happens if we do this on x86?

If we have similar for p6/p4/core2/nehalem/ivb/snb/amd10h/amd15h/amd16h/knb
that's 450k of event defintions in the kernel.  And may I remind everyone 
that you can't compile perf_event support as a module, nor can you 
unconfigure it on x86 (it's always built in, no option to disable).

I'd like to repeat my unpopular position that we just link perf against 
libpfm4 and keep event tables in userspace where they belong.

Vince

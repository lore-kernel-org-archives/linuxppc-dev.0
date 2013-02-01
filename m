Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF8272C0293
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2013 21:26:35 +1100 (EST)
Received: by mail-ea0-f177.google.com with SMTP id n13so1627764eaa.8
 for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2013 02:26:32 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 1 Feb 2013 11:26:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 22/25] perf: Make EVENT_ATTR global
Message-ID: <20130201102629.GA24485@gmail.com>
References: <1359653128-10433-1-git-send-email-acme@infradead.org>
 <1359653128-10433-23-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359653128-10433-23-git-send-email-acme@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@infradead.org> wrote:

> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Rename EVENT_ATTR() to PMU_EVENT_ATTR() and make it global so it is
> available to all architectures.
> 
> Further to allow architectures flexibility, have PMU_EVENT_ATTR() pass
> in the variable name as a parameter.
> 
> Changelog[v2]
> 	- [Jiri Olsa] No need to define PMU_EVENT_PTR()
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Anton Blanchard <anton@au1.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linuxppc-dev@ozlabs.org
> Link: http://lkml.kernel.org/r/20130123062422.GC13720@us.ibm.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  arch/x86/kernel/cpu/perf_event.c | 13 +++----------
>  include/linux/perf_event.h       | 11 +++++++++++
>  2 files changed, 14 insertions(+), 10 deletions(-)

so this one started conflicting non-trivially with tip:perf/x86 
- the pending memory profiling kernel-side bits.

Can we merge the memory profiling tooling side bits together 
with the kernel side bits - or does it need more work?

For now I've excluded perf/x86 from tip:master until this is 
resolved.

Thanks,

	Ingo

Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
 [209.85.215.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DD972C0097
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2012 22:05:13 +1100 (EST)
Received: by mail-ea0-f170.google.com with SMTP id d11so631200eaa.15
 for <linuxppc-dev@ozlabs.org>; Sat, 01 Dec 2012 03:05:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 1 Dec 2012 12:05:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Message-ID: <20121201110504.GA14809@gmail.com>
References: <1353716453-9693-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353716453-9693-1-git-send-email-acme@infradead.org>
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
 x86@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Namhyung Kim <namhyung@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Dong Hao <haodong@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 acme@ghostprotocols.net, David Ahern <dsahern@gmail.com>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@infradead.org> wrote:

> Hi Ingo,
> 
> 	Tested using a cross-compiler and directly on a Raspberry pi (ARM) with
> raspbian.
> 
> 	Please consider pulling.
> 
> - Arnaldo
> 
> The following changes since commit 18423d3562f396206e0928a71177eeb2edfed077:
> 
>   Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2012-11-13 18:51:51 +0100)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-urgent-for-mingo
> 
> for you to fetch changes up to 7321090f6751c9987c26a8c81c63680d16a614d7:
> 
>   perf kvm: Fix building perf kvm on non x86 arches (2012-11-23 20:40:17 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes
> 
> . Don't build 'perf kvm stat" on non-x86 arches, fix from Xiao Guangrong.
> 
> . UAPI fixes to get perf building again in non-x86 arches, from David Howells.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       Merge tag 'perf-uapi-20121119' of git://git.infradead.org/users/dhowells/linux-headers into perf/urgent
> 
> David Howells (6):
>       x86: Export asm/{svm.h,vmx.h,perf_regs.h}
>       Merge branch 'x86-pre-uapi' into perf-uapi
>       tools: Define a Makefile function to do subdir processing
>       tools: Honour the O= flag when tool build called from a higher Makefile
>       tools: Pass the target in descend
>       perf: Make perf build for x86 with UAPI disintegration applied
> 
> Sukadev Bhattiprolu (1):
>       perf powerpc: Use uapi/unistd.h to fix build error
> 
> Xiao Guangrong (2):
>       perf kvm: Rename perf_kvm to perf_kvm_stat
>       perf kvm: Fix building perf kvm on non x86 arches
> 
>  Makefile                                |    6 +-
>  arch/x86/include/asm/Kbuild             |    3 +
>  include/linux/hw_breakpoint.h           |   31 +-------
>  include/uapi/linux/Kbuild               |    1 +
>  include/uapi/linux/hw_breakpoint.h      |   30 ++++++++
>  tools/Makefile                          |   24 +++---
>  tools/perf/Makefile                     |   29 +++++++-
>  tools/perf/arch/x86/include/perf_regs.h |    2 +-
>  tools/perf/builtin-kvm.c                |  121 +++++++++++++++++--------------
>  tools/perf/builtin-test.c               |    2 +-
>  tools/perf/perf.h                       |   16 +---
>  tools/perf/util/evsel.c                 |    4 +-
>  tools/perf/util/evsel.h                 |    3 +-
>  tools/perf/util/header.h                |    2 +-
>  tools/perf/util/parse-events-test.c     |    2 +-
>  tools/perf/util/parse-events.c          |    2 +-
>  tools/perf/util/parse-events.h          |    2 +-
>  tools/perf/util/pmu.h                   |    2 +-
>  tools/perf/util/session.h               |    2 +-
>  tools/scripts/Makefile.include          |   23 +++++-
>  20 files changed, 181 insertions(+), 126 deletions(-)
>  create mode 100644 include/uapi/linux/hw_breakpoint.h

Pulled, thanks a lot Arnaldo!

I'll get this to Linus ASAP.

Note: got a conflict with perf/core in tools/perf/Makefile, when 
merging in tip:master. It appeared to me that perf/core already 
included all the changes to BASIC_CFLAGS that perf/urgent 
updated, so I picked the perf/core version.

The merged result seems to work fine but please double check it 
nevertheless.

Thanks,

	Ingo

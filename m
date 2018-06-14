Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415mZK2TpgzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 11:42:01 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c22-v6so2365664pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 18:42:01 -0700 (PDT)
Date: Thu, 14 Jun 2018 11:41:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj
 <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck
 <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don
 Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>, Babu Moger
 <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>, "Luis R. Rodriguez"
 <mcgrof@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup
 detector from perf
Message-ID: <20180614114144.05891a04@roar.ozlabs.ibm.com>
In-Reply-To: <20180614011901.GA22652@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613084324.GU12258@hirez.programming.kicks-ass.net>
 <20180614011901.GA22652@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Jun 2018 18:19:01 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:  
> > > The current default implementation of the hardlockup detector assumes that
> > > it is implemented using perf events.  
> > 
> > The sparc and powerpc things are very much not using perf.  
> 
> Isn't it true that the current hardlockup detector
> (under kernel/watchdog_hld.c) is based on perf?

arch/powerpc/kernel/watchdog.c is a powerpc implementation that uses
the kernel/watchdog_hld.c framework.

> As far as I understand,
> this hardlockup detector is constructed using perf events for architectures
> that don't provide an NMI watchdog. Perhaps I can be more specific and say
> that this synthetized detector is based on perf.

The perf detector is like that, but we want NMI watchdogs to share
the watchdog_hld code as much as possible even for arch specific NMI
watchdogs, so that kernel and user interfaces and behaviour are
consistent.

Other arch watchdogs like sparc are a little older so they are not
using HLD. You don't have to change those for your series, but it
would be good to bring them into the fold if possible at some time.
IIRC sparc was slightly non-trivial because it has some differences
in sysctl or cmdline APIs that we don't want to break.

But powerpc at least needs to be updated if you change hld apis.

Thanks,
Nick

Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSLQb2HZKzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:08:07 +1100 (AEDT)
Date: Tue, 21 Feb 2017 22:07:54 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Ingo
 Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
Message-Id: <20170221220754.19e38e3728e235325b9385c3@kernel.org>
In-Reply-To: <20170220095024.GB12165@naverao1-tp.localdomain>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
 <20170217204254.GH4109@kernel.org>
 <20170219134211.0a43dfb2534563af5b6d440d@kernel.org>
 <20170220095024.GB12165@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Feb 2017 15:20:24 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/02/19 01:42PM, Masami Hiramatsu wrote:
> > On Fri, 17 Feb 2017 17:42:54 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> > > > On Thu, 16 Feb 2017 13:47:37 +0530
> > > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > > 
> > > > > I am posting the powerpc bits in the same thread so as to keep these
> > > > > changes together. I am not sure how this should be taken upstream as
> > > > > there are atleast three different trees involved: one for the core
> > > > > kprobes infrastructure, one for powerpc and one for perf.
> > > 
> > > > Hmm, could you make these (and other related) patches and
> > > > other series in one series? Or wait for the other series
> > > > are merged correctly.
> > > 
> > > Well, patches like these should be done in a way that the tooling parts
> > > can deal with kernels with or without the kernel changes, so that older
> > > tools work with new kernels and new tools work with older kernels.
> > > 
> > > "work" as in the previous behaviour is kept when a new tool deals with
> > > an older kernel and an older tool would warn the user that what it needs
> > > is not present in that kernel.
> > > 
> > > Is this the case? I just looked briefly at the patch commit logs.
> > 
> > Thanks Arnaldo,
> > 
> > Naveen, I think this one and your previous series are incompatible
> > with older kernel. So those should be merged in one series and
> > at least (1) update ftrace's README special file to show explicitly
> > which can accept text+offset style for kretprobes, and 
> 
> Sure - do you mean Documentation/trace/kprobetrace.txt? And, do you want 
> me to include kernel version where this changed?

No, I meant /sys/kernel/debug/tracing/README. For some reasons, perf
probe already parse it in util/probe-file.c. 
Please see commit 180b20616ce57e93eb692170c793be94c456b1e2 and 
864256255597aad86abcecbe6c53da8852ded15b

Thank you,

> 
> > (2) update
> > perf probe side to ensure that (and fallback to previous logic if not).
> 
> Sure. I am trying out an approach and will post it as soon as it's 
> ready.
> 
> Thanks!
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

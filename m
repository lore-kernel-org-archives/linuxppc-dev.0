Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ4jK68fKzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 07:43:01 +1100 (AEDT)
Date: Fri, 17 Feb 2017 17:42:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
Message-ID: <20170217204254.GH4109@kernel.org>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> On Thu, 16 Feb 2017 13:47:37 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > I am posting the powerpc bits in the same thread so as to keep these
> > changes together. I am not sure how this should be taken upstream as
> > there are atleast three different trees involved: one for the core
> > kprobes infrastructure, one for powerpc and one for perf.

> Hmm, could you make these (and other related) patches and
> other series in one series? Or wait for the other series
> are merged correctly.

Well, patches like these should be done in a way that the tooling parts
can deal with kernels with or without the kernel changes, so that older
tools work with new kernels and new tools work with older kernels.

"work" as in the previous behaviour is kept when a new tool deals with
an older kernel and an older tool would warn the user that what it needs
is not present in that kernel.

Is this the case? I just looked briefly at the patch commit logs.

If it is, then I can pick the tool ones, and the others can be submitted
to the relevant trees, at some point all will be in, kernels eventually
gets updated everywhere, ditto for the tooling, all gets well.

Regards,

- Arnaldo


 
> Thank you,
> 
> > 
> > Thanks,
> > Naveen
> > 
> > Naveen N. Rao (2):
> >   powerpc: kretprobes: override default function entry offset
> >   perf: powerpc: choose LEP with kretprobes
> > 
> >  arch/powerpc/kernel/kprobes.c               | 9 +++++++++
> >  tools/perf/arch/powerpc/util/sym-handling.c | 5 +----
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.11.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

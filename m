Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdbWS0dNLzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 01:29:23 +1100 (AEDT)
Date: Wed, 8 Mar 2017 11:29:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
Message-ID: <20170308142916.GA3035@kernel.org>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9xcujzi.fsf@concordia.ellerman.id.au>
 <20170308142412.GI11046@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308142412.GI11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Mar 08, 2017 at 07:54:12PM +0530, Naveen N. Rao escreveu:
> Hi Michael,
> 
> On 2017/03/08 09:43PM, Michael Ellerman wrote:
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > 
> > > With ABIv2, we offset 8 bytes into a function to get at the local entry
> > > point.
> > >
> > > Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> > > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/kernel/kprobes.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > 
> > I'm OK with this change, and I'm happy for it to go with the rest of the
> > series via acme's tree:
> > 
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> > 
> > But, you've also sent a series to do KPROBES_ON_FTRACE, and that also
> > touches this function, see the 2nd to last hunk at:
> > 
> >   https://patchwork.ozlabs.org/patch/730675/
> > 
> > 
> > If this goes via acme's tree it will be awkward for me to merge the
> > series above via the powerpc tree.
> 
> Ah yes, indeed.
> 
> > 
> > So we could do topic branches and so on, or we could just drop this
> > patch from this series, and I'll merge it as part of the other series.
> > It won't do anything useful until it's merged with a tree that also has
> > the rest of this series. Or something else I haven't thought of.
> 
> The arch-independent change that this depends on has been picked up by 
> Arnaldo and pushed to Ingo:
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg115211.html
> 
> I'm guessing this will go into v4.11? In which case, this powerpc patch 
> should also go in. Otherwise kretprobes will be broken on powerpc64le.

I don't think so, I've put it in a perf/core branch, meaning its not
strictly fixes, could be processed in the next merge window if Ingo
thinks we've passed the current merge window threshold for such kind of
changes, and he merged it into perf/core, meaning, at this time, that it
is aimed for 4.12.
 
> I wasn't sure if you were planning on picking up KPROBES_ON_FTRACE for 
> v4.11. If so, it would be good to take this patch through the powerpc 
> tree. Otherwise, this can go via Ingo's tree.

If you guys convince Ingo that this should go _now_, then just cherry
pick what was merged into tip/perf/core that is needed for the arch
specific stuff and go from there.

- Arnaldo

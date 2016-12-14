Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdqlt3jwLzDvh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 19:40:42 +1100 (AEDT)
Date: Wed, 14 Dec 2016 09:40:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] powerpc/32: Unset MSR RI in exception epilogs
Message-ID: <20161214084029.GO3124@twins.programming.kicks-ass.net>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
 <e6292c23163fac0865def3a385ff01d1497b005b.1481652710.git.christophe.leroy@c-s.fr>
 <20161213191514.GJ30845@gate.crashing.org>
 <1fbdc292-df1c-f6a8-efc4-019350209536@c-s.fr>
 <20161213225430.GN30845@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161213225430.GN30845@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2016 at 04:54:30PM -0600, Segher Boessenkool wrote:
> On Tue, Dec 13, 2016 at 09:39:55PM +0100, christophe leroy wrote:
> > Le 13/12/2016 à 20:15, Segher Boessenkool a écrit :
> > >On Tue, Dec 13, 2016 at 07:19:41PM +0100, Christophe Leroy wrote:
> > >>At exception prologs, once SRR0 and SRR1 have been saved, MSR RI is
> > >>set to mark the interrupt as recoverable.
> > >>
> > >>MSR RI has to be unset before writing into SRR0 and SRR1 at exception
> > >>epilogs.
> > >
> > >Why?  What goes wrong without this?  Etc.
> > 
> > The following patch implements perf instruction counting using the 8xx 
> > debug counters. When the counter reaches 0, it fires a debug exception.
> > If that exception happens between the setting of srr0/srr1 and the rfi, 
> > values set to srr0/srr1 are lost and we end up with an Oops.
> > 
> > To avoid that, MSR RI has to be unset. That way, because the debug 
> > counters mode is set to masked mode in register LCTRL2, no debug 
> > interrupt will happen during that critical phase.
> 
> Okay, so why then do you do an expensive sequence on all other processors?
> 

Does ppc32 support runtime code patching? If so, you could perhaps
utilize that to only inflict the painful code sequence when perf is
enabled.

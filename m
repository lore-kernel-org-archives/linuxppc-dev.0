Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 558961A1149
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:00:47 +1100 (AEDT)
Message-ID: <1450087241.9595.0.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: tracing: don't trace hcalls on offline CPUs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 14 Dec 2015 21:00:41 +1100
In-Reply-To: <20151207163343.0ea2f1bb@gandalf.local.home>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <1448389419-5296-2-git-send-email-kda@linux-powerpc.org>
 <20151207155224.2a8d71dd@gandalf.local.home>
 <1449522135.21036.11.camel@kernel.crashing.org>
 <20151207163343.0ea2f1bb@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-12-07 at 16:33 -0500, Steven Rostedt wrote:
> On Tue, 08 Dec 2015 08:02:15 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Mon, 2015-12-07 at 15:52 -0500, Steven Rostedt wrote:
> > > > +     TP_CONDITION(cpu_online(smp_processor_id())),
> > > > +  
> > 
> > This should probably be some kind of __raw version though, hcalls can
> > be called in contexts where the debug stuff in smp_processor_id() isn't
> > safe (or preempt enabled).
> > 
> 
> OK, then that needs to be updated.

Denis, please respin with raw_smp_processor_id().

cheers

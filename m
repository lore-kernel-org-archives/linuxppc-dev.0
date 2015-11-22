Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262421A0270
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 10:36:00 +1100 (AEDT)
Message-ID: <1448235359.18775.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: tracing: don't trace hcalls on offline CPUs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>,  Anton Blanchard <anton@samba.org>, Steven
 Rostedt <rostedt@goodmis.org>,  linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2015 10:35:59 +1100
In-Reply-To: <CAOJe8K1q=bO5iKfnG=9ZLNvk0sREcfqNJuHNhyspe6MG4hSfHA@mail.gmail.com>
References: <1446145810-5383-1-git-send-email-kda@linux-powerpc.org>
 <1446545202.2801.2.camel@ellerman.id.au>
 <CAOJe8K0=J033NMh++iznar21_p4G4epAgE0wONoxZxEyFPS9VQ@mail.gmail.com>
 <CAOJe8K1q=bO5iKfnG=9ZLNvk0sREcfqNJuHNhyspe6MG4hSfHA@mail.gmail.com>
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

On Fri, 2015-11-20 at 15:22 +0300, Denis Kirjanov wrote:
> On 11/3/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> > On 11/3/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > On Thu, 2015-10-29 at 22:10 +0300, Denis Kirjanov wrote:
> > > > ./drmgr -c cpu -a -r gives the following warning:
> > > > 
> > > > [ 2327.035563] RCU used illegally from offline CPU!
> > > > 
> > > > Make the hypervisor tracepoints conditional by introducing
> > > > TRACE_EVENT_FN_COND similar to TRACE_EVENT_FN
> > > 
> > > We've fixed other cases like this with RCU_NONIDLE(), but I assume that
> > > doesn't work here because we're actually offline?
> > 
> > Yes, in this case we're moving the complete core offline through dlpar...
> > 
> 
> Hi Michael,
> Could you pick this patch?

It's mostly a tracing patch, so I'd need an ACK from Steve at least.

It would probably be best if you split it into a "tracing: .. " patch which
adds the new macros and then a powerpc patch which uses them.

cheers

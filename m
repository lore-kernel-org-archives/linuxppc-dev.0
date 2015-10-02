Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47B771A0DFA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 18:25:03 +1000 (AEST)
Message-ID: <1443774290.27295.4.camel@kernel.crashing.org>
Subject: Re: [v2, 2/2] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
Cc: Aaron Sawdey <sawdey@us.ibm.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Steve Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org,
 anton@samba.org
Date: Fri, 02 Oct 2015 18:24:50 +1000
In-Reply-To: <20151002074709.3AE4F140773@ozlabs.org>
References: <20151002074709.3AE4F140773@ozlabs.org>
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

On Fri, 2015-10-02 at 17:47 +1000, Michael Ellerman wrote:
> On Fri, 2015-25-09 at 04:01:40 UTC, Michael Neuling wrote:
> > powerpc has a link register (lr) used for calling functions. We "bl
> > <func>" to call a function, and "blr" to return back to the call
> > site.
> 
> <snip, geez that was long>
> 
> > For the benchmark in
> > tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
> >   POWER8:
> >     64bit gets ~4% improvement
> >     32bit gets ~9% improvement
> >   POWER7:
> >     64bit gets ~7% improvement
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > Reported-by: Aaron Sawdey <sawdey@us.ibm.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/c974809a26a13e40254dbe3c

I'd argue this is a bug fix and should hit stable too..

Cheers,
Ben.

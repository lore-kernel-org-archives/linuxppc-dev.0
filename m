Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E4331A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 15:56:00 +1100 (AEDT)
Message-ID: <1426654559.6504.3.camel@ellerman.id.au>
Subject: Re: [RFC, v2] powerpc/powernv: Introduce kernel param to control
 fastsleep workaround behavior
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Date: Wed, 18 Mar 2015 15:55:59 +1100
In-Reply-To: <55084D0C.1040309@linux.vnet.ibm.com>
References: <20150317085708.7102714017B@ozlabs.org>
 <1426585198.4770.23.camel@kernel.crashing.org>
 <55084D0C.1040309@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-17 at 21:19 +0530, Shreyas B Prabhu wrote:
> 
> On Tuesday 17 March 2015 03:09 PM, Benjamin Herrenschmidt wrote:
> > On Tue, 2015-03-17 at 19:57 +1100, Michael Ellerman wrote:
> >>
> >> >From what I can see below, the decision as to whether you apply the workaround
> >> or not doesn't affect the list of idle states. So this could just as well be a
> >> runtime parameter, ie. a sysfs file, which can then be set by the user whenever
> >> they like? They might do it in a boot script, but that's up to them.
> > 
> > Right, that would work too.
> 
> Okay. I'll send a patch with this design.

Thanks.

> >> For simplicity I think it would also be fine to make it a write-once parameter,
> >> ie. you don't need to handle undoing it.
> > 
> > It would be easy enough to make it rw using stop machine I think... 
> > 
> >> I think the only complication that would add is that you'd need to be a little
> >> careful about the order in which you nop out the calls vs applying the
> >> workaround, in case some threads are idle when you're called.
> 
> Right, we should be safe with this sequence-
> - NOP call to undo workaround
> - Apply workaround on all cores.
> - NOP call to apply workaround
 
Yeah that sounds right.

> > I wouldn't bother with NOP'ing in that case, a runtime test will probably be noise
> > in the measurement.
> 
> Didn't get your point here. Do you mean, ignore the request if some
> cores are in sleep or deeper state?

I *think* what he means is we probably don't actually need to patch a nop
in/out. Instead we could just test a flag, because the cost of testing a flag
is miniscule compared to the rest of the logic.

cheers

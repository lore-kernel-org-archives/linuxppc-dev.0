Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 135DF1A024E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 07:08:45 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2FA42140093
 for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2014 07:08:42 +1000 (EST)
Message-ID: <1401397708.6603.182.camel@snotra.buserror.net>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT, and
 DBCR0_ACTIVE_EVENTS
From: Scott Wood <scottwood@freescale.com>
To: shiva7 <sivasakthi7@outlook.com>
Date: Thu, 29 May 2014 16:08:28 -0500
In-Reply-To: <1401142837010-82686.post@n7.nabble.com>
References: <5167457E.1050205@genband.com>
 <1398170592855-81732.post@n7.nabble.com>
 <1398205896.1694.252.camel@snotra.buserror.net>
 <1398206224.1694.254.camel@snotra.buserror.net>
 <1400456291193-82408.post@n7.nabble.com>
 <1400521677.18239.16.camel@snotra.buserror.net>
 <1400591218911-82485.post@n7.nabble.com>
 <1401142837010-82686.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-26 at 15:20 -0700, shiva7 wrote:
> shiva7 wrote
> > Thanks again Scott.
> /
> >> Any idea whether the DBCR0 BRT bit actually works(??), 
> > 
> >> Do you have reason to believe that it might not? 
> /
> > 
> > I'm facing a strange problem which was not there on server processor. Let
> > me try to give brief flow.
> > 
> > Server :
> > 
> > Set BE bit (thru system call or sigreturn) for specific thread -> for
> > every branch -> trace exception -> Normal exception prolog
> > (STD_EXCEPTION_COMMON) SRR0 and SRR1
> > 
> > Embedded/BOOKE:
> > 
> > Set DE & BRT bit (thru system call or sigreturn) for specific thread ->
> > for every branch taken -> Debug exception -> DEBUG_DEBUG prolog ->
> > return_dbg_except DSRR0 & DSRR1
> > 
> > In server case, able to capture the branches as expected, but wherein
> > BOOKE though branch taken exception are generated, at the certain stage
> > (mostly after turn on BRT & DE bit)  user process is deviated (not taking
> > the same flow as like server) and leading to different
> > corruption/unexpected behavior.
> /
> >> And also, anything special required for "server" family application code 
> >> porting here ?? as because in server family the trace exception used to
> >> viz 
> >> NORMAL exception proglog and uses SRR0 and SRR1 but in this ISA/embedded 
> >> case have dedicated DEBUG_DEBUG prolog and dedicated registers DSRR0 and 
> >> DSRR1. 
> > 
> >> IIRC the branch taken mechanism does have different semantics than the 
> >> equivalent mechanism on server.  You can find discussion of this in the 
> >> archives. :-) 
> /
> > 
> > Most of the discussions so far I have surfed are related to branch
> > taken/fall through(not taken) semantics related. But, in general, if I
> > have an application running on server where tracing was based on BE bit
> > and same can run on e500mc with DE & BRT combination?
> > 
> > 
> > Thanks In Advance.
> 
> Could someone help on this regard?

I think you'll need to debug it, and send a patch if you find a bug.  As
for "in general" that depends on whether your application cares about
the difference in semantics that was noted.

-Scott

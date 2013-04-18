Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 732912C013A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 16:28:15 +1000 (EST)
Message-ID: <1366266485.24994.79.camel@pasglop>
Subject: Re: questions around Book III-E and branch trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <chris.friesen@genband.com>
Date: Thu, 18 Apr 2013 08:28:05 +0200
In-Reply-To: <516EED8D.3040304@genband.com>
References: <516EED8D.3040304@genband.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-17 at 12:44 -0600, Chris Friesen wrote:
> Hi,
> 
> I'm trying to wrap my head around how linux handles branch tracing on 
> Book III-E.  I think I understand how we set MSR[DE] and DBCR0[IDM|BT], 
> and how we handle fixing things up if an instruction being traced causes 
> an exception.

That code is a mess and it wouldn't surprise me if it was broken...

At this point, the people who care the most about it are FSL, so
that's where you have the most chance to find a satisfactory answer.

Cheers,
Ben.

> I have a few questions though:
> 
> 1) Does user_enable_block_step() have a bug in it?  The current code has
> 
> task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
> 
> Should that be as follows (to match the singel-step case)?
> 
> task->thread.dbcr0 |= DBCR0_IDM | DBCR0_BT;
> 
> 
> 2) Why doesn't DBCR0_ACTIVE_EVENTS include DBCR0_BT?
> 
> 
> 3) In sys_debug_setcontext() why does SIG_DBG_BRANCH_TRACING return 
> -EINVAL if CONFIG_PPC_ADV_DEBUG_REGS is set?  Would it not be possible 
> to use DBCR0_BT?
> 
> Thanks,
> Chris
> 
> 

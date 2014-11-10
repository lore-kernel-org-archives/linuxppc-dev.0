Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DEAD1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 16:41:39 +1100 (AEDT)
Message-ID: <1415598090.5769.15.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 10 Nov 2014 16:41:30 +1100
In-Reply-To: <5460307C.9060502@ozlabs.org>
References: <1415245107.292153.444216242273.0.gpush@pablo>
 <545B826F.7050501@acm.org> <5460307C.9060502@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-10 at 11:26 +0800, Jeremy Kerr wrote:
> Hi Corey,
> 
> Thanks for the review.
> 
> >> IPMI folks: the IPMI driver could do with a little review, as it's
> >> not a conventional BT/KCS/SMI SI, in that the low-level send/recv
> >> interface will handle the entire message at once.
> > 
> > Handling the entire message at once should be fine, as that's what
> > this driver level is designed to do for the message handler.  That
> > part all looks correct.  The code itself looks good, but I have a
> > couple of high-level comments.
> > 
> > The driver at this level can receive more than one message to handle
> > at a time, so it needs some sort of queue.  This is to allow multiple
> > users and to allow the message handler to send its own commands while
> > other commands are going on.  You might argue that the queuing should
> > be done in ipmi_msghandler, and you would probably be right.
> 
> Ah, that's what I'd been assuming was being done - I missed the
> xmit_list in the si_intf code. It'd be great if this could be in the
> generic msghandler code, otherwise I'd just be duplicating the si_intf
> logic.

Our OPAL interface can only do one at a time ? Because our underlying FW
driver already has a queue ..

> > I'll look at doing that.  If that is the case, then your NULL check
> > for current message should probably be a BUG_ON().
> 
> OK, I'll update this when the msghandler bit is implemented.
> 
> > Do you need to handle any BMC flags?  Particularly incoming events?
> 
> Not at this stage - we may in future though.
> 
> Cheers,
> 
> 
> Jeremy
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

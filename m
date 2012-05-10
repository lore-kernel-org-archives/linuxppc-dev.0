Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DDD6B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 07:58:25 +1000 (EST)
Message-ID: <1336687098.3881.63.camel@pasglop>
Subject: Re: [PATCH v3 03/17] powerpc: Add PFO support to the VIO bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Date: Fri, 11 May 2012 07:58:18 +1000
In-Reply-To: <20120510190835.GB12304@linux.vnet.ibm.com>
References: <1334242825.18090.4.camel@key-ThinkPad-W510>
 <1334243302.18090.10.camel@key-ThinkPad-W510>
 <1335841603.3621.8.camel@pasglop>
 <20120510190835.GB12304@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-10 at 14:08 -0500, Robert Jennings wrote:
> * Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:

> > Is this meant to be called in atomic context ? If not, maybe it should
> > at the very least do a cond_resched() ?
> > 
> > Else, what about ceding the processor ? Or at the very least reducing
> > the thread priority for a bit ?
> > 
> > Shouldn't we also enforce to always have a timeout ? IE. Something like
> > 30s or so if nothing specified to avoid having the kernel just hard
> > lock...
> > 
> > In general I don't like that sort of synchronous code, I'd rather return
> > the busy status up the chain which gives a chance to the caller to take
> > more appropriate measures depending on what it's doing, but that really
> > depends what you use that synchronous call for. I suppose if it's for
> > configuration type operations, it's ok...
> 
> This function is called in atomic context, it is used by PFO-type device
> drivers to perform operations with the nest accelerator unit (like
> crypto acceleration).
> 
> Having the timeout and retries in this function is the wrong thing to do.
> We'll resubmit this without the loop and the caller will be responsible for
> retrying the operations.
>
> I would rather have the caller cede the processor or alter thread
> priority where appropriate than doing that in this function.  I don't
> think this should be done in this crypto driver.

That sounds right indeed... as long as the upper crypto layer has a
concept of "try again later"... if it doesn't it will result in random
funny failures :-)

Cheers,
Ben.

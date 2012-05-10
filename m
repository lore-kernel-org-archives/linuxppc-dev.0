Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01B23B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 05:09:01 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Thu, 10 May 2012 15:08:56 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5BF9F38C8090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 15:08:47 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4AJ8cxb10879086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 15:08:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4AJ8bHZ024277
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 16:08:38 -0300
Date: Thu, 10 May 2012 14:08:35 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 03/17] powerpc: Add PFO support to the VIO bus
Message-ID: <20120510190835.GB12304@linux.vnet.ibm.com>
References: <1334242825.18090.4.camel@key-ThinkPad-W510>
 <1334243302.18090.10.camel@key-ThinkPad-W510>
 <1335841603.3621.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335841603.3621.8.camel@pasglop>
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

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> Hrm... I don't like that much:
> 
> > +	if (op->timeout)
> > +		deadline = jiffies + msecs_to_jiffies(op->timeout);
> > +
> > +	while (true) {
> > +		hret = plpar_hcall_norets(H_COP, op->flags,
> > +				vdev->resource_id,
> > +				op->in, op->inlen, op->out,
> > +				op->outlen, op->csbcpb);
> > +
> > +		if (hret == H_SUCCESS ||
> > +		    (hret != H_NOT_ENOUGH_RESOURCES &&
> > +		     hret != H_BUSY && hret != H_RESOURCE) ||
> > +		    (op->timeout && time_after(deadline, jiffies)))
> > +			break;
> > +
> > +		dev_dbg(dev, "%s: hcall ret(%ld), retrying.\n", __func__, hret);
> > +	}
> > +
> 
> Is this meant to be called in atomic context ? If not, maybe it should
> at the very least do a cond_resched() ?
> 
> Else, what about ceding the processor ? Or at the very least reducing
> the thread priority for a bit ?
> 
> Shouldn't we also enforce to always have a timeout ? IE. Something like
> 30s or so if nothing specified to avoid having the kernel just hard
> lock...
> 
> In general I don't like that sort of synchronous code, I'd rather return
> the busy status up the chain which gives a chance to the caller to take
> more appropriate measures depending on what it's doing, but that really
> depends what you use that synchronous call for. I suppose if it's for
> configuration type operations, it's ok...

This function is called in atomic context, it is used by PFO-type device
drivers to perform operations with the nest accelerator unit (like
crypto acceleration).

Having the timeout and retries in this function is the wrong thing to do.
We'll resubmit this without the loop and the caller will be responsible for
retrying the operations.

I would rather have the caller cede the processor or alter thread
priority where appropriate than doing that in this function.  I don't
think this should be done in this crypto driver.

--Rob Jennings

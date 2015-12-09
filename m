Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A9B91A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 12:06:51 +1100 (AEDT)
Message-ID: <1449623211.6028.10.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, dja@axtens.net, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Wed, 09 Dec 2015 12:06:51 +1100
In-Reply-To: <1449622825.8861.4.camel@neuling.org>
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1446541751.23081.1.camel@ellerman.id.au> <5639A307.7060503@au1.ibm.com>
 <566678FA.5030400@au1.ibm.com> <1449622825.8861.4.camel@neuling.org>
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

On Wed, 2015-12-09 at 12:00 +1100, Michael Neuling wrote:
> On Tue, 2015-12-08 at 17:30 +1100, Andrew Donnellan wrote:
> > Finally looking at this patch again for the first time in a couple of
> > months...
> > 
> > On 04/11/15 17:17, Andrew Donnellan wrote:
> > > On 03/11/15 20:09, Michael Ellerman wrote:
> > > > Part of your problem is you're storing afu->crs_len which is not __iomem in
> > > > cfg_data which is, and so that's leading to some of your casts.
> > > > 
> > > > I don't really see why you're using cfg_data like that, you have the
> > > > afu in phb->private_data. But maybe cfg_data needs to hold that value
> > > > for some other code I'm not seeing.
> > > 
> > > I can't see any obvious reason why we need to use cfg_data either.
> > 
> > Ian/Mikey - do you happen to know why we're using cfg_data? I've
> > taken another look and I can't see anything obvious.
> 
> IIRC, when I coded this up, benh just said these (cfg_addr/data) are
> just private data and we can stick whatever we like in there.
> 
> We could store it in the AFU struct but it's (was just) convenient to
> just store it here.

You're storing afu->crs_len in there, so it is in the AFU struct. Unless
there's a different "AFU struct", in which case meh.

Please send me a patch to clean it up Andrew.

cheers

Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38ED21A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 12:00:26 +1100 (AEDT)
Message-ID: <1449622825.8861.4.camel@neuling.org>
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
From: Michael Neuling <mikey@neuling.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, dja@axtens.net, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Wed, 09 Dec 2015 12:00:25 +1100
In-Reply-To: <566678FA.5030400@au1.ibm.com>
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1446541751.23081.1.camel@ellerman.id.au> <5639A307.7060503@au1.ibm.com>
 <566678FA.5030400@au1.ibm.com>
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

On Tue, 2015-12-08 at 17:30 +1100, Andrew Donnellan wrote:
> Finally looking at this patch again for the first time in a couple of
> months...
>=20
> On 04/11/15 17:17, Andrew Donnellan wrote:
> > On 03/11/15 20:09, Michael Ellerman wrote:
> > > Part of your problem is you're storing afu->crs_len which is not
> > > __iomem in
> > > cfg_data which is, and so that's leading to some of your casts.
> > >=20
> > > I don't really see why you're using cfg_data like that, you have
> > > the
> > > afu in
> > > phb->private_data. But maybe cfg_data needs to hold that value
> > > for
> > > some other
> > > code I'm not seeing.
> >=20
> > I can't see any obvious reason why we need to use cfg_data either.
>=20
> Ian/Mikey - do you happen to know why we're using cfg_data? I've
> taken=20
> another look and I can't see anything obvious.
>=20

IIRC, when I coded this up, benh just said these (cfg_addr/data) are
just private data and we can stick whatever we like in there.

We could store it in the AFU struct but it's (was just) convenient to
just store it here.

Mikey

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F9C7B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 15:25:47 +1000 (EST)
Message-ID: <1339565137.9220.87.camel@pasglop>
Subject: Re: [PATCH] powerpc: pseries: Round up MSI-X requests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Jun 2012 15:25:37 +1000
In-Reply-To: <1339564687.8742.9.camel@concordia>
References: <20120604091545.03ce738b@kryten>
 <1338792215.15716.5.camel@concordia> <1338792897.7150.68.camel@pasglop>
 <20120605124703.12bb4cc3@kryten> <1339564687.8742.9.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 15:18 +1000, Michael Ellerman wrote:
> On Tue, 2012-06-05 at 12:47 +1000, Anton Blanchard wrote:
> > Hi,
> > 
> > > On Mon, 2012-06-04 at 16:43 +1000, Michael Ellerman wrote:
> > > > There is some chance this will result in breakage because the driver
> > > > asks for N - and assumes that is what was allocated - and the
> > > > device is configured for > N.
> > > 
> > > We can fix that. We can whack the configuration back with N, just know
> > > that we have "allocated"  > N.
> 
> I think whacking config space is more likely to break something than
> just configuring more than the driver asked for.

How so ? I tend to disagree here..
.
> > I agree we don't want to be giving back a larger value than requested.
> > There's only one place that can happen in theory and since firmware only
> > returns power of two values I dont think it will happen in practise.
> 
> Don't follow you here.
> 
> > Even so do we want to do something like this (as yet untested)? If the
> > rounded up request fails we retry with the original request.
> 
> Yes we do. Had a chance to test it?
> 
> > The pseries msi free code just sets our vectors to 0 so it doesn't need
> > to know how many were originally allocated.
> 
> Yep, looks like it will cope.
> 
> We only create virqs for what's in pdev->msi_list, which will be what
> the driver originally asked for, and we free all those by walking the
> list again. So the fact that firmware allocated a few extra for us is
> OK, we have nothing extra to cleanup.

The firmware interface is busted anyway. We want to be able to
enable/allocate individual MSI-X at runtime, we need to get a new
interface sorted.

Ben.

Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4287JP2ZjQzF37b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 22:53:24 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so39819484oig.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 05:53:24 -0700 (PDT)
Date: Mon, 10 Sep 2018 07:53:20 -0500
From: Rob Herring <robh@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Finn Thain <fthain@telegraphics.com.au>, Stan Johnson <userm57@yahoo.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Message-ID: <20180910125320.GA17028@bogus>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 09, 2018 at 07:04:25PM +0200, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
> > 
> > > A long shot, but something to consider, is that I failed to cover the
> > > cases of dynamic devicetree updates (removing nodes that contain a
> > > phandle) in ways other than overlays.  Michael Ellerman has reported
> > > such a problem for powerpc/mobility with of_detach_node().  A patch to
> > > fix that is one of the tasks I need to complete.
> > 
> > The only thing I can think of is booting via the BootX bootloader on
> > those ancient macs results in a DT with no phandles. I didn't see an
> > obvious reason why that would cause that patch to break though.
> 
> Guys, we still don't have a fix for this one on its way upstream...
> 
> My test patch just creates phandle properties for all nodes, that was
> not intended as a fix, more a way to check if the problem was related
> to the lack of phandles.
> 
> I don't actually know why the new code causes things to fail when
> phandles are absent. This needs to be looked at.
> 
> I'm travelling at the moment and generally caught up with other things,
> I haven't had a chance to dig, so just a heads up. I don't intend to
> submit my patch since it's just a band aid. We need to figure out what
> the actual problem is.

Can you try this patch (w/o Ben's patch). I think the problem is if 
there are no phandles, then roundup_pow_of_two is passed 0 which is 
documented as undefined result.

Though, if a DT has no properties with phandles, then why are we doing a 
lookup in the first place?


8<----------------------------------------------------------------------

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9095b8290150..74eaedd5b860 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	if (!phandles)
+		goto out;
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 

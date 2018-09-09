Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427dJ04lPHzF3C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 03:21:20 +1000 (AEST)
Message-ID: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Rowand <frowand.list@gmail.com>, Finn Thain
 <fthain@telegraphics.com.au>
Cc: Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Sun, 09 Sep 2018 19:04:25 +0200
In-Reply-To: <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
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

On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
> 
> > A long shot, but something to consider, is that I failed to cover the
> > cases of dynamic devicetree updates (removing nodes that contain a
> > phandle) in ways other than overlays.  Michael Ellerman has reported
> > such a problem for powerpc/mobility with of_detach_node().  A patch to
> > fix that is one of the tasks I need to complete.
> 
> The only thing I can think of is booting via the BootX bootloader on
> those ancient macs results in a DT with no phandles. I didn't see an
> obvious reason why that would cause that patch to break though.

Guys, we still don't have a fix for this one on its way upstream...

My test patch just creates phandle properties for all nodes, that was
not intended as a fix, more a way to check if the problem was related
to the lack of phandles.

I don't actually know why the new code causes things to fail when
phandles are absent. This needs to be looked at.

I'm travelling at the moment and generally caught up with other things,
I haven't had a chance to dig, so just a heads up. I don't intend to
submit my patch since it's just a band aid. We need to figure out what
the actual problem is.

Cheers,
Ben.

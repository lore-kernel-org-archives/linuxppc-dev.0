Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421nFV3CQTzF31L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:58:54 +1000 (AEST)
Message-ID: <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Rowand <frowand.list@gmail.com>, Finn Thain
 <fthain@telegraphics.com.au>
Cc: Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 31 Aug 2018 14:58:41 +1000
In-Reply-To: <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
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

On Thu, 2018-08-30 at 21:36 -0700, Frank Rowand wrote:
> > No idea whether that's relevant; I haven't done any further investigation. 
> > Complete dmesg output is attached. Please let me know if there's any more 
> > information you need to help find the bug.
> > 
> > Thanks.
> 
> I don't have any useful answers yet, but I am following the thread and have
> also quickly scanned the two commits for any obvious cause.  I will look
> into this some more, but have a few other tasks that I need to complete
> first.
> 
> A long shot, but something to consider, is that I failed to cover the
> cases of dynamic devicetree updates (removing nodes that contain a
> phandle) in ways other than overlays.  Michael Ellerman has reported
> such a problem for powerpc/mobility with of_detach_node().  A patch to
> fix that is one of the tasks I need to complete.

The only thing I can think of is booting via the BootX bootloader on
those ancient macs results in a DT with no phandles. I didn't see an
obvious reason why that would cause that patch to break though.

Cheers,
Ben.

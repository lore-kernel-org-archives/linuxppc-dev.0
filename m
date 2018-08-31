Return-Path: <frowand.list@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421mlC5Z6FzF375
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:36:05 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id m4-v6so4865180pgv.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 21:36:05 -0700 (PDT)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
Date: Thu, 30 Aug 2018 21:36:00 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On 08/29/18 17:44, Finn Thain wrote:
> Hi Frank,
> 
> Linux v4.17 and later will no longer boot on a G3 PowerMac. The boot hangs 
> very early, before any video driver loads.
> 
> Stan and I were able to bisect the regression between v4.16 and v4.17 and 
> arrived at commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of 
> of_find_node_by_phandle()").
> 
> I don't see any obvious bug in 0b3ce78e90fc or b9952b5218ad. But if you 
> revert these from v4.18 (which is also affected) that certainly resolves 
> the issue.
> 
> I did see this in the kernel messages:
> 
> Duplicate name in PowerPC,750, renamed to "l2-cache#1"
> Duplicate name in mac-io, renamed to "ide#1"
> Duplicate name in ide#1, renamed to "atapi-disk#1"
> Duplicate name in multifunc-device, renamed to "pci1799,1#1"
> 
> No idea whether that's relevant; I haven't done any further investigation. 
> Complete dmesg output is attached. Please let me know if there's any more 
> information you need to help find the bug.
> 
> Thanks.

I don't have any useful answers yet, but I am following the thread and have
also quickly scanned the two commits for any obvious cause.  I will look
into this some more, but have a few other tasks that I need to complete
first.

A long shot, but something to consider, is that I failed to cover the
cases of dynamic devicetree updates (removing nodes that contain a
phandle) in ways other than overlays.  Michael Ellerman has reported
such a problem for powerpc/mobility with of_detach_node().  A patch to
fix that is one of the tasks I need to complete.

-Frank

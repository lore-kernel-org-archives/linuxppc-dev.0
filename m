Return-Path: <frowand.list@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427nzJ6ykCzF38J
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 09:52:28 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id s15-v6so9506924pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Sep 2018 16:52:28 -0700 (PDT)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Finn Thain <fthain@telegraphics.com.au>
Cc: Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frank Rowand <frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <3d806f12-dd6f-63d7-92e0-0a79904dc4c9@gmail.com>
Date: Sun, 9 Sep 2018 16:52:24 -0700
MIME-Version: 1.0
In-Reply-To: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/18 10:04, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
>>
>>> A long shot, but something to consider, is that I failed to cover the
>>> cases of dynamic devicetree updates (removing nodes that contain a
>>> phandle) in ways other than overlays.  Michael Ellerman has reported
>>> such a problem for powerpc/mobility with of_detach_node().  A patch to
>>> fix that is one of the tasks I need to complete.
>>
>> The only thing I can think of is booting via the BootX bootloader on
>> those ancient macs results in a DT with no phandles. I didn't see an
>> obvious reason why that would cause that patch to break though.
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
> 
> Cheers,
> Ben.

Thanks for chasing after this, and the current heads up.

I agree that we need to understand what is going on and do a real
fix.

-Frank

Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKNZ512RFzDvvr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 01:20:12 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH] of: base: add support to get machine model name
Date: Thu, 17 Nov 2016 15:13:53 +0100
Message-ID: <2202339.ajrKjCY7Ro@wuerfel>
In-Reply-To: <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
 <3670336.mMHByOpDl4@wuerfel> <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, November 17, 2016 2:08:30 PM CET Sudeep Holla wrote:
> On 17/11/16 13:50, Arnd Bergmann wrote:
> > On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
> >> Currently platforms/drivers needing to get the machine model name are
> >> replicating the same snippet of code. In some case, the OF reference
> >> counting is either missing or incorrect.
> >>
> >> This patch adds support to read the machine model name either using
> >> the "model" or the "compatible" property in the device tree root node.
> >>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I like the idea. One small comment:
> >
> 
> Thanks. I prefer it as single patch but it can't be applied to any tree.
> Any suggestions on handling this patch to fix the warning in -next ?
> 
The patch that causes the warning is currently in the mmc tree, and I
don't think it would be good to have your entire patch in there too.

It's probably best to just fix the warning there now by adding another
open-coded copy of that function, and then apply your patch on top
for v4.11.

	Arnd

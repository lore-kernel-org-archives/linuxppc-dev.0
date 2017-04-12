Return-Path: <srs0=fsug=3u=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w35401hYJzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:53:36 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w35400msRz8t6N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:53:36 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w353y6vl7z9sN9
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 23:53:34 +1000 (AEST)
Message-ID: <1492005205.7236.63.camel@kernel.crashing.org>
Subject: Re: EEH error in doing DMA with PEX 8619
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: IanJiang <ianjiang.cn@gmail.com>, linuxppc-dev@ozlabs.org
Date: Wed, 12 Apr 2017 23:53:25 +1000
In-Reply-To: <CAFE2VE+pm=bBVBx3Ws08kcKGhZO+BaxJcmskjg4DFjNKHQj-9w@mail.gmail.com>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan> <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com> <20170411044238.GA8157@gwshan>
 <1491902810921-121181.post@n7.nabble.com>
 <1491903331.4166.240.camel@kernel.crashing.org>
 <CAFE2VE+pm=bBVBx3Ws08kcKGhZO+BaxJcmskjg4DFjNKHQj-9w@mail.gmail.com>
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

On Wed, 2017-04-12 at 01:42 -0700, IanJiang wrote:
> 
> In my test, DMA buffers are allocated with  (bus 2, device 1, function 
> 0) in module Plx8000_NT, but DMA is issued by (bus 1 device 0 function 
> 1) in module Plx8000_DMA. And error of (bus 1 device 0 function 1) is 
> reported by EEH. 

This is going to break on other systems too. If you enable strict iommu
on x86 for example.

You need to ensure that DMA are allocated for the same requester ID
that will be performing the transactions.

Cheers,
Ben.

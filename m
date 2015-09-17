Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25B7C1A02B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:47:35 +1000 (AEST)
Message-ID: <1442483254.26748.5.camel@ellerman.id.au>
Subject: Re: [PATCH] arch-powerpc: Return false instead of -EFAULT
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2015 19:47:34 +1000
In-Reply-To: <1442481536-11088-1-git-send-email-peter.senna@gmail.com>
References: <1442481536-11088-1-git-send-email-peter.senna@gmail.com>
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

On Thu, 2015-09-17 at 11:18 +0200, Peter Senna Tschudin wrote:
> Returning a negative value for a boolean function seem to have the
> undesired effect of returning true. Replace -EINVAL by false in a
> bool-returning function.
> 
> The diff of the .s file before and after the change (using cross
> compilation) starts with:
> 
> 440,441c440,441
> < .L43:
> < 	li 3,1	 # D.25775,
> ---
> > .L42:
> > 	li 3,0	 # D.25775,
> ...
> 
> while if -EFAULT is replaced by true, the diff is empty.

Ah, that's rather unfortunate.

Can you post the full asm listing, for all three cases?

cheers

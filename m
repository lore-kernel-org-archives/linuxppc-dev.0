Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E8561A0140
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 12:15:20 +1100 (AEDT)
Date: Tue, 3 Mar 2015 18:35:31 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH v2 3/5] crypto: talitos: Fix off-by-one and use all
 hardware slots
Message-ID: <20150303183531.312a8d332b1b776764a15a47@freescale.com>
In-Reply-To: <1425388897-5434-4-git-send-email-mort@bork.org>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-4-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  3 Mar 2015 08:21:35 -0500
Martin Hicks <mort@bork.org> wrote:

> The submission count was off by one.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
> ---
sadly, this directly contradicts:

commit 4b24ea971a93f5d0bec34bf7bfd0939f70cfaae6
Author: Vishnu Suresh <Vishnu@freescale.com>
Date:   Mon Oct 20 21:06:18 2008 +0800

    crypto: talitos - Preempt overflow interrupts off-by-one fix

My guess is your request submission pattern differs from that of
Vishnu's (probably IPSec and/or tcrypt), or later h/w versions have
gotten better about dealing with channel near-overflow conditions.
Either way, I'd prefer we not do this: it might break others, and
I'm guessing doesn't improve performance _that_ much?

If it does, we could risk it and restrict it to SEC versions 3.3 and
above maybe?  Not sure what to do here exactly, barring digging up
and old 2.x SEC and testing.

Kim

p.s. I checked, Vishnu isn't with Freescale anymore, so I can't
cc him.

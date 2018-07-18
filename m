Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vqvf5cj7zF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 18:25:02 +1000 (AEST)
Subject: Re: [PATCH] ipmi/powernv: Fix spurious warnings at boot
To: "William A. Kennington III" <wak@google.com>, linuxppc-dev@lists.ozlabs.org
References: <20180615183332.249253-1-wak@google.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <a438c7ee-cd8b-fd4b-6288-2a1864fb33ec@ozlabs.org>
Date: Wed, 18 Jul 2018 16:25:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180615183332.249253-1-wak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi William,

> Sometimes we have stale messages showing up in the recv queue that are
> being processed by the pollers. We don't want to print out warnings for
> these messages not having an outstanding request as they can be expected
> when doing a kexec from the petitroot environment or from another
> running kernel.

OK, makes sense to do. The in_drain state partially shadows the value of
!smi->cur_msg; we may be able to use that instead.

This means that we'll no longer warn when getting an IPMI message after
the first successful send occurs, but do we really care about that
anyway? We could just drop those silently...

Cheers,


Jeremy
